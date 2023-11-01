from flask import Flask, jsonify, request
from flask_socketio import SocketIO, emit
from flask_cors import CORS

app = Flask(__name__)
socketio = SocketIO(app, cors_allowed_origins='*')
cors = CORS(app, resources={r"/data": {"origins": "*"}})

@socketio.on('connect')
def ws_page():
    if socketio.connected:
        print('Client connected')
        emit('connected', {'data': 'Connected'})
    else:
        print('Client not connected')

@socketio.on('disconnect')
def ws_disconnect():
    print('Client disconnected')

@app.route('/data', methods=['POST'])
def receive_data():
    data = request.get_json()
    if all(key in data for key in ['page', 'command', 'content']):
        # Send the data to all connected clients via SocketIO
        emit('data', {'page': data['page'], 'command': data['command'], 'content': data['content']}, broadcast=True, namespace='/data')
        # Process the data as needed
        # For example, you can save it to a database or perform some other action
        return jsonify({'message': 'Received your data!', 'page': data['page'], 'command': data['command'], 'content': data['content']})

if __name__ == '__main__':
    app.run(debug=True, host='127.0.0.1', port=6969)