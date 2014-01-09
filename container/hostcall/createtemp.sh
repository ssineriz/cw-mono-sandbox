#!/bin/bash
TMP=$(/bin/mktemp --tmpdir=/docker/shared)
chmod o+rw "$TMP"
echo "$TMP"