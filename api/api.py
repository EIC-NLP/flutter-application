from flask import Flask
from flask_sockets import Sockets
import json

app = Flask(__name__)
sockets = Sockets(app)

@sockets.route('/ws')
def ws_page(ws):
    while True:
        message = ws.receive()
        if message:
            data = json.loads(message)
            if data['page'] in ['chat', 'transcription', 'landing']:
                # Do some processing with the data
                # For example, send it to all connected clients
                # You can also send a message to a specific client using their WebSocket connection
                ws.send(json.dumps({'message': 'Received your data!', 'page': data['page']}))

if __name__ == '__main__':
    from gevent import pywsgi
    from geventwebsocket.handler import WebSocketHandler

    server = pywsgi.WSGIServer(('127.0.0.1', 5000), app, handler_class=WebSocketHandler)
    print('Server running...')
    server.serve_forever()
