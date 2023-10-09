#!/usr/bin/env bash
set -e
set -o pipefail

info() {
	printf '\n## %s\n' "$*"
}

raw_diff() {
	git diff -U0 "$@" -- index.yaml | sed -re '0,/^@@ /d; /^@@ /d'
}

is_updated() {
	raw_diff --word-diff HEAD | grep -Pqv '^(generated|\s+created):'
}

info 'Updating index...'
git reset HEAD
helm repo index .

if ! is_updated; then
	info 'No changes detected.'
	exit 0
fi

info 'Commit index changes...'
GIT_EDITOR=.github/clean-index-patch.sh git add -e index.yaml
git commit -m "Update Helm chart index"

info 'Committed index changes:'
git show HEAD

info 'Checking update correctness...'
# the commit should not contain any removed lines except of generated field
if raw_diff 'HEAD~1..HEAD' | grep -Pq '^-(?!generated:)'; then
	info 'Abort due to unexpectedly removed lines from the updated index.'
	git diff 'HEAD~1..HEAD' -- index.yaml
	exit 1
fi
# the update should make result in any committable changes
helm repo index .
if is_updated; then
	info 'Abort due to missing changes in the updated index.'
	git diff HEAD -- index.yaml
	exit 1
fi


if [[ -n ${GITHUB_REF_NAME:-} ]]; then
	info 'Pushing changes...'
	git push origin "HEAD:$GITHUB_REF_NAME"
fi

info 'Done.'
exit 0
