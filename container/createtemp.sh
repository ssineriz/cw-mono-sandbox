#!/bin/bash
TMP=$(/bin/mktemp)
chmod o+r "$TMP"
echo "$TMP"