 #!/bin/bash
TMP=$(/bin/mktemp)
out=$(/usr/bin/timeout -k 4s 3s /usr/local/bin/csharp 2> "$TMP" | sed -e 's/\"/\\\"/g)
timeout="false"
 if   ["$?" -eq 124]
	# Timeout
	then
		err="Code Timeout"
		timeout="true"
	else
		err=$(cat "$TMP" | sed -e 's/\"/\\\"/g)	
fi
rm "$TMP"
echo "{\"out\":\"${out}\", \"err\":\"${err}\", \"timeout\":${timeout}}"
