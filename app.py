from flask import Flask, url_for, send_from_directory, abort
from flask_cors import CORS
from api_init import api
from models import migrate, db, login, User
import os

app = Flask(__name__, static_folder="frontend/dist", static_url_path='/static')
app.config["SECRET_KEY"] = "abcdefg12345678"
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///database.db"
app.url_map.strict_slashes = False

CORS(
    app,
    resources={r"/api/*": {  # Only apply CORS to API routes
        "origins": ["https://5wdnpf3r-4200.asse.devtunnels.ms"],
        "methods": ["GET", "POST", "PATCH", "DELETE", "OPTIONS"],
        "allow_headers": ["Content-Type", "Authorization"],
        "supports_credentials": True
    }}
)

api.init_app(app)
migrate.init_app(app, db)
db.init_app(app)
login.init_app(app)

# Catch-all route for SPA - only serve index.html for non-API, non-static requests
@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def catch_all(path):
  # API routes stay API
  if path.startswith('api/'):
    abort(404)

  # Let Flask serve real files if they exist
  full_path = os.path.join(app.static_folder, path)
  if path != "" and os.path.exists(full_path):
    return send_from_directory(app.static_folder, path)

  # Otherwise, serve the Ember app
  return send_from_directory(app.static_folder, 'index.html')


# if __name__ == "__main__":
#   app.run(port=5000, debug=True)