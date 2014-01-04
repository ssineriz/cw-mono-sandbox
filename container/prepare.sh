# used to tackle the 42 layers limit in docker 

# make sure the package repository is up to date
echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
apt-get update

# install ucspi-tcp for tcpserver
apt-get install -y ucspi-tcp

# install iptables for basic firewalling
apt-get install -y iptables

# get server.sh
wget -O /usr/local/bin/server.sh https://github.com/ssineriz/cw-mono-sandbox/raw/master/container/server.sh

# get runcsharp.sh
wget -O /usr/local/bin/runcsharp.sh https://github.com/ssineriz/cw-mono-sandbox/raw/master/container/runcsharp.sh

# get ServiceStack.Text.dll
wget -O /usr/local/lib/mono/4.5/ServiceStack.Text.dll https://github.com/ssineriz/cw-mono-sandbox/raw/master/lib/ServiceStack.Text.dll

# get CodeWars.CSharp.TestFramework.dll
# this is the compiled version of https://github.com/edokan/kata-test-framework-csharp (without test units and debug code)
wget -O /usr/local/lib/mono/4.5/CodeWars.CSharp.TestFramework.dll https://github.com/ssineriz/cw-mono-sandbox/raw/master/lib/CodeWars.CSharp.TestFramework.dll

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
