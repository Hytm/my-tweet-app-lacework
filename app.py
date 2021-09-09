from flask import Flask, render_template
import random
import platform

app = Flask(__name__)

# list of cat images
images = [
    "https://raw.githubusercontent.com/jeromebaude/my-tweet-app-lacework/master/Pictures/la110.png",
    "https://raw.githubusercontent.com/jeromebaude/my-tweet-app-lacework/master/Pictures/PNGFILE-01.png",
    "https://raw.githubusercontent.com/jeromebaude/my-tweet-app-lacework/master/Pictures/NoRulesShirtPNG.png",
    "https://raw.githubusercontent.com/jeromebaude/my-tweet-app-lacework/master/Pictures/D136Beachoopwithoutman.png"
]

@app.route('/')
def index():
    url = random.choice(images)
    hostname = platform.node()
    return render_template('index.html', url=url, hostname=hostname)

if __name__ == "__main__":
    app.run(host="0.0.0.0")
