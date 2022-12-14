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


#Gets all the orderline from the database
@customers.route('/orderline', methods=['GET'])
def get_orderline_info():
    cursor = db.get_db().cursor()
    cursor.execute('Select * FROM OrderLine o JOIN Item i ON o.item_id = i.item_id')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


#Adds a new orderline to the database and updates the total_price of the order
@customers.route('/newOrderline', methods = ['POST'])
def add_orderline():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    item_id = request.form ['item_id']
    quantity = request.form['quantity']
    price = request.form['price']
    line_price = int(quantity) * int(price)
    cursor.execute('Select * FROM Orders where order_id = 1')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    current_app.logger.info(json_data)
    prev_total = 0
    the_response = (jsonify(json_data))
    for r in json_data:

        if(int(r['order_id']) == 1):
            prev_total += int(r['total_price'])

    current_app.logger.info(prev_total)
    new_total = prev_total + line_price
    current_app.logger.info(new_total)
    cursor.execute('Update Orders Set total_price={0} Where order_id=1'.format(new_total))
    order_id = request.form['order_id']
    query2 = f'INSERT INTO OrderLine(item_id, quantity, price, order_id)  VALUES(\"{item_id}\", \"{quantity}\", \"{price}\", \"{order_id}\")'
    cursor.execute(query2)
    db.get_db().commit()
    return "Success!"

