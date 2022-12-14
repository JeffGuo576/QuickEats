CREATE DATABASE quickeats_db;
/*CREATE USER 'webapp'@'%' IDENTIFIED BY MYSQL_PASSWORD_FILE;
*/
GRANT ALL PRIVILEGES ON quickeats_db.* TO 'webapp'@'%';
FLUSH PRIVILEGES;


USE quickeats_db;

CREATE TABLE Customer (
    customer_id INT(9) AUTO_INCREMENT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(100) NOT NULL,
    street TEXT NOT NULL,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    zip_code VARCHAR(100) NOT NULL,
    PRIMARY KEY(customer_id)
);

create table Vehicle (
	vehicle_id int(9) AUTO_INCREMENT NOT NULL PRIMARY KEY,
	color VARCHAR(50) NOT NULL,
	type VARCHAR(50) NOT NULL
);

create table Category (
    category_id int(9) AUTO_INCREMENT NOT NULL PRIMARY KEY,
	name VARCHAR(10) NOT NULL
);

create table PaymentMethod (
    pm_id INT(9) AUTO_INCREMENT NOT NULL,
	card_number BIGINT NOT NULL,
	expiration_date VARCHAR(100) NOT NULL,
	customer_id INT(9) NOT NULL,

    CONSTRAINT pk PRIMARY KEY(pm_id),

    CONSTRAINT fk_01 FOREIGN KEY(customer_id)
       REFERENCES Customer(customer_id)
       ON UPDATE CASCADE
       ON DELETE RESTRICT
);

create table PaymentType (
    pt_id INT(9) AUTO_INCREMENT NOT NULL,
	name VARCHAR(50) NOT NULL,
	pm_id INT(9) NOT NULL,

    CONSTRAINT pk PRIMARY KEY(pt_id),

    CONSTRAINT fk_02 FOREIGN KEY(pm_id)
       REFERENCES PaymentMethod(pm_id)
       ON UPDATE CASCADE
       ON DELETE RESTRICT
);

create table Driver (
	driver_id  int(9) AUTO_INCREMENT NOT NULL,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	phone_number VARCHAR(50) NOT NULL,
    vehicle_id int(9) NOT NULL,
    CONSTRAINT pk PRIMARY KEY(driver_id),
    CONSTRAINT fk_03 FOREIGN KEY(vehicle_id)
       REFERENCES Vehicle(vehicle_id)
       ON UPDATE CASCADE
       ON DELETE RESTRICT
);

create table Restaurant (
	restaurant_id int(9) AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	phone_number VARCHAR(50) NOT NULL,
	rating int(5),
	street VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	state VARCHAR(50) NOT NULL,
	zip_code VARCHAR(50) NOT NULL,
    cuisine VARCHAR(10) NOT NULL
);

create table Trip (
	trip_id int(9) AUTO_INCREMENT NOT NULL,
	distance INT NOT NULL,
    customer_id int(9) NOT NULL,

	restaurant_id int(9) NOT NULL,

	driver_id int(9) NOT NULL,


    CONSTRAINT pk PRIMARY KEY(trip_id),

    CONSTRAINT fk_04 FOREIGN KEY(restaurant_id)
       REFERENCES Restaurant(restaurant_id)
       ON UPDATE CASCADE
       ON DELETE RESTRICT,

    CONSTRAINT fk_05 FOREIGN KEY(customer_id)
       REFERENCES Customer(customer_id)
       ON UPDATE CASCADE
       ON DELETE RESTRICT,

    CONSTRAINT fk_06 FOREIGN KEY(driver_id)
       REFERENCES Driver(driver_id)
       ON UPDATE CASCADE
       ON DELETE RESTRICT
);

create table Orders (
    order_id int(9) AUTO_INCREMENT NOT NULL,
    order_time DATETIME DEFAULT CURRENT_TIMESTAMP,
	total_price DECIMAL(9,2) NOT NULL,
	customer_id INT(9) NOT NULL,
	driver_id INT(9) NOT NULL,
	pm_id INT(9) NOT NULL,

    CONSTRAINT pk PRIMARY KEY(order_id),

    CONSTRAINT fk_07 FOREIGN KEY(customer_id)
       REFERENCES Customer(customer_id)
       ON UPDATE CASCADE
       ON DELETE RESTRICT,

    CONSTRAINT fk_08 FOREIGN KEY(driver_id)
       REFERENCES Driver(driver_id)
       ON UPDATE CASCADE
       ON DELETE RESTRICT,

    CONSTRAINT fk_09 FOREIGN KEY(pm_id)
       REFERENCES PaymentMethod(pm_id)
       ON UPDATE CASCADE
       ON DELETE RESTRICT
);

create table Menu (
    menu_id INT(9) AUTO_INCREMENT NOT NULL,
	menu_type VARCHAR(50) NOT NULL,
	restaurant_id int(9) NOT NULL,
    start_time VARCHAR(50) NOT NULL,
    end_time VARCHAR(50) NOT NULL,

    CONSTRAINT pk PRIMARY KEY(menu_id),

    CONSTRAINT fk_10 FOREIGN KEY(restaurant_id)
       REFERENCES Restaurant(restaurant_id)
       ON UPDATE CASCADE
       ON DELETE RESTRICT
);

create table Item (
    item_id int(9) AUTO_INCREMENT NOT NULL,
	name VARCHAR(50) NOT NULL,
	price INT NOT NULL,
	menu_id INT(9) NOT NULL,
	category_id INT(9) NOT NULL,
    profit DECIMAL(9,2) NOT NULL,
	amount_sold INT(9) NOT NULL,

    CONSTRAINT pk PRIMARY KEY(item_id),

    CONSTRAINT fk_11 FOREIGN KEY(menu_id)
       REFERENCES Menu(menu_id)
       ON UPDATE CASCADE
       ON DELETE RESTRICT,

    CONSTRAINT fk_12 FOREIGN KEY(category_id)
       REFERENCES Category(category_id)
       ON UPDATE CASCADE
       ON DELETE RESTRICT
);

create table OrderLine (

	ol_id INT(9) AUTO_INCREMENT NOT NULL,
    item_id INT(9) NOT NULL,
	quantity INT NOT NULL,
	price DECIMAL(9,2),
	order_id INT(9) NOT NULL,

    CONSTRAINT pk PRIMARY KEY(ol_id),

    CONSTRAINT fk_13 FOREIGN KEY(order_id)
       REFERENCES Orders(order_id)
       ON UPDATE CASCADE
       ON DELETE RESTRICT
);

create table Coupon (
    coupon_id INT(9) AUTO_INCREMENT NOT NULL,
	minimum_order_cost INT NOT NULL,
	maximum_total_off DECIMAL(5,2) NOT NULL,
	expiration_date DATE NOT NULL,
	discount INT NOT NULL,
	code VARCHAR(50) NOT NULL UNIQUE,
	order_id INT(9) NOT NULL,

    CONSTRAINT pk PRIMARY KEY(coupon_id),

    CONSTRAINT fk_14 FOREIGN KEY(order_id)
       REFERENCES Orders(order_id)
       ON UPDATE CASCADE
       ON DELETE RESTRICT
);

insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Olivette', 'Sinott', 'osinott0@si.edu', '321-210-9948', 'Pepper Wood', 'Orlando', 'Florida', '32803');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Judi', 'Couttes', 'jcouttes1@un.org', '210-981-7590', 'Wayridge', 'San Antonio', 'Texas', '78296');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Wendel', 'Cesconi', 'wcesconi2@cbslocal.com', '971-453-4219', 'Moland', 'Portland', 'Oregon', '97255');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Pavlov', 'Ghelardi', 'pghelardi3@newyorker.com', '303-757-7744', 'Sheridan', 'Denver', 'Colorado', '80299');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Idalia', 'Groundwater', 'igroundwater4@elpais.com', '210-581-1779', 'John Wall', 'San Antonio', 'Texas', '78205');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Nolie', 'Minshaw', 'nminshaw5@etsy.com', '775-920-4528', 'Magdeline', 'Reno', 'Nevada', '89510');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Lancelot', 'Treadaway', 'ltreadaway6@mysql.com', '206-972-1876', 'Bayside', 'Seattle', 'Washington', '98175');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Willyt', 'Kerss', 'wkerss7@chicagotribune.com', '636-257-7324', 'Magdeline', 'Saint Louis', 'Missouri', '63131');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Daffie', 'Saull', 'dsaull8@sphinn.com', '727-121-6253', 'Hanover', 'Clearwater', 'Florida', '33763');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Fidelia', 'Bennallck', 'fbennallck9@github.com', '718-417-7754', 'Truax', 'Bronx', 'New York', '10454');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Cathe', 'Palmer', 'cpalmera@comsenz.com', '336-595-9099', 'Heffernan', 'Winston Salem', 'North Carolina', '27157');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Clari', 'Bartolomucci', 'cbartolomuccib@wp.com', '812-458-1860', 'Comanche', 'Evansville', 'Indiana', '47719');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Cord', 'Olney', 'colneyc@wikispaces.com', '813-286-1645', 'Merrick', 'Tampa', 'Florida', '33647');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Aloysia', 'Mitchinson', 'amitchinsond@mtv.com', '212-574-3897', 'Eastwood', 'Jamaica', 'New York', '11499');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Etty', 'Bellfield', 'ebellfielde@freewebs.com', '305-624-6322', 'Acker', 'Miami', 'Florida', '33283');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Emilee', 'Drillingcourt', 'edrillingcourtf@tripod.com', '217-624-0095', 'Gateway', 'Decatur', 'Illinois', '62525');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Caty', 'Robberecht', 'crobberechtg@liveinternet.ru', '847-812-8405', 'Mandrake', 'Chicago', 'Illinois', '60630');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Barby', 'McKinie', 'bmckinieh@unesco.org', '801-579-4573', 'Manufacturers', 'Salt Lake City', 'Utah', '84199');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Francesca', 'MacClay', 'fmacclayi@smh.com.au', '806-127-4097', 'Lukken', 'Amarillo', 'Texas', '79105');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Brynna', 'Harroway', 'bharrowayj@flickr.com', '202-324-3855', 'Randy', 'Washington', 'District of Columbia', '20409');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Egbert', 'Gobat', 'egobatk@omniture.com', '585-944-6896', 'Di Loreto', 'Rochester', 'New York', '14604');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Hasheem', 'Lissaman', 'hlissamanl@europa.eu', '916-983-7351', 'Miller', 'Sacramento', 'California', '94263');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Mellisa', 'Limb', 'mlimbm@businesswire.com', '608-570-8015', 'Magdeline', 'Madison', 'Wisconsin', '53785');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Henri', 'Ghiotto', 'hghiotton@msn.com', '210-434-2196', 'Banding', 'San Antonio', 'Texas', '78210');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Aloise', 'Strattan', 'astrattano@twitter.com', '913-408-1207', 'Waywood', 'Shawnee Mission', 'Kansas', '66286');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Shamus', 'Dennick', 'sdennickp@ftc.gov', '812-241-4283', 'Nancy', 'Terre Haute', 'Indiana', '47812');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Brock', 'Coneron', 'bconeronq@networksolutions.com', '786-733-0061', 'Schiller', 'Miami', 'Florida', '33111');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Cathy', 'Le Fleming', 'cleflemingr@unesco.org', '570-919-2622', 'Bobwhite', 'Scranton', 'Pennsylvania', '18505');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Jodie', 'Cavill', 'jcavills@un.org', '954-348-0855', 'Lien', 'Fort Lauderdale', 'Florida', '33325');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Dame', 'Benneton', 'dbennetont@flavors.me', '915-100-4150', 'Grayhawk', 'El Paso', 'Texas', '79989');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Elle', 'Daughton', 'edaughtonu@is.gd', '719-818-2637', 'Summerview', 'Colorado Springs', 'Colorado', '80940');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Ermengarde', 'Cornhill', 'ecornhillv@free.fr', '321-188-9008', 'Clove', 'Melbourne', 'Florida', '32941');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Linc', 'Ivens', 'livensw@cnet.com', '503-714-0110', 'Knutson', 'Portland', 'Oregon', '97229');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Giacomo', 'Free', 'gfreex@ucla.edu', '979-431-6378', 'Arizona', 'College Station', 'Texas', '77844');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Daisie', 'O''Gormally', 'dogormallyy@istockphoto.com', '915-337-7269', 'Crownhardt', 'El Paso', 'Texas', '88514');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Thadeus', 'Osgardby', 'tosgardbyz@yolasite.com', '513-984-6995', 'Eliot', 'Cincinnati', 'Ohio', '45271');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Deidre', 'Hartop', 'dhartop10@soup.io', '414-445-3323', 'Laurel', 'Milwaukee', 'Wisconsin', '53215');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Bron', 'Dickman', 'bdickman11@github.io', '952-528-6600', 'Northwestern', 'Minneapolis', 'Minnesota', '55436');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Brett', 'Sayer', 'bsayer12@stanford.edu', '214-273-8301', 'Monica', 'Dallas', 'Texas', '75265');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Daphene', 'Dudny', 'ddudny13@acquirethisname.com', '650-408-0842', 'Fairfield', 'San Jose', 'California', '95113');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Gavrielle', 'Briand', 'gbriand14@independent.co.uk', '816-237-4502', 'Boyd', 'Kansas City', 'Missouri', '64109');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Dion', 'Braven', 'dbraven15@last.fm', '702-938-4211', 'Morningstar', 'Las Vegas', 'Nevada', '89155');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Indira', 'Barstock', 'ibarstock16@gizmodo.com', '325-275-8939', 'Bashford', 'Abilene', 'Texas', '79699');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Darya', 'Tremblett', 'dtremblett17@walmart.com', '646-433-6975', 'Erie', 'New York City', 'New York', '10170');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Reidar', 'Mackin', 'rmackin18@comcast.net', '508-883-4321', 'Brentwood', 'Worcester', 'Massachusetts', '01610');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Conant', 'Kinder', 'ckinder19@istockphoto.com', '314-479-7078', 'Forest Run', 'Saint Louis', 'Missouri', '63150');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Gib', 'Kyne', 'gkyne1a@stumbleupon.com', '816-106-5796', 'Brown', 'Kansas City', 'Missouri', '64142');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Malcolm', 'Stutely', 'mstutely1b@blogs.com', '216-785-7382', 'Russell', 'Cleveland', 'Ohio', '44118');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Myriam', 'O''Shields', 'moshields1c@fc2.com', '971-461-4581', 'Esch', 'Portland', 'Oregon', '97229');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Chrysa', 'Limrick', 'climrick1d@bloglovin.com', '847-589-1097', 'Loftsgordon', 'Chicago', 'Illinois', '60646');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Clotilda', 'Anstiss', 'canstiss1e@squidoo.com', '561-466-6071', 'Forest Run', 'West Palm Beach', 'Florida', '33416');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Padriac', 'Espinho', 'pespinho1f@bizjournals.com', '808-916-9976', 'Farwell', 'Honolulu', 'Hawaii', '96805');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Darrell', 'Drescher', 'ddrescher1g@last.fm', '865-833-6181', 'Johnson', 'Knoxville', 'Tennessee', '37914');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Starr', 'Bertelet', 'sbertelet1h@squarespace.com', '801-127-8254', 'Comanche', 'Salt Lake City', 'Utah', '84135');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Lorette', 'Hansom', 'lhansom1i@storify.com', '215-525-0480', 'Grim', 'Philadelphia', 'Pennsylvania', '19115');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Catherine', 'Angier', 'cangier1j@dailymotion.com', '713-178-1197', 'Northridge', 'Houston', 'Texas', '77240');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Davida', 'Revett', 'drevett1k@t.co', '310-471-7889', 'Karstens', 'Inglewood', 'California', '90398');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Cal', 'Vernon', 'cvernon1l@rediff.com', '904-151-1400', 'Fuller', 'Jacksonville', 'Florida', '32277');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Ilene', 'Ruben', 'iruben1m@zdnet.com', '518-582-3314', 'Toban', 'Albany', 'New York', '12222');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Kenn', 'Tobin', 'ktobin1n@altervista.org', '979-104-4815', '6th', 'College Station', 'Texas', '77844');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Coretta', 'Bunney', 'cbunney1o@cocolog-nifty.com', '303-878-7235', 'Mosinee', 'Denver', 'Colorado', '80299');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Cristionna', 'Aujouanet', 'caujouanet1p@google.nl', '814-626-5493', 'Kedzie', 'Erie', 'Pennsylvania', '16522');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Hill', 'Lamburn', 'hlamburn1q@sogou.com', '520-376-5776', 'Springview', 'Tucson', 'Arizona', '85715');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Roxie', 'Oliva', 'roliva1r@exblog.jp', '334-606-1004', 'Esker', 'Montgomery', 'Alabama', '36104');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Berkley', 'Scuse', 'bscuse1s@dot.gov', '319-813-3223', 'Redwing', 'Waterloo', 'Iowa', '50706');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Vevay', 'Fetherby', 'vfetherby1t@bing.com', '330-601-0186', 'Lyons', 'Akron', 'Ohio', '44329');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Ivette', 'Levens', 'ilevens1u@hugedomains.com', '702-475-4967', 'Butternut', 'Las Vegas', 'Nevada', '89115');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Terencio', 'Hilley', 'thilley1v@studiopress.com', '323-729-5914', 'Sachs', 'Los Angeles', 'California', '90094');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Doy', 'Whitloe', 'dwhitloe1w@google.de', '727-896-2142', 'Hermina', 'Clearwater', 'Florida', '34629');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Shanon', 'Bohman', 'sbohman1x@mayoclinic.com', '503-227-2154', 'Debra', 'Portland', 'Oregon', '97286');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Grata', 'Regan', 'gregan1y@miitbeian.gov.cn', '412-688-0142', 'Luster', 'Pittsburgh', 'Pennsylvania', '15230');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Sari', 'Ansill', 'sansill1z@ebay.co.uk', '302-975-1871', 'Sutherland', 'Newark', 'Delaware', '19725');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Ranee', 'Seaborn', 'rseaborn20@statcounter.com', '210-578-8751', 'Rieder', 'San Antonio', 'Texas', '78296');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Jolee', 'Beauchamp', 'jbeauchamp21@ezinearticles.com', '316-801-2067', 'Sutteridge', 'Wichita', 'Kansas', '67230');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Kevin', 'Nurden', 'knurden22@xrea.com', '360-408-0237', 'Reindahl', 'Vancouver', 'Washington', '98687');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Terry', 'Guilayn', 'tguilayn23@icio.us', '704-376-8790', 'Gina', 'Charlotte', 'North Carolina', '28215');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Myra', 'von Hagt', 'mvonhagt24@163.com', '214-401-5560', 'Vidon', 'Plano', 'Texas', '75074');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Amil', 'Dahlback', 'adahlback25@lulu.com', '719-384-7868', 'Prairie Rose', 'Colorado Springs', 'Colorado', '80940');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Filmore', 'Goodered', 'fgoodered26@squidoo.com', '269-944-4127', 'Bonner', 'Kalamazoo', 'Michigan', '49006');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Mic', 'Mulrenan', 'mmulrenan27@opensource.org', '513-609-5250', 'Summer Ridge', 'Cincinnati', 'Ohio', '45218');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Sarah', 'Ell', 'sell28@stumbleupon.com', '915-471-6292', 'Donald', 'El Paso', 'Texas', '88589');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Ahmed', 'Kendal', 'akendal29@blog.com', '630-394-2227', 'Summer Ridge', 'Schaumburg', 'Illinois', '60193');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Gabriela', 'Gidney', 'ggidney2a@census.gov', '504-395-1169', 'Huxley', 'New Orleans', 'Louisiana', '70165');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Trudey', 'Dreinan', 'tdreinan2b@usa.gov', '281-507-3058', '7th', 'Houston', 'Texas', '77085');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Raff', 'Minton', 'rminton2c@blogger.com', '305-881-1462', 'Brickson Park', 'Miami Beach', 'Florida', '33141');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Diarmid', 'Delacroux', 'ddelacroux2d@opera.com', '978-250-8393', 'Moulton', 'Boston', 'Massachusetts', '02283');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Teddie', 'Rackstraw', 'trackstraw2e@creativecommons.org', '646-253-7725', 'Northfield', 'New York City', 'New York', '10099');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Bron', 'Higgen', 'bhiggen2f@vinaora.com', '228-543-7931', 'Cordelia', 'Biloxi', 'Mississippi', '39534');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Creight', 'Braithwaite', 'cbraithwaite2g@fotki.com', '407-766-0347', 'Mosinee', 'Winter Haven', 'Florida', '33884');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Jinny', 'Caruth', 'jcaruth2h@mysql.com', '757-137-5001', 'Farmco', 'Chesapeake', 'Virginia', '23324');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Kelsey', 'Ayshford', 'kayshford2i@plala.or.jp', '405-604-6612', 'Lotheville', 'Oklahoma City', 'Oklahoma', '73197');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Adey', 'Hargraves', 'ahargraves2j@cbc.ca', '402-988-9060', 'Stephen', 'Omaha', 'Nebraska', '68117');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Xaviera', 'Kief', 'xkief2k@earthlink.net', '559-211-9193', 'Acker', 'Fullerton', 'California', '92640');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Nicolle', 'Pettiford', 'npettiford2l@github.com', '770-426-9594', 'Quincy', 'Marietta', 'Georgia', '30061');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Samson', 'Schnitter', 'sschnitter2m@illinois.edu', '702-264-3305', 'Vera', 'Las Vegas', 'Nevada', '89178');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Cymbre', 'Wolfenden', 'cwolfenden2n@unesco.org', '408-157-6782', 'Debs', 'San Jose', 'California', '95150');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Taryn', 'Gask', 'tgask2o@arstechnica.com', '918-538-3075', 'Warner', 'Tulsa', 'Oklahoma', '74170');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Cherin', 'Espine', 'cespine2p@vimeo.com', '810-312-7531', 'Debs', 'Flint', 'Michigan', '48555');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Lorne', 'Brimson', 'lbrimson2q@reddit.com', '412-499-1556', 'Oak', 'Pittsburgh', 'Pennsylvania', '15261');
insert into Customer (first_name, last_name, email, phone_number, street, city, state, zip_code) values ('Stevie', 'Storm', 'sstorm2r@topsy.com', '319-254-9244', 'Reindahl', 'Waterloo', 'Iowa', '50706');



insert into Category (name) values ('Dessert');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Entree');
insert into Category (name) values ('Appetizers');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Beverage');
insert into Category (name) values ('Dessert');
insert into Category (name) values ('Entree');

insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Fritsch Group', '972-960-5349', 4, 'John Wall', 'Mesquite', 'Texas', '75185', 'Turkish');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Ortiz-Raynor', '702-548-6703', 4, 'Dakota', 'Las Vegas', 'Nevada', '89193', 'Turkish');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Hilll-Jones', '423-305-3574', 5, 'Ramsey', 'Chattanooga', 'Tennessee', '37416', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Strosin Group', '813-579-0853', 1, 'Huxley', 'Tampa', 'Florida', '33694', 'Indonesian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Cremin, Padberg and Beatty', '202-774-9449', 2, 'Reinke', 'Washington', 'District of Columbia', '20470', 'Japanese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Harber, Heller and Schroeder', '804-341-7168', 3, 'Florence', 'Richmond', 'Virginia', '23220', 'Indonesian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Pagac, Nikolaus and Zieme', '407-794-8810', 5, 'Rusk', 'Orlando', 'Florida', '32859', 'Korean');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Hessel-Walsh', '805-465-0982', 3, 'Buhler', 'Oxnard', 'California', '93034', 'Turkish');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Bashirian Inc', '502-725-5909', 3, 'Meadow Ridge', 'Louisville', 'Kentucky', '40210', 'Indonesian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Durgan, Schmidt and Moore', '760-732-0827', 3, 'Northland', 'Carlsbad', 'California', '92013', 'Indonesian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Schoen, Kautzer and Lesch', '214-522-1301', 4, 'Almo', 'Dallas', 'Texas', '75379', 'Thai');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('McDermott, Reichert and Kassulke', '408-266-1811', 4, 'Crownhardt', 'San Jose', 'California', '95108', 'Thai');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Welch, Graham and Berge', '909-497-3580', 1, 'Sunbrook', 'San Bernardino', 'California', '92405', 'Thai');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Tromp-Rutherford', '904-725-3913', 4, 'Welch', 'Jacksonville', 'Florida', '32236', 'Thai');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Stroman-Langworth', '205-469-9692', 1, 'Bobwhite', 'Birmingham', 'Alabama', '35279', 'Indonesian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Goodwin, Bahringer and White', '309-301-3563', 5, 'Orin', 'Peoria', 'Illinois', '61614', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Witting Group', '815-428-8300', 3, 'Farmco', 'Rockford', 'Illinois', '61110', 'Turkish');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Kunde Inc', '323-142-0352', 4, 'Kipling', 'Los Angeles', 'California', '90094', 'Indian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Daniel, Bradtke and Sporer', '971-661-8423', 3, 'Merrick', 'Portland', 'Oregon', '97240', 'Thai');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Keebler-Baumbach', '303-157-1465', 3, 'Drewry', 'Denver', 'Colorado', '80243', 'Thai');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Dietrich, Boyle and Kuhlman', '918-322-7742', 1, 'Kenwood', 'Tulsa', 'Oklahoma', '74108', 'Indian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Hettinger Inc', '502-684-8874', 3, 'Buena Vista', 'Louisville', 'Kentucky', '40220', 'Japanese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Kuphal, Christiansen and Smith', '210-186-1766', 4, 'Sachtjen', 'San Antonio', 'Texas', '78235', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Nitzsche, Koepp and Kris', '913-544-4560', 3, 'Continental', 'Shawnee Mission', 'Kansas', '66286', 'Japanese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Stokes-O''Connell', '501-396-0248', 4, 'Bayside', 'Little Rock', 'Arkansas', '72209', 'Thai');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Bednar-Sauer', '508-945-1333', 4, 'Mifflin', 'Brockton', 'Massachusetts', '02405', 'Japanese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Lowe, Goldner and Grimes', '301-376-3083', 5, 'Fallview', 'Silver Spring', 'Maryland', '20910', 'Korean');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Sporer-Kunde', '415-511-1750', 3, 'Tomscot', 'San Francisco', 'California', '94147', 'Thai');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Prosacco Inc', '224-777-6022', 1, 'Grover', 'Schaumburg', 'Illinois', '60193', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Hills-McLaughlin', '720-498-4961', 2, 'Calypso', 'Denver', 'Colorado', '80228', 'Japanese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Hansen-Bode', '814-615-1715', 5, 'Farwell', 'Erie', 'Pennsylvania', '16565', 'Indonesian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Blick, Stamm and Smitham', '518-618-3844', 4, 'Donald', 'Albany', 'New York', '12227', 'Italian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Renner LLC', '203-976-8477', 3, 'Express', 'Bridgeport', 'Connecticut', '06673', 'Italian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Cummerata, Gibson and O''Hara', '936-891-9842', 1, 'Toban', 'Beaumont', 'Texas', '77713', 'Korean');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Gutmann LLC', '610-284-0531', 1, 'Scofield', 'Bethlehem', 'Pennsylvania', '18018', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Larkin-Wehner', '515-646-3394', 3, 'Lerdahl', 'Des Moines', 'Iowa', '50310', 'Thai');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('McLaughlin Inc', '404-641-8529', 3, 'Heath', 'Atlanta', 'Georgia', '30358', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Miller, Bartoletti and Gerhold', '949-570-1068', 3, 'Southridge', 'Santa Ana', 'California', '92705', 'Indian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Wisoky-Nicolas', '305-426-5401', 5, 'Parkside', 'Naples', 'Florida', '33961', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Smith, Gutmann and Nader', '614-325-4222', 1, 'Graedel', 'Columbus', 'Ohio', '43231', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Nienow-Heaney', '585-475-5007', 4, 'Arkansas', 'Rochester', 'New York', '14614', 'Indonesian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Hayes Group', '404-548-3265', 2, 'Katie', 'Atlanta', 'Georgia', '30368', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Blanda, Bartoletti and Erdman', '816-940-0343', 2, 'Gateway', 'Kansas City', 'Missouri', '64142', 'Japanese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Ward and Sons', '702-820-6584', 3, 'Hintze', 'Henderson', 'Nevada', '89074', 'Korean');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Harvey-West', '775-255-9580', 3, 'Fordem', 'Reno', 'Nevada', '89510', 'Italian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Jenkins-Schuppe', '682-886-0773', 2, 'Calypso', 'Fort Worth', 'Texas', '76178', 'Turkish');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Hills-Dicki', '479-700-5870', 5, 'Nobel', 'Fort Smith', 'Arkansas', '72916', 'Italian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Stehr, Hettinger and Gerhold', '202-433-4730', 2, 'Bultman', 'Washington', 'District of Columbia', '20078', 'Italian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Fahey Inc', '801-538-5035', 4, 'Upham', 'Salt Lake City', 'Utah', '84145', 'Korean');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Kertzmann and Sons', '256-606-4948', 4, 'South', 'Huntsville', 'Alabama', '35815', 'Chinese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Yost, Fritsch and Hoeger', '406-505-3799', 2, 'Bunting', 'Bozeman', 'Montana', '59771', 'Indian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Oberbrunner and Sons', '914-934-2598', 4, 'Dottie', 'Mount Vernon', 'New York', '10557', 'Italian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Schimmel and Sons', '928-755-5561', 3, 'Grayhawk', 'Prescott', 'Arizona', '86305', 'Turkish');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Bartell Group', '617-674-7452', 3, 'Daystar', 'Boston', 'Massachusetts', '02298', 'Turkish');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Medhurst-Wunsch', '813-579-1095', 3, 'Becker', 'Tampa', 'Florida', '33625', 'Thai');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Wiegand, Trantow and Thompson', '720-696-5320', 3, 'Schurz', 'Littleton', 'Colorado', '80161', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Metz and Sons', '805-247-8688', 1, 'Oak', 'Oxnard', 'California', '93034', 'Indonesian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Kohler, Ebert and Buckridge', '561-364-7437', 3, 'Kim', 'Lake Worth', 'Florida', '33467', 'Japanese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Hessel-O''Keefe', '202-407-0138', 2, 'Gale', 'Washington', 'District of Columbia', '20057', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('VonRueden, Wolf and O''Reilly', '803-950-1373', 1, 'Corry', 'Columbia', 'South Carolina', '29220', 'Korean');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Treutel, Mayer and Collier', '718-700-5133', 2, 'Oriole', 'Brooklyn', 'New York', '11215', 'Japanese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Kertzmann-Macejkovic', '479-529-4238', 5, 'Moose', 'Fort Smith', 'Arkansas', '72905', 'Indian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Cremin and Sons', '251-430-4206', 3, 'Erie', 'Mobile', 'Alabama', '36670', 'Turkish');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Lind-Sawayn', '407-824-5475', 5, 'Tennessee', 'Daytona Beach', 'Florida', '32118', 'Italian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Lindgren, Upton and Carroll', '913-926-1722', 5, 'Lawn', 'Shawnee Mission', 'Kansas', '66215', 'Japanese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Crona, Borer and Pfannerstill', '302-574-0746', 4, 'Mifflin', 'Wilmington', 'Delaware', '19805', 'Chinese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Jakubowski and Sons', '860-676-1497', 4, 'Becker', 'Hartford', 'Connecticut', '06183', 'Chinese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Von, Hoppe and Willms', '347-100-4745', 4, 'Corben', 'Flushing', 'New York', '11388', 'Indonesian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Luettgen-Gusikowski', '251-523-4062', 5, 'Del Sol', 'Mobile', 'Alabama', '36628', 'Korean');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Boehm, Cartwright and Mraz', '812-216-6622', 5, 'Macpherson', 'Evansville', 'Indiana', '47705', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Stamm LLC', '901-248-8342', 4, 'Anzinger', 'Memphis', 'Tennessee', '38181', 'Korean');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Gusikowski-Schiller', '316-229-2535', 4, 'Crescent Oaks', 'Wichita', 'Kansas', '67230', 'Italian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Mitchell, Nitzsche and Hettinger', '808-335-1487', 3, 'Hoepker', 'Honolulu', 'Hawaii', '96810', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Wiza Group', '646-964-1048', 4, 'Canary', 'New York City', 'New York', '10170', 'Indonesian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Ziemann, Wiza and Wisozk', '919-644-6322', 5, 'Barnett', 'Raleigh', 'North Carolina', '27626', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Botsford-McClure', '415-872-8298', 3, 'Melody', 'San Francisco', 'California', '94116', 'Chinese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Hauck Group', '414-136-1526', 2, 'Village Green', 'Milwaukee', 'Wisconsin', '53220', 'Indian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Skiles Inc', '210-758-9732', 1, 'Rowland', 'San Antonio', 'Texas', '78220', 'Japanese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Stoltenberg, Stiedemann and Harvey', '213-210-3290', 4, 'Washington', 'Los Angeles', 'California', '90189', 'Chinese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Kirlin-Daniel', '863-776-0054', 2, 'Katie', 'Winter Haven', 'Florida', '33884', 'Japanese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Mayer LLC', '701-175-6818', 4, 'Londonderry', 'Grand Forks', 'North Dakota', '58207', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Sanford, Klocko and Barrows', '702-799-0812', 5, 'Maple Wood', 'North Las Vegas', 'Nevada', '89087', 'Chinese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Bergnaum, Weimann and Frami', '804-241-0152', 3, 'Ludington', 'Richmond', 'Virginia', '23293', 'Italian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Kreiger Group', '952-256-0838', 2, 'Corry', 'Maple Plain', 'Minnesota', '55579', 'Japanese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Sauer-Thompson', '586-986-0952', 1, 'Dennis', 'Southfield', 'Michigan', '48076', 'Japanese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Batz, Renner and Heathcote', '801-307-0692', 2, 'Jenifer', 'Provo', 'Utah', '84605', 'Turkish');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Boyer Inc', '919-146-7732', 5, 'Lillian', 'Raleigh', 'North Carolina', '27635', 'Chinese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Legros, Stehr and Hodkiewicz', '713-962-8194', 3, 'Porter', 'Houston', 'Texas', '77095', 'Indian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Waters-Purdy', '954-412-8334', 1, 'Utah', 'Fort Lauderdale', 'Florida', '33330', 'Turkish');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Murphy, Heaney and Mann', '816-269-0069', 4, 'Memorial', 'Shawnee Mission', 'Kansas', '66210', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Sanford LLC', '626-610-5311', 3, 'Mosinee', 'Pasadena', 'California', '91117', 'Korean');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Kihn, Emmerich and Kunde', '815-419-3202', 3, 'Merrick', 'Rockford', 'Illinois', '61110', 'Chinese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Johnson, Hane and Kuhn', '651-777-5675', 2, 'Mallard', 'Minneapolis', 'Minnesota', '55402', 'Mexican');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Langosh Inc', '619-572-7892', 3, 'Cody', 'San Diego', 'California', '92176', 'Turkish');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Weimann, Turner and Kirlin', '718-166-9707', 3, 'Jay', 'Staten Island', 'New York', '10305', 'Thai');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Fadel and Sons', '423-956-8310', 1, 'Sunnyside', 'Chattanooga', 'Tennessee', '37450', 'Korean');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Harvey-Ferry', '207-670-5269', 5, 'Graedel', 'Portland', 'Maine', '04109', 'Chinese');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Rutherford, Gusikowski and Dicki', '310-680-6486', 2, 'Northview', 'San Francisco', 'California', '94105', 'Italian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Olson Group', '602-142-6142', 3, 'High Crossing', 'Scottsdale', 'Arizona', '85260', 'Indian');
insert into Restaurant (name, phone_number, rating, street, city, state, zip_code, cuisine) values ('Borer-Baumbach', '765-530-2009', 3, 'Lawn', 'Indianapolis', 'Indiana', '46202', 'Chinese');


