from flask import Blueprint

drivers = Blueprint('drivers', __name__)

# This is a base route
# we simply return a string.  
@drivers.route('/')
def home():
    return ('<h1>Hello from your web app!!</h1>')

# This is a sample route for the /test URI.  
# as above, it just returns a simple string. 
@drivers.route('/test')
def tester():
    return "<h1>this is a test!</h1>"