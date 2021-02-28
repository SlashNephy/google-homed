import os
import json
import hashlib
from datetime import datetime

import pychromecast
from flask import Flask, request, send_from_directory, jsonify
from gtts import gTTS

SERVER_HOST = os.getenv("SERVER_HOST", "0.0.0.0")
SERVER_PORT = int(os.getenv("SERVER_PORT", "5257"))
GOOGLE_HOME_IP_ADDRESS = os.getenv("GOOGLE_HOME_IP_ADDRESS", "0.0.0.0")
DEFAULT_LANG = os.getenv("DEFAULT_LANG", "ja")
TMP_DIR = os.getenv("TMP_DIR", "/tmp/google-homed")
NIGHT_HOURS = [int(x) for x in os.getenv("NIGHT_HOURS", "1,2,3,4,5,6").split(",")]

app = Flask(__name__)
device = pychromecast.Chromecast(GOOGLE_HOME_IP_ADDRESS)

@app.route("/file/<path:filename>")
def send_cache(filename):
    return send_from_directory(TMP_DIR, filename)

@app.route("/speak", methods=["GET", "POST"])
def speak():
    if is_night_mode_enabled():
        return jsonify({"success": False, "message": "Currently, night mode is enabled."})

    if request.method == "GET":
        param = request.args
    else:
        try:
            param = json.loads(request.data)
        except:
            return jsonify({"success": False, "message": "Request JSON payload is invalid."})

    text = param.get("text")
    lang = param.get("lang") or DEFAULT_LANG

    if not text:
        return jsonify({"success": False, "message": "Essential parameter \"text\" is not present."})

    try:
        filename = f"{hashlib.sha1(text.encode()).hexdigest()}.mp3"
        path = os.path.join(TMP_DIR, filename)

        if not os.path.exists(path):
            tts = gTTS(text=text, lang=lang)
            tts.save(path)

        device.wait()
        device.media_controller.play_media(f"http://{SERVER_HOST}:{SERVER_PORT}/file/{filename}", "audio/mp3")
        device.media_controller.block_until_active()

        return jsonify({"success": True, "message": f"Played \"{text}\" in {lang}."})
    except Exception as e:
        print(e)
        return jsonify({"success": False, "message": "Error occurred while playing."})

def is_night_mode_enabled() -> bool:
    return datetime.now().hour in NIGHT_HOURS

if __name__ == "__main__":
    if not os.path.isdir(TMP_DIR):
        os.makedirs(TMP_DIR)

    device.wait()
    print(f"ChromeCast device is ready. ({GOOGLE_HOME_IP_ADDRESS})")

    app.run(host="0.0.0.0", port=SERVER_PORT)