insert into Vehicle (color, type) values ('Puce', 'scooter');
insert into Vehicle (color, type) values ('Teal', 'scooter');
insert into Vehicle (color, type) values ('Fuscia', 'motorcycle');
insert into Vehicle (color, type) values ('Aquamarine', 'motorcycle');
insert into Vehicle (color, type) values ('Indigo', 'bicycle');
insert into Vehicle (color, type) values ('Purple', 'car');
insert into Vehicle (color, type) values ('Teal', 'car');
insert into Vehicle (color, type) values ('Crimson', 'scooter');
insert into Vehicle (color, type) values ('Indigo', 'bicycle');
insert into Vehicle (color, type) values ('Teal', 'car');
insert into Vehicle (color, type) values ('Pink', 'bicycle');
insert into Vehicle (color, type) values ('Fuscia', 'scooter');
insert into Vehicle (color, type) values ('Teal', 'motorcycle');
insert into Vehicle (color, type) values ('Crimson', 'scooter');
insert into Vehicle (color, type) values ('Pink', 'bicycle');
insert into Vehicle (color, type) values ('Aquamarine', 'motorcycle');
insert into Vehicle (color, type) values ('Aquamarine', 'car');
insert into Vehicle (color, type) values ('Purple', 'bicycle');
insert into Vehicle (color, type) values ('Red', 'motorcycle');
insert into Vehicle (color, type) values ('Red', 'motorcycle');
insert into Vehicle (color, type) values ('Yellow', 'scooter');
insert into Vehicle (color, type) values ('Mauv', 'scooter');
insert into Vehicle (color, type) values ('Maroon', 'scooter');
insert into Vehicle (color, type) values ('Maroon', 'bicycle');
insert into Vehicle (color, type) values ('Maroon', 'car');
insert into Vehicle (color, type) values ('Orange', 'car');
insert into Vehicle (color, type) values ('Blue', 'bicycle');
insert into Vehicle (color, type) values ('Red', 'scooter');
insert into Vehicle (color, type) values ('Aquamarine', 'motorcycle');
insert into Vehicle (color, type) values ('Pink', 'bicycle');
insert into Vehicle (color, type) values ('Mauv', 'motorcycle');
insert into Vehicle (color, type) values ('Yellow', 'car');
insert into Vehicle (color, type) values ('Green', 'car');
insert into Vehicle (color, type) values ('Fuscia', 'scooter');
insert into Vehicle (color, type) values ('Khaki', 'motorcycle');
insert into Vehicle (color, type) values ('Red', 'bicycle');
insert into Vehicle (color, type) values ('Fuscia', 'car');
insert into Vehicle (color, type) values ('Purple', 'bicycle');
insert into Vehicle (color, type) values ('Teal', 'scooter');
insert into Vehicle (color, type) values ('Blue', 'motorcycle');
insert into Vehicle (color, type) values ('Aquamarine', 'motorcycle');
insert into Vehicle (color, type) values ('Pink', 'motorcycle');
insert into Vehicle (color, type) values ('Indigo', 'scooter');
insert into Vehicle (color, type) values ('Purple', 'motorcycle');
insert into Vehicle (color, type) values ('Aquamarine', 'scooter');
insert into Vehicle (color, type) values ('Khaki', 'car');
insert into Vehicle (color, type) values ('Fuscia', 'car');
insert into Vehicle (color, type) values ('Mauv', 'scooter');
insert into Vehicle (color, type) values ('Yellow', 'motorcycle');
insert into Vehicle (color, type) values ('Green', 'bicycle');
insert into Vehicle (color, type) values ('Green', 'scooter');
insert into Vehicle (color, type) values ('Yellow', 'scooter');
insert into Vehicle (color, type) values ('Aquamarine', 'car');
insert into Vehicle (color, type) values ('Puce', 'scooter');
insert into Vehicle (color, type) values ('Red', 'scooter');
insert into Vehicle (color, type) values ('Crimson', 'scooter');
insert into Vehicle (color, type) values ('Mauv', 'scooter');
insert into Vehicle (color, type) values ('Mauv', 'car');
insert into Vehicle (color, type) values ('Khaki', 'car');
insert into Vehicle (color, type) values ('Khaki', 'car');
insert into Vehicle (color, type) values ('Mauv', 'scooter');
insert into Vehicle (color, type) values ('Fuscia', 'bicycle');
insert into Vehicle (color, type) values ('Violet', 'scooter');
insert into Vehicle (color, type) values ('Khaki', 'car');
insert into Vehicle (color, type) values ('Pink', 'bicycle');
insert into Vehicle (color, type) values ('Fuscia', 'scooter');
insert into Vehicle (color, type) values ('Crimson', 'car');
insert into Vehicle (color, type) values ('Indigo', 'scooter');
insert into Vehicle (color, type) values ('Violet', 'motorcycle');
insert into Vehicle (color, type) values ('Orange', 'bicycle');
insert into Vehicle (color, type) values ('Teal', 'scooter');
insert into Vehicle (color, type) values ('Green', 'car');
insert into Vehicle (color, type) values ('Orange', 'bicycle');
insert into Vehicle (color, type) values ('Fuscia', 'bicycle');
insert into Vehicle (color, type) values ('Crimson', 'bicycle');
insert into Vehicle (color, type) values ('Goldenrod', 'scooter');
insert into Vehicle (color, type) values ('Pink', 'motorcycle');
insert into Vehicle (color, type) values ('Purple', 'scooter');
insert into Vehicle (color, type) values ('Aquamarine', 'motorcycle');
insert into Vehicle (color, type) values ('Indigo', 'bicycle');
insert into Vehicle (color, type) values ('Purple', 'scooter');
insert into Vehicle (color, type) values ('Red', 'scooter');
insert into Vehicle (color, type) values ('Yellow', 'scooter');
insert into Vehicle (color, type) values ('Orange', 'bicycle');
insert into Vehicle (color, type) values ('Turquoise', 'scooter');
insert into Vehicle (color, type) values ('Aquamarine', 'bicycle');
insert into Vehicle (color, type) values ('Violet', 'motorcycle');
insert into Vehicle (color, type) values ('Green', 'scooter');
insert into Vehicle (color, type) values ('Aquamarine', 'bicycle');
insert into Vehicle (color, type) values ('Teal', 'bicycle');
insert into Vehicle (color, type) values ('Green', 'scooter');
insert into Vehicle (color, type) values ('Indigo', 'scooter');
insert into Vehicle (color, type) values ('Turquoise', 'car');
insert into Vehicle (color, type) values ('Red', 'motorcycle');
insert into Vehicle (color, type) values ('Turquoise', 'car');
insert into Vehicle (color, type) values ('Green', 'motorcycle');
insert into Vehicle (color, type) values ('Crimson', 'motorcycle');
insert into Vehicle (color, type) values ('Yellow', 'bicycle');
insert into Vehicle (color, type) values ('Indigo', 'car');
insert into Vehicle (color, type) values ('Yellow', 'motorcycle');



       

insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Silvia', 'Annabell', '824-312-8794', 58);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Myrle', 'Carlota', '395-548-2168', 53);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Pietrek', 'Jenda', '133-468-3754', 22);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Angelita', 'Pammi', '933-317-8479', 23);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Mile', 'Inge', '955-497-6578', 92);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Woodrow', 'Ernie', '917-634-5717', 17);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Greta', 'Portie', '876-248-2754', 43);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Lewiss', 'Melisande', '815-960-8867', 95);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Preston', 'Curt', '930-322-4659', 15);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Loree', 'Quinta', '104-351-6972', 42);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Forester', 'Redd', '368-656-7887', 76);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Tracy', 'Marni', '374-889-3973', 100);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Alain', 'Stanford', '133-731-5828', 9);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Linnea', 'Jarvis', '294-404-9620', 47);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Carmelita', 'Ted', '541-135-4702', 34);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Sharity', 'Gunter', '668-690-5975', 57);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Alexandra', 'Leshia', '978-913-4081', 64);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Tadeas', 'Evvie', '685-283-1006', 21);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Ambrosio', 'Coleen', '726-866-7866', 30);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Cymbre', 'Wake', '546-937-1446', 56);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Bancroft', 'Taylor', '244-471-6931', 41);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Marnie', 'Keefe', '562-266-4798', 98);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Gilburt', 'Jesse', '491-552-3331', 50);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Chen', 'Nestor', '421-224-3209', 83);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Davide', 'Ossie', '688-448-5919', 26);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Violet', 'Ashely', '657-491-2236', 77);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Lisabeth', 'Isahella', '319-934-3587', 6);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Baudoin', 'Muriel', '496-634-9695', 73);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Rubia', 'Granville', '701-432-8859', 12);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Anders', 'Zahara', '789-173-0259', 62);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Akim', 'Lissy', '213-682-3353', 38);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Katerine', 'Max', '610-673-0690', 38);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Clyde', 'Gian', '397-136-5572', 18);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Armand', 'Verna', '103-259-9712', 86);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Kelby', 'Danit', '298-159-5494', 57);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Craig', 'Remy', '679-831-6650', 76);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Emmey', 'Cristobal', '187-510-4493', 57);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Brynne', 'Gretel', '892-600-9730', 94);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Milka', 'Ginny', '191-745-0699', 68);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Harlene', 'Alvina', '742-859-1498', 93);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Trever', 'Conway', '541-983-1315', 49);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Obadiah', 'Harman', '531-764-8588', 27);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Burl', 'Zora', '477-120-0069', 93);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Colan', 'Bernete', '220-163-2461', 89);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Mirilla', 'Dorthea', '554-427-8299', 55);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Langsdon', 'Thane', '477-280-6406', 71);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Robbyn', 'Ugo', '704-871-8173', 90);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Jennee', 'Horton', '915-313-9398', 48);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Stephi', 'Michaelina', '334-121-9016', 7);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Waverly', 'Sky', '849-296-3984', 61);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Gussi', 'Merilee', '197-104-1062', 64);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Thea', 'Dyan', '333-841-8875', 37);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Antony', 'Lynn', '217-882-0024', 75);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Armin', 'Thornie', '419-515-0775', 81);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Paxton', 'Laverna', '485-413-8810', 43);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Sibelle', 'Benn', '438-241-6202', 2);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Keelia', 'Carin', '285-510-0594', 79);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Alissa', 'Xena', '626-755-3201', 59);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Pierrette', 'Jarrett', '295-575-5192', 79);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Rudolf', 'Leah', '422-476-4645', 46);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Daven', 'Barbra', '808-697-5927', 85);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Gabie', 'Georgina', '143-262-2528', 31);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Dion', 'Berk', '392-570-9243', 78);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Sherri', 'Rand', '663-223-2412', 60);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Nicole', 'Catie', '345-376-1404', 44);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Liesa', 'Skip', '728-425-3331', 61);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Rowney', 'Quill', '650-133-6319', 53);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Enoch', 'Ellen', '167-122-3572', 70);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Rozelle', 'Cristina', '464-670-8189', 21);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Cornelia', 'Matt', '567-315-7058', 44);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Dominik', 'Weber', '813-467-3282', 61);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Vilhelmina', 'Abagael', '478-626-7466', 88);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Sabrina', 'Marj', '144-199-1274', 79);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Beatrisa', 'Mallory', '230-880-9852', 1);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Tally', 'Guilbert', '283-676-4640', 79);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Hulda', 'Dulcie', '428-574-5152', 15);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Goddard', 'Elisa', '787-888-3058', 19);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Darcy', 'Laverne', '657-854-7783', 57);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Marlane', 'Berti', '307-858-9061', 81);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Ianthe', 'Darrell', '103-760-3058', 62);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Jammie', 'Foster', '281-521-4863', 63);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Fania', 'Toinette', '828-395-1474', 60);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Jae', 'Delores', '611-860-3364', 62);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Darda', 'Hart', '328-608-2191', 44);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Elaina', 'Camile', '712-777-5024', 3);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Saba', 'Adriane', '-888-0179', 47);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Jessalyn', 'Abigale', '982-601-0529', 69);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Darcee', 'Mendel', '257-361-7088', 2);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Ingeberg', 'Inness', '240-940-9280', 38);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Bridget', 'Tomaso', '812-216-9465', 92);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Glyn', 'Drugi', '664-788-8646', 15);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Maia', 'Dieter', '376-497-3714', 62);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Anabal', 'Gabi', '524-469-8040', 56);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Klarika', 'Renie', '652-708-3215', 61);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Jacquelynn', 'Kathryn', '890-253-5179', 85);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Annemarie', 'Maible', '741-368-7827', 19);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Shane', 'Shelden', '611-370-0332', 1);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Tabbitha', 'Christa', '664-158-9654', 84);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Constantia', 'Freddy', '702-926-2799', 32);
insert into Driver (first_name, last_name, phone_number, vehicle_id) values ('Portie', 'Connor', '191-833-0697', 19);

insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('77', 31, 61, 70);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('69', 89, 14, 62);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('06', 38, 68, 94);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('54', 76, 75, 72);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('77', 91, 84, 85);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('24', 97, 30, 44);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('16', 98, 53, 52);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('57', 2, 23, 35);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('20', 97, 94, 22);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('87', 43, 89, 38);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('40', 2, 35, 26);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('24', 98, 11, 1);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('09', 93, 96, 59);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('55', 5, 27, 29);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('72', 46, 82, 8);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('15', 35, 63, 43);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('14', 76, 56, 65);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('63', 70, 14, 16);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('94', 93, 90, 5);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('02', 19, 76, 17);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('12', 35, 4, 38);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('93', 100, 14, 8);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('47', 4, 85, 77);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('53', 13, 90, 85);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('15', 92, 21, 48);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('20', 3, 75, 65);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('97', 26, 57, 87);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('01', 49, 47, 98);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('70', 6, 19, 69);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('43', 74, 37, 67);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('32', 65, 64, 37);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('20', 28, 49, 7);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('51', 84, 97, 91);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('32', 83, 75, 78);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('05', 53, 82, 74);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('79', 44, 22, 15);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('71', 20, 55, 68);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('29', 79, 27, 85);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('04', 4, 20, 97);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('05', 18, 93, 5);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('41', 80, 36, 74);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('61', 73, 82, 79);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('35', 45, 35, 87);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('05', 76, 56, 70);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('61', 14, 46, 69);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('62', 16, 83, 58);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('98', 40, 43, 41);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('57', 43, 19, 95);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('63', 84, 100, 2);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('71', 86, 32, 33);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('15', 48, 89, 23);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('39', 23, 96, 66);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('20', 8, 49, 65);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('44', 80, 37, 5);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('12', 85, 6, 71);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('69', 26, 6, 74);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('28', 46, 9, 38);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('69', 93, 32, 85);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('79', 100, 95, 92);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('27', 9, 9, 70);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('77', 10, 95, 84);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('36', 83, 6, 74);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('97', 21, 89, 12);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('85', 61, 20, 58);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('73', 8, 93, 9);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('07', 43, 46, 61);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('90', 79, 25, 53);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('73', 80, 14, 48);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('48', 46, 81, 57);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('36', 17, 30, 14);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('39', 41, 74, 35);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('48', 40, 75, 44);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('83', 18, 62, 14);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('33', 74, 18, 69);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('44', 77, 69, 87);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('93', 45, 77, 9);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('28', 52, 85, 64);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('82', 80, 80, 11);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('30', 11, 40, 76);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('78', 75, 84, 17);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('78', 72, 73, 86);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('60', 49, 99, 88);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('64', 83, 20, 46);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('47', 53, 7, 5);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('72', 56, 79, 65);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('49', 57, 3, 55);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('46', 50, 11, 61);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('49', 49, 15, 63);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('91', 76, 33, 34);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('60', 12, 65, 16);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('53', 17, 61, 86);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('60', 93, 81, 49);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('28', 80, 88, 32);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('04', 60, 1, 64);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('28', 66, 26, 73);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('31', 44, 36, 83);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('46', 57, 19, 10);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('20', 40, 79, 54);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('92', 35, 62, 4);
insert into Trip (distance, restaurant_id, customer_id, driver_id) values ('84', 23, 80, 65);

insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('breakfast', 1, '9:15 AM', '6:20 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 27, '1:28 AM', '4:54 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 28, '1:36 PM', '3:47 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 11, '4:33 AM', '7:38 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 23, '6:54 AM', '3:01 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 10, '12:29 PM', '7:35 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 19, '10:35 AM', '7:35 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 34, '5:40 AM', '10:17 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 17, '1:25 PM', '11:47 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 12, '4:33 AM', '7:25 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 12, '6:10 AM', '8:36 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('breakfast', 51, '12:51 PM', '1:30 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('breakfast', 6, '5:50 AM', '5:26 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 34, '7:31 AM', '11:19 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 44, '7:58 AM', '9:01 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 35, '4:19 AM', '7:36 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 7, '8:50 AM', '10:05 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 33, '8:31 AM', '11:23 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('breakfast', 19, '8:16 AM', '2:22 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 3, '7:51 AM', '7:14 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('breakfast', 35, '10:09 AM', '10:02 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 34, '12:21 AM', '2:59 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 47, '11:33 AM', '9:56 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 50, '12:03 AM', '4:32 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 23, '5:27 AM', '3:19 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 42, '1:36 AM', '3:16 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('breakfast', 52, '4:14 AM', '10:06 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 12, '2:28 AM', '9:04 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 29, '12:37 AM', '2:47 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 27, '6:25 AM', '10:07 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 48, '1:59 AM', '3:23 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 49, '2:47 AM', '4:37 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('breakfast', 37, '6:56 AM', '11:36 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('breakfast', 10, '8:48 AM', '6:19 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 42, '3:22 AM', '6:46 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 28, '2:32 AM', '6:30 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('breakfast', 85, '6:53 AM', '10:07 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('breakfast', 6, '2:04 AM', '5:21 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('breakfast', 26, '7:15 AM', '11:01 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('breakfast', 41, '8:26 AM', '4:59 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 7, '11:36 AM', '8:18 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 28, '1:01 PM', '9:14 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 22, '12:16 AM', '4:29 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 32, '5:23 AM', '8:59 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 11, '8:47 AM', '2:58 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('breakfast', 49, '1:07 AM', '6:10 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('breakfast', 19, '5:17 AM', '3:05 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 4, '12:17 PM', '6:57 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 42, '3:09 AM', '8:35 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('dinner', 48, '8:07 AM', '9:29 AM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('breakfast', 40, '2:14 AM', '7:52 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 24, '3:13 AM', '3:49 PM');
insert into Menu (menu_type, restaurant_id, start_time, end_time) values ('lunch', 8, '7:14 AM', '4:41 PM');

insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 1, 33, 4, 627.53, 81);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 8, 18, 68, 615.3, 65);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pasta', 4, 21, 53, 625.58, 84);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 14, 16, 63, 684.83, 64);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pasta', 14, 2, 64, 692.83, 100);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 8, 9, 69, 583.28, 67);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 12, 21, 99, 769.91, 52);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pasta', 14, 14, 51, 644.76, 89);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 12, 45, 33, 507.65, 84);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 1, 21, 79, 650.96, 71);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 2, 7, 25, 440.75, 88);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 4, 21, 84, 413.2, 99);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Quesadilla', 11, 31, 32, 648.09, 94);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 13, 24, 49, 637.91, 79);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 13, 7, 53, 608.94, 79);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pizza', 1, 31, 31, 645.11, 73);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 5, 6, 90, 693.49, 87);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 14, 23, 45, 562.79, 78);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 12, 11, 63, 605.01, 65);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 6, 8, 42, 479.53, 86);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 13, 20, 77, 468.57, 52);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 14, 28, 70, 655.08, 94);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken', 14, 36, 38, 414.57, 98);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pasta', 11, 38, 78, 719.38, 62);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 2, 42, 22, 461.79, 89);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken', 15, 11, 14, 702.23, 60);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 5, 4, 52, 745.69, 66);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 15, 23, 1, 692.99, 79);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 15, 38, 100, 756.29, 62);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 13, 34, 71, 666.08, 50);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 12, 31, 54, 642.43, 84);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Quesadilla', 4, 1, 94, 666.55, 86);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pizza', 2, 12, 50, 546.66, 89);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 12, 13, 22, 485.63, 66);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 14, 33, 29, 636.75, 86);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 13, 27, 28, 558.52, 81);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Quesadilla', 4, 38, 20, 739.11, 75);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 6, 11, 35, 479.48, 59);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 5, 9, 12, 643.43, 65);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pizza', 7, 48, 40, 623.21, 98);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 12, 49, 83, 598.13, 86);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 3, 3, 99, 459.14, 82);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 6, 36, 57, 751.27, 64);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 9, 47, 73, 700.72, 52);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 4, 25, 78, 635.91, 79);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 13, 30, 65, 555.32, 97);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 9, 41, 20, 722.67, 58);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pizza', 14, 23, 1, 750.19, 51);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken', 4, 11, 71, 726.9, 60);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 6, 30, 54, 609.32, 53);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken', 1, 46, 33, 745.72, 72);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 2, 21, 47, 600.22, 89);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pizza', 12, 42, 2, 768.57, 74);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 10, 35, 22, 465.55, 84);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 9, 41, 90, 558.57, 66);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 14, 5, 19, 667.78, 90);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 10, 34, 51, 681.22, 96);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 9, 6, 89, 444.96, 100);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 9, 16, 96, 469.41, 97);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pasta', 11, 32, 60, 740.25, 68);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 11, 15, 89, 424.7, 78);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 3, 7, 44, 553.65, 80);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 7, 13, 18, 721.28, 56);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 1, 28, 85, 661.71, 53);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 11, 5, 69, 507.29, 59);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 15, 22, 25, 447.99, 59);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 13, 32, 4, 706.11, 96);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 5, 22, 50, 766.97, 87);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 11, 36, 89, 684.2, 92);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 10, 1, 7, 750.65, 76);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 4, 37, 6, 536.01, 75);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Quesadilla', 7, 20, 5, 725.63, 61);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 13, 11, 10, 635.5, 93);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 14, 1, 28, 451.1, 63);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 15, 37, 74, 653.38, 95);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 8, 23, 6, 518.3, 67);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 12, 41, 57, 738.51, 62);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pizza', 3, 38, 82, 654.32, 72);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 8, 20, 13, 575.96, 52);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 1, 14, 1, 787.55, 80);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 3, 37, 35, 760.95, 92);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 6, 25, 58, 607.11, 61);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken', 10, 23, 83, 414.33, 78);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 14, 18, 41, 729.61, 68);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 11, 35, 74, 616.71, 73);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pasta', 13, 11, 83, 661.05, 98);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 7, 30, 9, 528.17, 61);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 14, 26, 25, 497.93, 76);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 5, 3, 100, 503.72, 77);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 1, 8, 65, 451.62, 85);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pizza', 8, 31, 59, 720.51, 97);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 10, 13, 85, 718.3, 92);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 4, 15, 56, 772.58, 81);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pasta', 5, 5, 63, 794.96, 91);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 9, 36, 98, 409.5, 67);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 9, 21, 75, 473.17, 73);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken', 3, 45, 33, 529.12, 69);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 13, 12, 90, 567.05, 89);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 15, 49, 94, 571.26, 98);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 15, 16, 59, 744.12, 74);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Quesadilla', 5, 29, 76, 729.4, 89);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 4, 10, 6, 476.14, 54);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Quesadilla', 14, 48, 45, 438.08, 97);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 6, 47, 62, 505.85, 80);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 6, 20, 24, 523.7, 90);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 6, 28, 24, 659.85, 77);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pizza', 13, 39, 32, 432.62, 52);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 8, 11, 68, 773.05, 90);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 2, 39, 38, 556.8, 64);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 15, 44, 73, 741.59, 66);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 14, 50, 51, 467.56, 78);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 6, 37, 37, 542.24, 75);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 15, 7, 27, 575.73, 100);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 7, 43, 16, 747.26, 98);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 6, 5, 60, 515.75, 73);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 12, 41, 41, 486.89, 58);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pasta', 13, 41, 83, 680.41, 63);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 12, 3, 72, 769.17, 97);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 5, 18, 64, 457.13, 91);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 15, 33, 72, 677.12, 76);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 11, 46, 54, 549.79, 86);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 8, 49, 67, 583.51, 64);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 5, 2, 35, 413.64, 56);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 4, 8, 75, 648.61, 97);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pasta', 1, 34, 79, 741.02, 94);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 7, 33, 39, 536.86, 100);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 5, 34, 77, 617.92, 98);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 14, 4, 65, 513.63, 94);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 7, 32, 63, 521.33, 87);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 3, 25, 93, 677.25, 67);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 7, 45, 43, 497.7, 51);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Quesadilla', 11, 23, 93, 750.24, 63);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 9, 41, 80, 490.24, 72);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 4, 9, 31, 600.98, 58);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 12, 28, 62, 548.42, 64);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 6, 27, 95, 475.61, 69);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken', 15, 33, 1, 764.59, 72);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 7, 31, 34, 452.89, 87);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 6, 44, 38, 784.94, 98);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 8, 36, 94, 616.91, 87);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 3, 19, 57, 618.1, 74);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 1, 21, 59, 481.18, 98);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 3, 46, 71, 704.29, 86);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 1, 42, 99, 785.49, 73);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 15, 21, 16, 592.38, 87);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 12, 2, 24, 700.67, 72);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 11, 37, 20, 628.44, 97);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 7, 46, 59, 516.98, 94);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 6, 13, 79, 632.68, 70);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 2, 47, 25, 778.11, 93);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Quesadilla', 11, 41, 80, 792.85, 90);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 15, 17, 62, 737.37, 92);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 13, 26, 42, 640.0, 66);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 4, 50, 63, 624.95, 72);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 10, 3, 68, 543.2, 55);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 5, 31, 75, 484.36, 75);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 4, 1, 9, 627.49, 97);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 15, 40, 87, 640.95, 80);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 10, 36, 14, 651.88, 71);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 2, 28, 49, 488.04, 84);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 5, 40, 29, 456.02, 62);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 10, 22, 54, 546.3, 50);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 6, 46, 30, 717.04, 98);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 5, 17, 85, 760.96, 79);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 12, 20, 26, 432.64, 69);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 4, 21, 86, 432.03, 82);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 13, 40, 80, 522.29, 75);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pizza', 9, 46, 22, 478.34, 50);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 7, 26, 87, 664.1, 81);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 10, 44, 29, 442.52, 87);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 5, 48, 25, 436.76, 65);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 2, 34, 22, 625.07, 50);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 3, 12, 83, 551.87, 82);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 13, 33, 42, 433.97, 78);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 8, 27, 2, 448.54, 66);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 14, 41, 44, 448.41, 63);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pizza', 4, 25, 67, 611.55, 65);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pasta', 15, 3, 19, 677.31, 69);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 14, 39, 31, 448.18, 70);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 5, 42, 79, 639.19, 68);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pasta', 10, 5, 5, 721.22, 90);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 11, 49, 35, 600.46, 74);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pasta', 4, 10, 95, 563.67, 61);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 5, 43, 29, 427.57, 70);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Quesadilla', 12, 28, 81, 433.51, 96);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 9, 46, 82, 473.28, 53);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 14, 8, 63, 668.56, 71);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 14, 21, 44, 728.9, 86);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 13, 30, 19, 773.6, 93);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 9, 49, 8, 781.56, 60);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 2, 47, 88, 760.77, 55);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pasta', 9, 43, 99, 717.62, 76);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 3, 5, 51, 426.24, 71);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 11, 7, 71, 741.62, 77);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 13, 47, 68, 412.33, 53);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 2, 44, 99, 436.37, 94);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 12, 17, 7, 417.21, 62);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 8, 44, 12, 786.17, 62);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 12, 34, 25, 492.89, 57);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pizza', 11, 7, 51, 504.14, 78);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 15, 26, 21, 635.79, 75);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken', 10, 49, 98, 643.69, 96);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 12, 28, 70, 474.72, 51);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 9, 35, 62, 689.23, 93);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 9, 29, 82, 742.71, 59);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Quesadilla', 5, 30, 53, 730.25, 52);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 9, 17, 86, 451.57, 76);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 12, 10, 78, 796.52, 81);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 5, 15, 96, 614.91, 67);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 3, 25, 16, 636.7, 99);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 10, 21, 48, 764.56, 65);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 5, 9, 70, 634.55, 71);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 8, 18, 46, 491.98, 67);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 9, 27, 72, 412.67, 60);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 6, 30, 10, 620.25, 97);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken', 13, 13, 48, 426.39, 60);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 3, 6, 55, 747.26, 59);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 5, 20, 34, 497.69, 71);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 11, 3, 39, 530.21, 84);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 6, 15, 56, 474.89, 84);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 9, 30, 10, 613.23, 98);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 1, 42, 47, 783.81, 99);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 1, 22, 21, 679.22, 84);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 8, 16, 20, 418.63, 61);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 5, 38, 12, 551.66, 55);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 5, 4, 41, 420.58, 53);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pizza', 6, 12, 80, 656.97, 98);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 7, 50, 78, 799.52, 51);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 13, 36, 37, 540.13, 67);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 4, 30, 44, 688.07, 87);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 9, 35, 40, 551.9, 72);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 6, 43, 34, 730.74, 54);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken', 5, 14, 25, 532.01, 56);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 6, 41, 80, 537.26, 53);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Quesadilla', 1, 10, 42, 659.67, 86);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 7, 10, 13, 479.01, 70);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 2, 35, 55, 694.73, 50);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 3, 29, 70, 609.75, 78);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Quesadilla', 1, 12, 5, 671.77, 74);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 2, 43, 50, 724.95, 56);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 9, 29, 55, 528.23, 82);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 3, 45, 95, 771.63, 62);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 5, 13, 20, 424.61, 63);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pizza', 14, 37, 23, 514.72, 76);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pizza', 10, 6, 17, 537.45, 73);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken', 3, 29, 48, 712.67, 74);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 15, 1, 13, 450.16, 77);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 9, 46, 36, 579.04, 75);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 3, 24, 41, 707.86, 88);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 10, 42, 54, 418.73, 94);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 11, 46, 98, 745.16, 76);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 6, 38, 32, 541.09, 53);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pizza', 10, 20, 13, 494.61, 62);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 12, 42, 80, 545.31, 55);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 1, 48, 16, 642.6, 63);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 5, 13, 3, 479.49, 68);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 6, 16, 64, 450.3, 85);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 14, 12, 72, 743.34, 64);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 6, 33, 13, 579.1, 67);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 1, 44, 11, 429.61, 88);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Pasta', 9, 18, 90, 764.18, 60);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 5, 40, 57, 562.77, 60);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 1, 45, 15, 640.32, 69);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 9, 10, 43, 434.07, 92);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 11, 4, 92, 623.27, 96);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 14, 24, 15, 563.32, 71);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 9, 27, 71, 575.64, 98);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 10, 24, 87, 595.14, 62);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Quesadilla', 5, 9, 2, 730.48, 61);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 6, 25, 70, 696.51, 55);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 2, 42, 56, 460.45, 87);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 7, 25, 38, 772.66, 60);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 10, 39, 10, 728.62, 64);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 12, 7, 49, 631.59, 87);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Quesadilla', 13, 6, 32, 619.53, 91);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Quesadilla', 15, 40, 95, 733.94, 64);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 7, 15, 25, 497.14, 63);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 9, 36, 39, 770.91, 61);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 10, 23, 51, 449.14, 74);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 5, 41, 64, 401.5, 60);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 6, 18, 57, 487.64, 54);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken', 3, 13, 98, 748.68, 56);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken', 6, 18, 73, 622.73, 58);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken Nuggets', 11, 12, 76, 765.97, 83);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Chicken', 10, 29, 67, 426.39, 83);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 12, 7, 19, 505.06, 69);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Burger', 13, 40, 53, 688.79, 70);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 8, 9, 54, 603.55, 76);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 10, 32, 38, 690.64, 54);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Cola', 14, 18, 90, 588.58, 88);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Salad', 6, 18, 58, 455.98, 84);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 11, 22, 10, 605.07, 75);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 15, 37, 33, 794.05, 99);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 7, 24, 91, 402.5, 61);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fanta', 4, 3, 93, 726.04, 50);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Sprite', 13, 34, 69, 477.51, 77);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Apple Pie', 2, 42, 14, 777.27, 60);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Fries', 8, 40, 76, 532.02, 50);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Rice', 12, 39, 21, 700.13, 74);
insert into Item (name, price, menu_id, category_id, profit, amount_sold) values ('Tacos', 9, 41, 54, 735.62, 100);

