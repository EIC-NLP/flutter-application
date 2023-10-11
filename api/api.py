from flask import Flask

app = Flask(__name__)

@app.route('/landing')
def landing():
    return 'Landing Page'

@app.route('/chat_box')
def chat_box():
    return 'Chat Box Page'

@app.route('/transcriptions')
def transcriptions():
    return 'Transcriptions Page'

if __name__ == '__main__':
    app.run(debug=True)
