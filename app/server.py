#!/usr/bin/env python3

import os
import signal
import sys
from flask import Flask, Response

APP_NAME = os.getenv('APP_NAME', 'airtasker')
PORT = int(os.getenv('PORT', 3000))

app = Flask(__name__)

@app.route('/')
def root():
    return Response(APP_NAME, mimetype='text/plain')

@app.route('/healthcheck')
def healthcheck():
    return Response('OK', mimetype='text/plain')

@app.route('/health')
def health():
    return Response('OK', mimetype='text/plain')

def signal_handler(signum, frame):
    print(f"Received signal {signum}, shutting down...")
    sys.exit(0)

def main():
    signal.signal(signal.SIGTERM, signal_handler)
    signal.signal(signal.SIGINT, signal_handler)
    
    print(f"Server starting on port {PORT}")
    print(f"APP_NAME: {APP_NAME}")
    
    app.run(host='0.0.0.0', port=PORT, debug=False)

if __name__ == '__main__':
    main() 