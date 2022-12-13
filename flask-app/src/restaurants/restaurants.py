from flask import Blueprint, request, jsonify, make_response
import json
from src import db


restaurants = Blueprint('restaurants', __name__)


#Test
@restaurants.route('/')
def newhome():
    return ('<h1>TEST</h1>')


@restaurants.route('/restinfo', methods = ['GET'])
def restaurantnames():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Restaurant')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get the particular detail of a customer with particular restID
@restaurants.route('/restaurant/<userID>', methods=['GET'])
def get_restaurant_info(restID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Restaurant where restaurant_id = {0}'.format(restID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

#
@restaurants.route('/menuItems/<restID>', methods=['GET'])
def get_menuItems(restID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT i.name, i.profit FROM Restaurant r JOIN Menu m ON r.restaurant_id = m.restaurant_id JOIN Item i ON m.menu_id = i.menu_id WHERE r.restaurant_id = {0}'.format(restID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response