#!/bin/bash
# -D: no tcp response delay
# -R: no reverse dns lookup
# -c 150 : up to 150 concurrent connections
# -u, -g: user/group  running commands -u 65534 -g 65534
# 7777: exposed tcp port
/usr/bin/tcpserver -D -c 150 -R -u 0 -g 0 0.0.0.0 7777 /usr/local/bin/runcsharp.sh 2>&1
