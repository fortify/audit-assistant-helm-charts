#!/usr/bin/env bash

sed -i -nre '/^-\s*created:/{h;n;/^[+]\s*created:/{x;p;s/^-/+/;be};x;p;x;:e};p' "$1"
cat "$1"
