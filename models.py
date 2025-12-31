from flask_migrate import Migrate
from flask_sqlalchemy import SQLAlchemy

migrate = Migrate()
db = SQLAlchemy()

class User(db.Model):
  __tablename__ = "users"

  id = db.Column(db.Integer, primary_key=True, nullable=True, unique=True)
  username = db.Column(db.String(20), nullable=True, unique=True)
  password = db.Column(db.String, nullable=False)
  first_name = db.Column(db.String, nullable=False)
  last_name = db.Column(db.String, nullable=True)
  age = db.Column(db.Integer, nullable=False)
  bio = db.Column(db.String(300), nullable=True)