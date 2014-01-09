#!/bin/bash
TMP_ERR=$(/bin/mktemp)
TMP_OUT=$(/bin/mktemp)
/usr/bin/timeout -k 4s 3s docker run -entrypoint=/bin/bash -u=nobody -v=/docker/shared:/docker/shared:rw cw_mono_srv.index.orchardup.com/v1 /usr/local/bin/csharp "$1" 2> "$TMP_ERR" > "$TMP_OUT"
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
rm -f "$TMP_ERR"
rm -f "$TMP_OUT"
rm -f "$1"
echo "{\"out\":\"${out}\", \"err\":\"${err}\", \"timeout\":${timeout}}"
