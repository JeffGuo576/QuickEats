from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

drivers = Blueprint('drivers', __name__)

# Gets the particular detail of an order with particular orderID
@drivers.route('/order/<orderID>', methods=['GET'])
def get_order_info(orderID):
    cursor = db.get_db().cursor()
    cursor.execute('Select * FROM Orders WHERE order_id = {0}'.format(orderID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Gets the customer address from the specific orderID
@drivers.route('/orderaddress/<orderID>', methods=['GET'])
def get_order_address(orderID):
    cursor = db.get_db().cursor()
    cursor.execute('Select c.street, c.city, c.state, c.zip_code FROM Customer c JOIN Orders o ON c.customer_id = o.customer_id WHERE order_id = {0}'.format(orderID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Gets the distance of the specific order
@drivers.route('/distance/<orderID>', methods=['GET'])
def get_order_distance(orderID):
    cursor = db.get_db().cursor()
    cursor.execute('Select * FROM Trip t JOIN Driver d ON t.driver_id = d.driver_id JOIN Orders o ON d.driver_id = o.driver_id WHERE order_id = {0}'.format(orderID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response