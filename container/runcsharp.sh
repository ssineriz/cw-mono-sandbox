#!/bin/bash
TMP_ERR=$(/bin/mktemp)
TMP_OUT=$(/bin/mktemp)
TMP_IN=$(/bin/mktemp)
chmod o+r "$TMP_IN"
read -d EOF line
echo "$line" > "$TMP_IN" 
/usr/bin/timeout -k 4s 3s su nobody /usr/local/bin/csharp "$TMP_IN" 2> "$TMP_ERR" > "$TMP_OUT"
if   [ $? -eq 124 ] 
then
	# timeout
	if [ -s "$TMP_ERR" ]
	then
		err=$(cat "$TMP_ERR" | sed -e 's/\"/\\\"/g')
		out=""
		timeout="false"
	else
		err="Code Timeout"
		out=""
		timeout="true"
	fi
else
	err=$(cat "$TMP_ERR" | sed -e 's/\"/\\\"/g')
	out=$(cat "$TMP_OUT" | sed -e 's/\"/\\\"/g')
	timeout="false"
fi
rm "$TMP_ERR"
rm "$TMP_OUT"
rm "$TMP_IN"
echo "{\"out\":\"${out}\", \"err\":\"${err}\", \"timeout\":${timeout}}"