from flask import Blueprint

drivers = Blueprint('drivers', __name__)

# This is a base route
# we simply return a string.  
@drivers.route('/')
def home():
    return ('<h1>Hello from your web app!!</h1>')

# Gets the particular detail of an order with particular orderID
@drivers.route('/restaurant/<orderID>', methods=['GET'])
def get_restaurant_info(orderID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Orders where order_id = {0}'.format(orderID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response