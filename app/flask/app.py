from flask import Flask, Request, jsonify, request, render_template
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from flask_migrate import Migrate
from flask_admin.contrib.sqla import ModelView
from flask_admin import Admin
from flask_bcrypt import Bcrypt
from sqlalchemy.engine import result
from config import Config
import json



app = Flask(__name__)

app.config.from_object(Config)
db = SQLAlchemy(app)
ma = Marshmallow(app)
migrate = Migrate(app, db)


class User(db.Model):
    __tablename__ = "users"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(50), nullable=True)
    username = db.Column(db.String(400), nullable=True)

    def __repr__(self):
        return f'{self.name}'

class FavoriteTech(db.Model):
    __tablename__ = "favorite_tech"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(50), nullable=True)
    description = db.Column(db.String(400), nullable=True)

    def __repr__(self):
        return f'{self.name}'


class UserSchema(ma.Schema):
    class Meta:
        model = User
        fields = ('id', 'name', 'username', 'favorite_tech')


class FavoriteTechSchema(ma.Schema):
    class Meta:
        model = FavoriteTech
        fields = ('id', 'name', 'description')



@app.route('/api/users', methods=['GET', 'POST'])
def user_list():
    if request.method == 'GET':
        all_users = User.query.all()
        users_schema = UserSchema(many=True)
        result = users_schema.dump(all_users)
        return jsonify(result)

    elif request.method == 'POST':
        req_data = json.loads(request.data)
        name = req_data['name']
        description = req_data['description']

        new_user = User()
        new_user.name = name
        new_user.description = description

        db.session.add(new_user)
        db.session.commit()
        user_schema = UserSchema()
        return user_schema.jsonify(new_user)


@app.route('/')
def index():
    return render_template('index.html')


admin = Admin(app, name='Flask App Admin', template_mode='bootstrap3')
# admin.add_view(ModelView(User, db.session))
# admin.add_view(ModelView(FavoriteTech, db.session))


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')
