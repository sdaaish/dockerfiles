#!/usr/bin/env bash

# Remove man-pages and docs

find /usr/share/doc -depth -type f ! -name copyright -print0|xargs -0 rm || true
find /usr/share/doc -empty -print0|xargs -0 rmdir || true
rm -rf /usr/share/groff/* /usr/share/info/*
rm -rf /usr/share/lintian/* /usr/share/linda/* /var/cache/man/*
rm -rf /usr/share/man/*
