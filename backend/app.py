from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Allow access from Flutter app

# Example "database" (can be replaced later with real DB)
DATA = {
    "123456789": {"name": "Alice", "registration_status": "Valid"},
    "987654321": {"name": "Bob", "registration_status": "Expired"},
}

@app.route("/lookup", methods=["POST"])
def lookup():
    body = request.get_json()
    nfc_id = body.get("nfc_id")
    result = DATA.get(nfc_id)
    if result:
        return jsonify({"status": "ok", "data": result})
    else:
        return jsonify({"status": "error", "message": "NFC tag not found"}), 404

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
