from flask import Blueprint, request, jsonify, make_response
import json
from src import db


restaurants = Blueprint('retaurants', __name__)


#Test
@restaurants.route('/')
def newhome():
    return ('<h1>TEST</h1>')


@restaurants.route('/names', methods = ['POST'])
def restaurantnames():
    cursor = db.get_db().cursor()
    cursor.execute('select name from Restaurant')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response