insert into PaymentMethod (card_number, expiration_date, customer_id) values ('30327606344324', '2025-06-12', 1);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('675901569700851804', '2025-05-13', 2);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3577813537295118', '2024-12-11', 3);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('30525018844845', '2023-01-15', 4);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3545889606097527', '2024-05-08', 5);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('060414222775004181', '2023-03-22', 6);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4041374248007769', '2025-04-09', 7);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3537065593553620', '2023-01-04', 8);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('6761347797193830720', '2025-05-22', 9);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4041591046754033', '2023-08-11', 10);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5100147799464414', '2023-08-05', 11);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3555030780511762', '2024-12-27', 12);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5602212014078259', '2022-03-08', 13);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('6759085203192083692', '2025-08-14', 14);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4039817422557', '2024-08-21', 15);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5602229044925168', '2025-03-14', 16);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3588645218838536', '2022-09-25', 17);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4175009954204634', '2022-09-15', 18);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5602259121010030', '2023-08-21', 19);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3564406551296529', '2025-08-16', 20);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3573744575648831', '2024-10-01', 21);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3556475783548940', '2025-04-15', 22);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3529944334896656', '2025-02-23', 23);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('560225614176416006', '2024-06-25', 24);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3572608907750535', '2022-03-17', 25);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('201522880158498', '2025-05-07', 26);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3529248860986315', '2025-10-07', 27);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3545861229466355', '2024-07-28', 28);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3545372251821244', '2024-04-23', 29);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4175005520607813', '2022-11-29', 30);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5485911335723939', '2024-05-21', 31);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4041592290028538', '2024-02-20', 32);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('30476302148289', '2021-12-13', 33);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3533480493706588', '2023-02-05', 34);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4131826186565018', '2022-08-22', 35);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('374283674660154', '2024-10-07', 36);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3534770935617065', '2024-08-23', 37);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3533457004419174', '2024-06-05', 38);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5176123144143721', '2025-05-30', 39);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3564840647275867', '2024-07-08', 40);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('30061044661292', '2024-12-23', 41);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5602215528547792', '2025-06-28', 42);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5355705869083406', '2024-08-01', 43);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('342108485154452', '2024-05-29', 44);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5176940259934150', '2025-03-03', 45);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3560499614414266', '2023-11-13', 46);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3547324130282336', '2023-03-27', 47);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4917265954352541', '2023-12-27', 48);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4452094141786952', '2025-08-05', 49);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('503877756920125234', '2024-11-27', 50);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4175002976070182', '2022-07-17', 51);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3584253652371207', '2023-05-28', 52);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4026047598986860', '2023-09-09', 53);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5602247144549969', '2024-01-01', 54);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3536861469999124', '2024-12-02', 55);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('67624499502880320', '2024-02-09', 56);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('0604081802479955908', '2022-12-28', 57);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3578861162517073', '2023-10-21', 58);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4903712132729195', '2022-05-05', 59);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('342437543366802', '2024-03-05', 60);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4936639063458802', '2024-11-22', 61);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('36642559721854', '2023-06-30', 62);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3560720795556900', '2025-03-19', 63);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5100138650740869', '2025-03-22', 64);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3556884810448547', '2025-10-04', 65);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4175005785664343', '2024-07-02', 66);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4041597890730', '2022-08-26', 67);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('30163076554344', '2025-05-05', 68);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('676159240939707905', '2025-06-19', 69);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3563060081499086', '2021-12-29', 70);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5038946215448563', '2023-02-04', 71);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3543026005831048', '2023-07-17', 72);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3580696966204957', '2022-04-14', 73);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('201815475197396', '2023-07-08', 74);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('30366026261072', '2024-08-04', 75);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('30463879322679', '2023-09-02', 76);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3539985062592932', '2023-01-13', 77);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3564001314366568', '2023-07-26', 78);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5010128959087277', '2025-01-07', 79);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5574404014661986', '2022-06-23', 80);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3557457441848358', '2022-07-28', 81);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3553418265200211', '2023-04-12', 82);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5641820129461613904', '2024-08-20', 83);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('56022212661747268', '2023-04-25', 84);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3564420557677368', '2022-10-30', 85);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5100171168118740', '2022-08-17', 86);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3528133759960178', '2025-04-01', 87);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5602233666827454', '2025-09-14', 88);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5002355642731520', '2024-07-01', 89);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3586660185815294', '2024-02-09', 90);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('201961113952808', '2024-04-22', 91);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3550623341643291', '2022-12-07', 92);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('5018102855495035', '2023-05-23', 93);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3563148999950637', '2023-10-07', 94);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3529055950412114', '2022-04-17', 95);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('67061771448989088', '2022-08-21', 96);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('343024192996839', '2023-08-10', 97);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3574236362968331', '2022-10-11', 98);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('3563862705366009', '2023-03-18', 99);
insert into PaymentMethod (card_number, expiration_date, customer_id) values ('4041378989050946', '2022-06-06', 100);

