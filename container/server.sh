#!/bin/bash
# -D: no tcp response delay
# -R: no reverse dns lookup
# -c 150 : up to 150 concurrent comands
# -u, -g: user/group  running commands
# 7777: exposed tcp port
/usr/bin/tcpserver -D -c 150 -R -u 65534 -g 65534 0.0.0.0 7777 /usr/local/bin/runcsharp.sh
