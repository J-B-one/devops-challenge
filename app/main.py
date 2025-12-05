from flask import Flask, request
import logging
import json

app = Flask(__name__)
logging.basicConfig(level=logging.INFO)

@app.route("/registrar", methods=["POST"])
def registrar():
    data = request.json
    logging.info(f"Solicitud recibida: {data}")
    logging.info("Los datos serían enviados a la BD en el entorno cloud.")
    return {"estado": "ok"}

@app.route("/", methods=["GET"])
def home():
    return {"status": "online"}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
