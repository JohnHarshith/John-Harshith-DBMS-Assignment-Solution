create database if not exists `TravelOnTheGo`;
use `TravelOnTheGo`;

create table if not exists PRICE(
	Bus_Type varchar(10),
    Distance int not null,
    Price int not null,
    primary key(Bus_Type,Distance));
    
create table if not exists PASSENGER(
	Passenger_name varchar(50) primary key,
    Category varchar(10),
    Gender char,
    Boarding_City varchar(30),
    Destination_City varchar(30),
    Distance int not null,
    Bus_Type varchar(10),
    foreign key (Bus_Type,Distance) references PRICE(Bus_Type,Distance));
    

    
