from flask import Flask, Request, jsonify, request, render_template, Response
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from flask_migrate import Migrate
from flask_admin.contrib.sqla import ModelView
from flask_admin import Admin
from flask_bcrypt import Bcrypt
from sqlalchemy.engine import result
from config import Config
from dotenv import load_dotenv
import json
import os

# env = open(".env", "r")
# print(env.read())

load_dotenv()


FLASK_APP = os.getenv('FLASK_APP')
FLASK_ENV = os.getenv('FLASK_ENV')
SECRET_KEY = os.getenv('SECRET_KEY')
DATABASE = os.getenv('DATABASE')

POD_NAME = os.environ.get('POD_NAME')
POD_NAMESPACE = os.environ.get('POD_NAMESPACE')
# LABELS = os.environ.get('LABELS')
# ANNOTATIONS = os.environ.get('ANNOTATIONS')
# CONTAINER_REQUEST_CPU = os.environ.get('CONTAINER_CPU_REQUEST_MILLICORES')
NODE_NAME = os.environ.get('NODE_NAME')
POD_IP = os.environ.get('POD_IP')
POD_SERVICE_ACCOUNT_NAME = os.environ.get('SERVICE_ACCOUNT')


app = Flask(__name__)
# app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:////tmp/test.db"

app.config.from_object(Config)
db = SQLAlchemy(app)
ma = Marshmallow(app)
migrate = Migrate(app, db)


class User(db.Model):
    __tablename__ = "users"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(50), nullable=True)
    username = db.Column(db.String(400), nullable=True)
    favorite_tech = db.Column(db.Integer, db.ForeignKey("favorite_tech.id"))

    def __repr__(self):
        return f'{self.name}'

class FavoriteTech(db.Model):
    __tablename__ = "favorite_tech"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(50), nullable=True)
    description = db.Column(db.String(400), nullable=True)
    users = db.relationship("User", backref="users")

    def __repr__(self):
        return f'{self.name}'




class UserSchema(ma.Schema):
    class Meta:
        model = User
        fields = ('id', 'name', 'username', 'favorite_tech')

class FavoriteTechSchema(ma.Schema):
    class Meta:
        model = FavoriteTech
        fields = ('id', 'name', 'description', 'users')



@app.route('/api/users', methods=['GET', 'POST'])
def users():
    if request.method == 'GET':
        all_users = User.query.all()
        users_schema = UserSchema(many=True)
        result = users_schema.dump(all_users)
        return jsonify(result)

    elif request.method == 'POST':
        req_data = json.loads(request.data)
        name = req_data['name']
        username = req_data['username']
        favorite_tech = req_data['favoriteTech']

        new_user = User()
        new_user.name = name
        new_user.username = username

        if db.session.query(FavoriteTech).filter(FavoriteTech.name == favorite_tech).first():
            new_favorite_tech = db.session.query(FavoriteTech).filter(FavoriteTech.name == favorite_tech).first()
        else:
            new_favorite_tech = FavoriteTech()
            new_favorite_tech.name = favorite_tech
            description = req_data['description'] if 'description' in req_data and req_data['description'] else "none"
            new_favorite_tech.description = description

        db.session.add(new_favorite_tech)
        db.session.commit()

        new_user.favorite_tech = new_favorite_tech.id

        db.session.add(new_user)
        db.session.commit()

        user_schema = UserSchema()
        return user_schema.jsonify(new_user)


@app.route('/ready', methods=['GET'])
def ready():
    return Response("{'message':'Healthy'}", status=200, mimetype='application/json')



####################
# App Routes
####################

@app.route('/', methods=['GET', 'POST'])
def index():
    all_users = db.session.query(User).all()
    all_tech = db.session.query(FavoriteTech).all()
    is_users = len(all_users) > 0
    return render_template('index.html', users=all_users, is_users=is_users, all_tech=all_tech, POD_IP=POD_IP, POD_SERVICE_ACCOUNT_NAME=POD_SERVICE_ACCOUNT_NAME, NODE_NAME=NODE_NAME, POD_NAME=POD_NAME, POD_NAMESPACE=POD_NAMESPACE)

@app.route('/admin', methods=['GET'])
def admin():
    return 'admin/master.html'


###################
# Flask Admin Site
###################

class UserModelView(ModelView):
    column_searchable_list = ['name', 'username']
    column_filters = ['name']

class FavoriteTechModelView(ModelView):
    column_searchable_list = ['name']
    column_filters = ['name']

admin = Admin(app, name='Flask App Admin', template_mode='bootstrap3')
admin.add_view(UserModelView(User, db.session))
admin.add_view(FavoriteTechModelView(FavoriteTech, db.session))


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')
