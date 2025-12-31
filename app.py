from flask import Flask
from flask_cors import CORS
from api_init import api
from models import migrate, db, User

app = Flask(__name__)
app.config["SECRET_KEY"] = "abcdefg12345678"
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///database.db"
app.url_map.strict_slashes = False

CORS(
    app,
    resources={r"/*": {
        "origins": ["https://5wdnpf3r-4200.asse.devtunnels.ms"],
        "methods": ["GET", "POST", "PATCH", "DELETE", "OPTIONS"],
        "allow_headers": ["Content-Type", "Authorization"],
        "supports_credentials": True
    }}
)
api.init_app(app)
migrate.init_app(app, db)
db.init_app(app)

if __name__ == "__main__":
  app.run(port=5000, debug=True)
