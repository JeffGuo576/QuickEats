# MySQL + Flask Boilerplate Project

This repo contains a boilerplate setup for spinning up 2 docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the `webapp` user. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

## For setting up a Conda Web-Dev environment:

1. `conda create -n webdev python=3.9`
1. `conda activate webdev`
1. `pip install flask flask-mysql flask-restful cryptography flask-login`

## Project
Quickeats is an online food delivery servce that utilizes self-employed drivers to deliver ordered food from restaurants to customers. The customers place orders for menu items at participating restaurants, which is then available for pickup by drivers. The company earns a percentage of the order delivered. With this product we hope to offer a simple alternative delivery option for restaurants that previously did not. We also provide a central platform for hungry customers to easily obtain food from their favorite participating restaurants.

##How to use the Appsmith application

For the customer interface:
The table holds the list of restaurants and its information. You can filter the restaurants through its name, cuisine, rating or city. Select the restaurant you want to order from and click the button "Click to Order" to view its menu items. Then you click on the list of menu items and enter the quantity of the item you want. Once you submit it, it will add it to the cart.

For the driver interface:
An order will pop up with the details of the restaurant address and the customer address. You click on the deliver button to accept the order which leads to new window of the customers information. After completing delivery, you will press delivered and it will send you back to the original page until another order pops up again.

For the restaurant interface:
It is defaulted to the restaurant menu items and the profits of each menu item. Then when you press the menu button on the right, it will send you to a new window that allows you to add a new item to the restaurant menu. You include the item name, category of the item and the price. When you press submit it, it will add the new item to the menu associated with the restaurant. If you want to go back to the profits, you click on the profit button.


##Routes
customers.py 

127.0.0.1:8001/cust/customers Gets all the customers from the database

drivers.py
127.0.0.1:8001/driv/order/<orderID> Gets the order details from a specific order id

127.0.0.1:8001/driv/orderaddress/<orderID> Gets the customer address from a specific order id

127.0.0.1:8001/driv/distance/<orderID> Gets the distance from a specific order id

restaurants.py

127.0.0.1:8001/rest/restinfo  Gets all the restaurants from the database

127.0.0.1:8001/rest/restaurant/<restID> Gets all the restaurants details from a specific restaurant id

127.0.0.1:8001/rest/menuItems/<restID> Gets the menu items details from a specific restaurant id

127.0.0.1:8001/rest/menuanditems Gets all the menu and restaurants from the database

127.0.0.1:8001/rest/newItem Allows the restaurant to add a new item to their menu