insert into PaymentType (name, pm_id) values ('Debit', 1);
insert into PaymentType (name, pm_id) values ('Credit', 2);
insert into PaymentType (name, pm_id) values ('Debit', 3);
insert into PaymentType (name, pm_id) values ('Debit', 4);
insert into PaymentType (name, pm_id) values ('Debit', 5);
insert into PaymentType (name, pm_id) values ('Debit', 6);
insert into PaymentType (name, pm_id) values ('Debit', 7);
insert into PaymentType (name, pm_id) values ('Credit', 8);
insert into PaymentType (name, pm_id) values ('Credit', 9);
insert into PaymentType (name, pm_id) values ('Debit', 10);
insert into PaymentType (name, pm_id) values ('Debit', 11);
insert into PaymentType (name, pm_id) values ('Credit', 12);
insert into PaymentType (name, pm_id) values ('Debit', 13);
insert into PaymentType (name, pm_id) values ('Credit', 14);
insert into PaymentType (name, pm_id) values ('Credit', 15);
insert into PaymentType (name, pm_id) values ('Debit', 16);
insert into PaymentType (name, pm_id) values ('Debit', 17);
insert into PaymentType (name, pm_id) values ('Debit', 18);
insert into PaymentType (name, pm_id) values ('Debit', 19);
insert into PaymentType (name, pm_id) values ('Credit', 20);
insert into PaymentType (name, pm_id) values ('Credit', 21);
insert into PaymentType (name, pm_id) values ('Credit', 22);
insert into PaymentType (name, pm_id) values ('Credit', 23);
insert into PaymentType (name, pm_id) values ('Credit', 24);
insert into PaymentType (name, pm_id) values ('Debit', 25);
insert into PaymentType (name, pm_id) values ('Credit', 26);
insert into PaymentType (name, pm_id) values ('Debit', 27);
insert into PaymentType (name, pm_id) values ('Debit', 28);
insert into PaymentType (name, pm_id) values ('Debit', 29);
insert into PaymentType (name, pm_id) values ('Debit', 30);
insert into PaymentType (name, pm_id) values ('Credit', 31);
insert into PaymentType (name, pm_id) values ('Debit', 32);
insert into PaymentType (name, pm_id) values ('Credit', 33);
insert into PaymentType (name, pm_id) values ('Debit', 34);
insert into PaymentType (name, pm_id) values ('Credit', 35);
insert into PaymentType (name, pm_id) values ('Debit', 36);
insert into PaymentType (name, pm_id) values ('Credit', 37);
insert into PaymentType (name, pm_id) values ('Credit', 38);
insert into PaymentType (name, pm_id) values ('Debit', 39);
insert into PaymentType (name, pm_id) values ('Credit', 40);
insert into PaymentType (name, pm_id) values ('Credit', 41);
insert into PaymentType (name, pm_id) values ('Debit', 42);
insert into PaymentType (name, pm_id) values ('Credit', 43);
insert into PaymentType (name, pm_id) values ('Debit', 44);
insert into PaymentType (name, pm_id) values ('Credit', 45);
insert into PaymentType (name, pm_id) values ('Credit', 46);
insert into PaymentType (name, pm_id) values ('Debit', 47);
insert into PaymentType (name, pm_id) values ('Credit', 48);
insert into PaymentType (name, pm_id) values ('Debit', 49);
insert into PaymentType (name, pm_id) values ('Credit', 50);
insert into PaymentType (name, pm_id) values ('Credit', 51);
insert into PaymentType (name, pm_id) values ('Credit', 52);
insert into PaymentType (name, pm_id) values ('Debit', 53);
insert into PaymentType (name, pm_id) values ('Debit', 54);
insert into PaymentType (name, pm_id) values ('Credit', 55);
insert into PaymentType (name, pm_id) values ('Credit', 56);
insert into PaymentType (name, pm_id) values ('Credit', 57);
insert into PaymentType (name, pm_id) values ('Credit', 58);
insert into PaymentType (name, pm_id) values ('Debit', 59);
insert into PaymentType (name, pm_id) values ('Debit', 60);
insert into PaymentType (name, pm_id) values ('Debit', 61);
insert into PaymentType (name, pm_id) values ('Credit', 62);
insert into PaymentType (name, pm_id) values ('Debit', 63);
insert into PaymentType (name, pm_id) values ('Debit', 64);
insert into PaymentType (name, pm_id) values ('Debit', 65);
insert into PaymentType (name, pm_id) values ('Credit', 66);
insert into PaymentType (name, pm_id) values ('Debit', 67);
insert into PaymentType (name, pm_id) values ('Credit', 68);
insert into PaymentType (name, pm_id) values ('Credit', 69);
insert into PaymentType (name, pm_id) values ('Credit', 70);
insert into PaymentType (name, pm_id) values ('Debit', 71);
insert into PaymentType (name, pm_id) values ('Credit', 72);
insert into PaymentType (name, pm_id) values ('Credit', 73);
insert into PaymentType (name, pm_id) values ('Credit', 74);
insert into PaymentType (name, pm_id) values ('Credit', 75);
insert into PaymentType (name, pm_id) values ('Debit', 76);
insert into PaymentType (name, pm_id) values ('Credit', 77);
insert into PaymentType (name, pm_id) values ('Debit', 78);
insert into PaymentType (name, pm_id) values ('Credit', 79);
insert into PaymentType (name, pm_id) values ('Credit', 80);
insert into PaymentType (name, pm_id) values ('Debit', 81);
insert into PaymentType (name, pm_id) values ('Credit', 82);
insert into PaymentType (name, pm_id) values ('Credit', 83);
insert into PaymentType (name, pm_id) values ('Credit', 84);
insert into PaymentType (name, pm_id) values ('Debit', 85);
insert into PaymentType (name, pm_id) values ('Debit', 86);
insert into PaymentType (name, pm_id) values ('Debit', 87);
insert into PaymentType (name, pm_id) values ('Credit', 88);
insert into PaymentType (name, pm_id) values ('Debit', 89);
insert into PaymentType (name, pm_id) values ('Debit', 90);
insert into PaymentType (name, pm_id) values ('Credit', 91);
insert into PaymentType (name, pm_id) values ('Credit', 92);
insert into PaymentType (name, pm_id) values ('Credit', 93);
insert into PaymentType (name, pm_id) values ('Debit', 94);
insert into PaymentType (name, pm_id) values ('Debit', 95);
insert into PaymentType (name, pm_id) values ('Credit', 96);
insert into PaymentType (name, pm_id) values ('Credit', 97);
insert into PaymentType (name, pm_id) values ('Credit', 98);
insert into PaymentType (name, pm_id) values ('Debit', 99);
insert into PaymentType (name, pm_id) values ('Debit', 100);

insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-09-10 10:17:38', 263.71, 1, 1, 1);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-09-21 11:37:35', 470.09, 2, 2, 2);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-09-07 07:17:31', 706.51, 3, 3, 3);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-05-22 09:24:25', 354.45, 4, 4, 4);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-11-10 17:29:54', 8.8, 5, 5, 5);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-01-23 22:42:27', 732.71, 6, 6, 6);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2021-11-25 10:02:35', 805.6, 7, 7, 7);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-09-02 03:57:52', 646.89, 8, 8, 8);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-03-03 04:03:56', 756.63, 9, 9, 9);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-08-23 13:27:22', 912.94, 10, 10, 10);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-11-08 17:08:38', 862.04, 11, 11, 11);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2021-11-24 14:08:09', 466.07, 12, 12, 12);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-05-16 06:47:22', 223.83, 13, 13, 13);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-10-28 03:35:58', 57.15, 14, 14, 14);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2021-12-11 09:57:13', 860.26, 15, 15, 15);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-11-01 20:21:36', 117.22, 16, 16, 16);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-02-23 22:48:05', 565.78, 17, 17, 17);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-06-12 09:43:16', 313.2, 18, 18, 18);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-01-23 14:25:27', 355.89, 19, 19, 19);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-05-14 18:04:41', 994.89, 20, 20, 20);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-10-26 06:26:47', 243.72, 21, 21, 21);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-06-23 09:38:22', 188.55, 22, 22, 22);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-03-08 12:15:11', 327.42, 23, 23, 23);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-03-21 12:10:12', 840.06, 24, 24, 24);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-03-26 04:57:41', 626.14, 25, 25, 25);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2021-11-28 14:46:53', 916.63, 26, 26, 26);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-02-19 19:28:24', 918.88, 27, 27, 27);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-07-09 22:39:43', 869.35, 28, 28, 28);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-05-14 14:14:40', 804.83, 29, 29, 29);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-07-14 18:08:16', 750.88, 30, 30, 30);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2021-12-03 10:32:02', 742.34, 31, 31, 31);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-05-21 09:15:10', 909.6, 32, 32, 32);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2021-12-27 22:08:50', 949.72, 33, 33, 33);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-03-30 01:24:08', 769.55, 34, 34, 34);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-03-07 03:09:17', 891.07, 35, 35, 35);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-09-05 06:52:36', 182.84, 36, 36, 36);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-09-08 01:51:28', 795.61, 37, 37, 37);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-05-22 03:45:44', 301.0, 38, 38, 38);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-11-02 18:51:11', 642.19, 39, 39, 39);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-09-01 12:26:40', 662.4, 40, 40, 40);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-03-27 13:03:28', 319.63, 41, 41, 41);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-04-01 17:18:27', 985.88, 42, 42, 42);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-09-25 06:15:30', 52.05, 43, 43, 43);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-03-10 05:02:09', 139.58, 44, 44, 44);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-11-20 10:48:38', 510.0, 45, 45, 45);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-08-27 16:07:10', 201.5, 46, 46, 46);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-02-15 23:38:13', 566.38, 47, 47, 47);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-07-06 13:10:06', 513.91, 48, 48, 48);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-07-08 02:23:05', 663.25, 49, 49, 49);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2021-12-12 16:52:30', 408.99, 50, 50, 50);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-07-25 23:33:04', 101.36, 51, 51, 51);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-02-03 04:53:54', 406.73, 52, 52, 52);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-01-14 15:47:11', 93.19, 53, 53, 53);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-06-08 19:41:15', 592.9, 54, 54, 54);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-01-24 14:53:03', 535.46, 55, 55, 55);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-02-03 11:59:35', 930.6, 56, 56, 56);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-05-04 08:25:11', 545.04, 57, 57, 57);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-02-26 02:43:35', 506.79, 58, 58, 58);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-04-26 18:11:44', 156.46, 59, 59, 59);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-06-09 03:27:54', 393.15, 60, 60, 60);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2021-12-28 03:39:20', 737.12, 61, 61, 61);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-05-03 05:28:22', 921.1, 62, 62, 62);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-11-01 17:21:16', 540.44, 63, 63, 63);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-07-01 23:07:46', 21.91, 64, 64, 64);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-02-20 07:45:12', 146.01, 65, 65, 65);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-01-21 04:56:15', 193.12, 66, 66, 66);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-04-19 02:25:43', 984.01, 67, 67, 67);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-01-25 16:50:24', 678.65, 68, 68, 68);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-04-13 06:57:49', 478.19, 69, 69, 69);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-01-09 10:35:00', 482.08, 70, 70, 70);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-01-01 02:45:22', 830.14, 71, 71, 71);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-05-21 21:29:04', 822.23, 72, 72, 72);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-05-22 14:04:32', 361.8, 73, 73, 73);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-07-17 01:09:19', 364.42, 74, 74, 74);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2021-12-01 08:21:16', 108.16, 75, 75, 75);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-05-26 20:41:45', 700.03, 76, 76, 76);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-06-12 05:50:10', 117.27, 77, 77, 77);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2021-12-17 19:15:57', 695.68, 78, 78, 78);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-09-18 12:54:31', 55.43, 79, 79, 79);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-06-04 13:08:02', 64.98, 80, 80, 80);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-06-18 06:23:47', 766.5, 81, 81, 81);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-08-25 11:00:00', 918.86, 82, 82, 82);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-06-07 20:28:35', 476.73, 83, 83, 83);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-05-05 01:50:15', 309.48, 84, 84, 84);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-01-17 01:39:29', 252.68, 85, 85, 85);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-07-20 10:41:22', 854.62, 86, 86, 86);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-01-09 21:08:19', 779.17, 87, 87, 87);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-10-13 21:27:04', 210.68, 88, 88, 88);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-10-18 04:11:29', 772.91, 89, 89, 89);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-08-01 21:04:23', 782.99, 90, 90, 90);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-11-02 18:43:31', 499.45, 91, 91, 91);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-01-25 20:41:14', 389.45, 92, 92, 92);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-04-01 05:24:09', 75.85, 93, 93, 93);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2021-12-21 09:35:33', 773.74, 94, 94, 94);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-01-17 22:56:48', 723.92, 95, 95, 95);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-05-31 18:40:52', 798.88, 96, 96, 96);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-02-19 16:10:29', 917.31, 97, 97, 97);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-07-29 20:29:08', 311.93, 98, 98, 98);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-11-18 14:37:51', 565.37, 99, 99, 99);
insert into Orders (order_time, total_price, customer_id, driver_id, pm_id) values ('2022-09-13 09:50:53', 646.13, 100, 100, 100);

insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (90, 34.47, '2022-03-06', 96, '24cbd58f-129c-4b35-9a2e-4ff9f19662dd', 1);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (92, 89.95, '2022-11-08', 44, 'd90bcec2-1a34-4e3c-b283-48cd665832ea', 2);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (52, 39.84, '2022-10-23', 98, '6045f906-65d1-4e66-98c7-b58e3e038892', 3);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (69, 42.0, '2021-12-08', 32, '0e1ff02f-735c-45ba-bd90-140ff8eb4a6e', 4);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (39, 3.53, '2022-04-02', 37, '4615d5fd-f838-4898-8fd4-e4e3fe08b2a5', 5);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (17, 67.28, '2021-12-02', 28, 'f8cab2c5-f22b-4a33-b437-c2f12707fa6c', 6);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (83, 38.18, '2022-01-10', 9, '5424996d-fd52-489e-bdb9-124bd647e61d', 7);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (54, 51.97, '2022-05-01', 99, 'a3707dd2-3287-4f00-99a0-aa55e757dc89', 8);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (60, 19.81, '2022-09-24', 56, 'deafb5e7-e803-4284-8976-23afa2616420', 9);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (12, 27.95, '2022-01-23', 91, '61d25c3e-c717-4855-b5ed-b53307b2783d', 10);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (47, 53.15, '2022-07-27', 99, '52fcbe82-1ee5-4ae3-a24c-fb1969d5f021', 11);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (49, 65.04, '2022-11-06', 11, 'b8872aab-0792-4c8a-8918-92e3fd5a1d15', 12);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (84, 48.88, '2022-06-22', 10, '47066d69-69ab-4c83-adf1-43fc97c0f964', 13);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (15, 6.34, '2022-06-03', 89, '1e882739-b440-4e25-90e0-82f7b5333d94', 14);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (29, 54.16, '2022-03-24', 53, '0cc87764-0f4c-4097-b013-67462a697410', 15);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (68, 39.56, '2022-06-20', 8, 'd61631d6-dfac-4003-be58-917deb975774', 16);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (70, 92.06, '2022-01-07', 55, '1b5fce90-7eff-4fa6-8fe1-b7cc318396b5', 17);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (8, 34.06, '2022-07-03', 67, '75c8b8e3-aae8-48fe-8359-aa595e287bc8', 18);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (78, 77.67, '2022-01-05', 66, '58689dca-cb74-4184-ae42-ca1d005c20cd', 19);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (14, 56.92, '2022-05-13', 25, 'efa7d00a-49e3-4d26-a4ba-aaeeef126e92', 20);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (50, 10.93, '2022-10-23', 76, 'af2e8c15-027b-4793-9b24-a5882365cadb', 21);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (95, 94.84, '2022-06-26', 41, 'c6b463ae-5c2c-4293-b137-edc8c51cc6f4', 22);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (29, 59.14, '2022-08-02', 52, '2bdc537d-6bcb-4c5b-b6ce-cbf1eec07391', 23);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (84, 33.28, '2022-02-10', 8, '2a624e46-2438-49a1-84e7-33b73223de3d', 24);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (24, 91.35, '2022-08-31', 34, '1c46cf4a-c321-4528-925a-4cea19673d76', 25);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (82, 55.21, '2022-02-01', 10, 'cbaa0685-84a7-4e90-8f91-bd5114f509f0', 26);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (87, 54.31, '2022-08-21', 18, '0d92875b-e2d5-4b11-ab29-fb30f0ea9e30', 27);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (59, 33.57, '2022-05-15', 67, 'ed902bb9-f7a9-4837-b96d-e1fec0f79ac6', 28);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (49, 27.95, '2022-08-19', 86, '014661d7-53c8-4141-8f80-511fddc01cd6', 29);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (68, 14.53, '2022-10-20', 56, '4ab9bd56-e72a-44a3-bf00-2902c4829d2c', 30);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (9, 92.76, '2022-06-01', 27, '9680a5dc-4150-4194-ab24-7ffa89807008', 31);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (96, 91.07, '2022-08-21', 4, '49c95e90-d1d1-4a78-911d-b80f8c75b55e', 32);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (43, 73.73, '2021-12-18', 30, '58ccb0da-07df-4743-9dd3-adb7a18baea2', 33);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (40, 22.3, '2021-11-22', 80, 'd31943e9-c087-48ac-be30-6aa1f2b19212', 34);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (17, 51.5, '2021-12-24', 69, '7e843739-8d2e-4a00-b82b-37f524af5f77', 35);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (19, 64.26, '2022-05-19', 27, '0ee834d0-10c8-499a-bda3-72fdbf0ebdd9', 36);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (53, 11.81, '2022-02-21', 54, '51489125-14f1-4cd9-a05b-4ac01ac9b4c3', 37);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (71, 61.46, '2022-06-04', 22, 'a0664ffd-c1aa-4b34-9d88-23e5b94a9271', 38);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (34, 87.48, '2022-09-05', 71, '5dc9fda2-624f-4ee5-bb40-7d84dfeed4aa', 39);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (20, 43.62, '2021-12-28', 16, '7a5b9b51-ad0b-4cb9-a226-bdd1972bbd7e', 40);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (28, 40.23, '2022-04-04', 57, '7d8657ec-8772-4244-81de-91669cafa62a', 41);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (65, 4.86, '2022-09-29', 91, '0defc676-d402-486d-b2ab-038d9f1ad626', 42);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (51, 98.23, '2022-04-23', 71, '8119a506-4541-4812-9d9a-0844446ca0d1', 43);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (75, 21.38, '2021-12-07', 34, '2fd805bb-08cd-4652-a7ef-bc25b21cfa11', 44);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (15, 56.72, '2022-06-24', 20, '07d71a7d-829d-46c7-8fd7-e5ee7e822089', 45);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (93, 28.35, '2022-03-22', 84, 'c3fbc14b-ed96-4e24-b7a9-113c8d45d46e', 46);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (9, 66.11, '2022-03-12', 15, '630811fd-9d17-4b2e-b976-eec99444c838', 47);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (9, 41.31, '2022-10-20', 37, '4396bccc-34cf-4a5b-99cb-ec497265eadb', 48);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (22, 54.83, '2022-01-12', 16, '3705cbbf-acb7-480f-83a3-9139a531b883', 49);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (72, 82.63, '2022-08-08', 2, '7cf7e680-0dcb-47f5-bfe1-a663c812a943', 50);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (72, 56.93, '2022-07-22', 25, 'cebb8f6e-2a94-4811-9600-d680319b304c', 51);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (44, 8.35, '2022-02-20', 90, '6d002cae-1ae1-44c7-ae89-a689423b948e', 52);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (16, 82.47, '2022-04-13', 22, '48b80375-21a5-4ced-8d95-46d41a350f7c', 53);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (79, 47.69, '2022-09-21', 40, 'fb2f7ed1-046c-412f-8e3c-0c6bcf2b599f', 54);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (47, 39.11, '2022-03-07', 25, '1456311d-6149-4631-b26a-60568ae2021d', 55);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (56, 98.22, '2022-10-22', 27, '95a08d39-65d0-48ec-be63-ed1ea1d700be', 56);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (25, 23.48, '2022-03-21', 86, 'e8c140c1-b946-4232-bfbd-22ae10c5f1ec', 57);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (99, 75.31, '2022-08-15', 38, 'caec231c-5911-49f9-9ae4-a866fc2fdfa0', 58);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (29, 52.35, '2022-03-02', 22, 'bbc26908-9698-49e9-9b21-1f6f00c888e3', 59);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (58, 75.41, '2022-05-12', 89, 'eecf4a1a-ae05-4a54-a8a7-aae0a1b4578f', 60);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (86, 59.0, '2022-11-13', 28, '8c5cf464-542a-433d-bbed-226c28bfd1b6', 61);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (30, 4.94, '2021-12-09', 71, 'd9274a48-a7b3-466b-a767-81fcfdc2b682', 62);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (89, 5.97, '2022-08-02', 36, '4fca0642-62d3-4938-a6b1-5d4b0f8a469a', 63);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (70, 71.03, '2022-04-02', 23, 'e78766db-b4b9-4d08-86d9-c809f942d5fd', 64);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (84, 12.14, '2022-07-31', 88, '14efa9fe-9a0b-4993-8b20-adc87b7bf26c', 65);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (73, 62.4, '2022-08-03', 41, '516a20fe-af8b-4004-986a-b9ff2341039d', 66);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (76, 65.33, '2022-05-11', 49, '7ceb0a8f-01b3-43e3-b3a5-711983ad154a', 67);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (81, 86.07, '2022-04-17', 100, '1bfacf5c-67aa-4fc2-a4c8-6343bd0b4a5c', 68);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (39, 22.48, '2022-08-09', 25, '17982519-5334-449e-adf7-8e7979236c74', 69);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (61, 24.25, '2022-03-29', 54, 'db314ebb-9b11-4fc8-833a-44c34a7e0d97', 70);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (71, 97.61, '2022-06-01', 92, '525a6380-1e5b-4858-863c-517ac6af9596', 71);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (35, 25.58, '2022-02-20', 69, '4d42a067-757e-485f-ba27-bdcedadc6324', 72);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (6, 89.08, '2022-11-03', 50, 'a04967cc-5897-4b0b-a0f8-43218926268c', 73);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (98, 85.38, '2022-11-20', 48, 'cb21c3cf-34dd-4525-ab85-a272532dde88', 74);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (82, 75.62, '2022-08-18', 79, 'ed7c729a-1e47-404e-950c-b8471b5058b7', 75);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (68, 2.12, '2021-12-18', 11, '402ee9e1-4605-4314-9cec-d46ee58e2713', 76);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (90, 56.2, '2021-11-22', 76, '5c3eeb4c-01bc-4376-a773-9706af75cf96', 77);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (72, 12.74, '2022-01-28', 33, '23d2396b-e43f-4e37-b38c-5eab9cfb0b66', 78);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (84, 16.4, '2022-07-05', 40, '4af6e79b-3451-4f91-9294-066723e8c967', 79);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (25, 32.66, '2021-12-13', 97, '99399fbf-4053-4429-8769-0812378bd3e5', 80);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (99, 90.79, '2022-08-20', 59, '1eb015a7-75ad-4d56-98e1-ec4dd803f592', 81);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (32, 41.46, '2022-02-05', 24, '18e8dc4c-a4cc-4fb2-ae5a-e4cce6642ba0', 82);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (74, 83.6, '2022-10-18', 64, 'ef8bdf46-d852-49d0-8efa-133f0ba741b7', 83);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (58, 77.07, '2022-11-06', 68, 'b2b0f566-dc06-4053-affb-67cbaaf274ff', 84);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (93, 96.38, '2022-08-01', 76, '6ab3c2d1-02bc-4b71-881d-6c629c6e3fb1', 85);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (15, 11.98, '2022-05-03', 84, '3f0379d7-c921-4afd-aaa9-b28a21b22c52', 86);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (60, 27.21, '2022-11-14', 66, 'c610b568-c033-4bf9-90e4-0ed122dfdad7', 87);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (70, 44.62, '2022-11-21', 74, '69171e0a-986c-4b59-a142-55eb55d0d941', 88);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (92, 42.59, '2022-01-20', 59, '9301bfb1-ac2b-4327-a438-eab99f2df0b0', 89);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (24, 82.84, '2022-05-19', 8, 'c38bfede-bd8e-4a2e-8f3a-8fc6bd6e1662', 90);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (60, 5.08, '2022-11-06', 95, '66fcabce-6851-4ff6-86e2-ac2d4ec56a05', 91);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (6, 77.58, '2022-05-14', 17, '26702b47-cb01-4305-b0b2-ffbb49afcdea', 92);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (44, 87.7, '2022-02-13', 87, 'de9360e9-b32d-4b99-a29d-f0c3583626e4', 93);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (94, 69.39, '2022-04-08', 20, '0983a421-911b-4594-93d5-7652c8e1ba58', 94);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (27, 35.02, '2022-04-25', 19, '60d2e6c0-e564-4a30-8af4-482854a59e00', 95);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (45, 78.25, '2022-02-16', 99, 'b16ddb3b-6689-4999-8611-0f268e6b9f48', 96);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (26, 64.65, '2022-03-03', 85, '967d24a3-5d7d-4d77-82d4-66e098de9793', 97);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (36, 5.01, '2022-01-11', 54, 'da4a062f-2ba0-4d54-b1bd-6cd63ecd9951', 98);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (40, 81.55, '2022-05-22', 17, '5abeab4a-a7d8-4e37-9f1b-9eb35de2e78d', 99);
insert into Coupon (minimum_order_cost, maximum_total_off, expieration_date, discount, code, order_id) values (9, 15.09, '2022-06-04', 94, 'b038b22c-c6f8-4bfc-9714-956915960ff7', 100);

DROP USER 'webapp'@'%';