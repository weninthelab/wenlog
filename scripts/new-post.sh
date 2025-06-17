#!/bin/bash

DATE=$(date +%F)

if [ -z "$1" ]; then
    echo "Usage: $0 <slug>"
    exit 1
fi

SLUG=$1
POST_DIR="content/posts"
POST_FILE="$POST_DIR/$SLUG.md"

mkdir -p "$POST_DIR"

if [ -f "$POST_FILE" ]; then
    echo "Error: $POST_FILE already exists!"
    exit 1
fi

cat <<EOF >"$POST_FILE"
+++
title = "$(echo "$SLUG" | sed -r 's/-/ /g' | sed -r 's/\b(.)/\u\1/g')"
description = "Description"
date = $DATE
draft = false

[taxonomies]
categories = [""]
tags = [""]

[extra]
lang = "en"
toc = true
comment = false
copy = true
outdate_alert = false
outdate_alert_days = 120
math = false
mermaid = false
featured = false
reaction = false
+++

Write your content below...
EOF

echo "Created new post at: $POST_FILE"
