#!/bin/bash
TMP_ERR=$(/bin/mktemp)
TMP_OUT=$(/bin/mktemp)
/usr/bin/timeout -k 4s 3s /usr/local/bin/csharp 2> "$TMP_ERR" > "$TMP_OUT"
if   [ $? -eq 124 ] 
then
	# timeout
	err="Code Timeout"
	out=""
	timeout="true"
else
	err=$(cat "$TMP_ERR" | sed -e 's/\"/\\\"/g')
	out=$(cat "$TMP_OUT" | sed -e 's/\"/\\\"/g')
	timeout="false"
fi
rm "$TMP_ERR"
rm "$TMP_OUT"
echo "{\"out\":\"${out}\", \"err\":\"${err}\", \"timeout\":${timeout}}"
