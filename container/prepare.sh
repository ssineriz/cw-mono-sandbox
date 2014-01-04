# used to tackle the 42 layers limit in docker 

# set execute permissions
chmod +x /usr/local/bin/server.sh
chmod +x /usr/local/bin/runcsharp.sh

# set file system permissions
chmod -f o-r /* /.*
chmod -f o-w /tmp

# turn off outgoing network traffic for nobody
iptables -A OUTPUT -m owner --uid-owner 65534 -j DROP

# prepare home settings for nobody. Files in /.config/csharp will be loaded (or executed) before script
usermod -d /home/nobody -m nobody
mkdir -p /home/nobody/.config/csharp
cp /usr/local/lib/mono/4.5/CodeWars.CSharp.TestFramework.dll /home/nobody/.config/csharp/
