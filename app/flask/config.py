from dotenv import load_dotenv
from apispec import APISpec
from apispec.ext.marshmallow import MarshmallowPlugin
from apispec_webframeworks.flask import FlaskPlugin
import os

load_dotenv()
# resolve our environment variables
# ENVIRON = get_resolved_env()


class Config(object):
    ENV = os.getenv('FLASK_ENV')
    SQLALCHEMY_DATABASE_URI = os.getenv("DATABASE_URL", "sqlite:///db.sqlite3")
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    FLASK_ADMIN_SWATCH = 'cerulean'
    SECRET_KEY = os.getenv('SECRET_KEY')
    APP_DIR = os.path.abspath(os.path.dirname(__file__))
    PROJECT_ROOT = os.path.abspath(os.path.join(APP_DIR, os.pardir))
    APISPEC_SPEC = APISpec(
        title='Flask App/ API Swagger Docs',
        version='v1.0.0',
        openapi_version='3.0.2',
        plugins=[FlaskPlugin(), MarshmallowPlugin()],
        info={'description': 'a demo app with a simple form to demonstrate a Flask App and API for handling requests and CRUD.'},
    )
    APISPEC_SWAGGER_UI_URL = '/api/swagger-ui'
    APISPEC_SWAGGER_URL = '/api/swagger'
    # TEST_SQLALCHEMY_DATABASE_URI = app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:////tmp/test.db"



# Can also do DevConfig(BaseConfig): -- where base config is defined above as a regular class
class DevConfig(object):  # pylint: disable=R0903
    """Development Environment Settings"""

    ENV = 'development'
    DEBUG = True
    CACHE_TYPE = 'simple'  # Can be 'memcached', 'redis', etc.
    PROFILER = os.environ.get('ENABLE_PROFILER', '0') == '1'
    PRINT_DEBUG_QUERIES = os.environ.get('PRINT_DEBUG_QUERIES', '0') == '1'


class TestConfig(object):  # pylint: disable=R0903
    """Testing Environment Settings"""

    ENV = 'testing'
    DEBUG = True
    CACHE_TYPE = 'simple'  # Can be 'memcached', 'redis', etc.
