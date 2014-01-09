from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
from SocketServer import ThreadingMixIn
from subprocess import Popen, PIPE
class ThreadedHTTPServer(ThreadingMixIn, HTTPServer):
	pass
class WHandler(BaseHTTPRequestHandler):
	def do_POST(self):
		length = self.headers['content-length']
		data = self.rfile.read(int(length))
		p = Popen(['/usr/local/bin/createtemp.sh'], stdout=PIPE)
		p.wait()
		tmp_file = p.stdout.read()
		with open(tmp_file, 'w') as fh:
			fh.write(data.decode())
		p = Popen(['/usr/local/bin/runcsharp.sh', tmp_file], stdout=PIPE)
		p.wait()
		self.send_response(200)
		self.send_header('Content-type', 'text/json')
		self.end_headers()
		self.wfile.write(p.stdout.read().encode())
server = ThreadedHTTPServer(('', 7777), WHandler)
server.serve_forever()