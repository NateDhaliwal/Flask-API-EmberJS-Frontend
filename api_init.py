from flask import request
from flask_restful import Resource, Api
from models import db, User

api = Api(prefix='/api')

class CurrentUser():
  def get(self):
    return

class Users(Resource):
  def get(self):
    # Gets all users
    users_arr = [
      {
        "type": "users",
        "id": str(user.id),
        "attributes": {
          "username": user.username,
          "first-name": user.first_name,
          "last-name": user.last_name,
          "age": user.age,
          "bio": user.bio
        }
      }
      for user in User.query.all()
    ]

    return {"data": users_arr}, 200

  def post(self):
    payload = request.get_json()
    if not payload or "data" not in payload:
      return {"errors": "Invalid payload"}, 400
    
    try:
      data = payload['data']['attributes']

      new_user_id = list(User.query.all())[-1].id + 1 if len(list(User.query.all())) > 0 else 1

      new_user = User(
        id=new_user_id,
        username=data['username'],
        password=data['password'],
        first_name=data['first-name'],
        last_name=data['last-name'],
        age=data['age'],
        bio=data['bio'],
      )

      db.session.add(new_user)
      db.session.commit()

      return {"data": {
        "type": "users",
        "id": str(new_user.id),
        "attributes": {
          "username": new_user.username,
          "first-name": new_user.first_name,
          "last-name": new_user.last_name,
          "age": new_user.age,
          "bio": new_user.bio
        }}
      }, 201
    except Exception as e:
      return {"errors": str(e)}, 400

class UserPage(Resource):
  def get(self, user_id):
    user = User.query.get(user_id)
    if not user:
      return {'errors': 'Not found'}, 404
    
    return {"data": {
      "type": "users",
      "id": str(user_id),
      "attributes": {
        "username": user.username,
        "first-name": user.first_name,
        "last-name": user.last_name,
        "age": user.age,
        "bio": user.bio
      }}
    }, 200
  
  def patch(self, user_id):
    user = User.query.get(user_id)

    payload = request.get_json()
    if not payload or "data" not in payload:
      return {"errors": "Invalid payload"}, 400
    
    try:
      data = payload['data']['attributes']
      user.username = data['username']
      user.password = data['password']
      user.age = user.age
      user.first_name = data['first-name']
      user.last_name = data['last-name']
      user.bio = data['bio']

      db.session.commit()
    
      return {"data": {
        "type": "users",
        "id": str(user_id),
        "attributes": {
          "username": user.username,
          "first-name": user.first_name,
          "last-name": user.last_name,
          "age": user.age,
          "bio": user.bio
        }}
      }, 200
    except Exception as e:
      return {"errors": str(e)}, 400

  def delete(self, user_id):
    user = User.query.get(user_id)
    db.session.delete(user)
    db.session.commit()
    return "", 204

api.add_resource(Users, "/users")
api.add_resource(UserPage, "/users/<int:user_id>")
