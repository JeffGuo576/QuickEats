from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


restaurants = Blueprint('restaurants', __name__)

#Gets all the information on restaurant in the DB
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

# Get the restaurant details from the restaurant ID
@restaurants.route('/restaurant/<restID>', methods=['GET'])
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

#Gets the menu items from the given restaurant ID
@restaurants.route('/menuItems/<restID>', methods=['GET'])
def get_menuItem(restID):
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

#Gets all the menu items for all restaurants
@restaurants.route('/menuanditems', methods=['GET'])
def menuItems():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Restaurant r JOIN Menu m ON r.restaurant_id = m.restaurant_id JOIN Item i ON m.menu_id = i.menu_id')
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
@restaurants.route('/newItem', methods = ['POST'])
def add_item():
    current_app.logger.info(request.form)
    cursor = db.get_db().cursor()
    itemname = request.form ['itemname']
    itemprice = request.form['itemprice']
    category = request.form['category']
    menuid = request.form['menuid']
    categoryid = request.form['categoryid']
    #Inserts new Category with associated item
    query = f'INSERT INTO Category(name) VALUES(\"{category}\")'
    cursor.execute(query)
    query2 = f'INSERT INTO Item(name, price, menu_id, category_id, profit, amount_sold)  VALUES(\"{itemname}\", \"{itemprice}\", \"{menuid}\",\"{categoryid}\",0,0)'
    cursor.execute(query2)
    db.get_db().commit()
    return "Success!"

    
