from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


customers = Blueprint('customers', __name__)

# Get all customers from the DB
@customers.route('/customers', methods=['GET'])
def get_customers():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Customer')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Get the street detail of a customer with particular userID
@customers.route('/customer/<userID>', methods=['GET'])
def get_customer_info(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Customer where customer_id = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


#Adds a new item to the menu
@customers.route('/newOrderline', methods = ['POST'])
def add_orderline():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    item_id = request.form ['item_id']
    quantity = request.form['quantity']
    price = request.form['price']
    order_id = request.form['order_id']
    query2 = f'INSERT INTO Orderline(item_id, quantity, price, order_id)  VALUES(\"{item_id}\", \"{quantity}\", \"{price}\", \"{order_id}\")'
    cursor.execute(query2)
    db.get_db().commit()
    return "Success!"
