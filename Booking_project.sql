create database project1;
drop database project1;
use project1;

-- Users Table
create table users (
id INT auto_increment primary key,
username varchar(50) not null,
email varchar(100) not null unique,
password varchar(255) not null,	
created_at timestamp default current_timestamp
);

drop table users;

INSERT INTO users (id, username, email, password, created_at) VALUES
(1, 'rahul_vijay', 'rahul34@gmail.com', 'password123', '2023-01-01 10:00:00'),
(2, 'sneha_kumar', 'sneha88@gmail.com', 'password456', '2023-01-02 11:00:00'),
(3, 'ajay_krish', 'ajay2@gmail.com', 'password789', '2023-01-03 12:00:00'),
(4, 'arjun_singh', 'arjun789@gmail.com', 'password101', '2023-01-04 13:00:00'),
(5, 'rohit_kumar', 'rohit99@gmail.com', 'password202', '2023-01-05 14:00:00'),
(6, 'priya_dharshini', 'priya4@gmail.com', 'password303', '2023-01-06 15:00:00'),
(7, 'vikas_varma', 'vikas45@gmail.com', 'password404', '2023-01-07 16:00:00'),
(8, 'anitha_sampath', 'anitha56@gmail.com', 'password505', '2023-01-08 17:00:00'),
(9, 'duresh_gupta', 'duresh56@gmail.com', 'password606', '2023-01-09 18:00:00'),
(10, 'deepika_panidan', 'deepika55@gmail.com', 'password707', '2023-01-10 19:00:00');

-- Flights Table
create table flights (
id INT auto_increment primary key,
flight_number VARCHAR(50) not null,
departure VARCHAR(100) not null,
arrival VARCHAR(100) not null,
price DECIMAL(10, 2) not null,
available_seats INT not null,
created_at TIMESTAMP default current_timestamp
);

drop table flights;

INSERT INTO flights (id, flight_number, departure, arrival, price, available_seats, created_at) VALUES
(1, 'AI123', 'Mumbai', 'Delhi', 3000.00, 50, '2023-01-01 10:00:00'),
(2, 'SG456', 'Bangalore', 'Chennai', 2000.00, 30, '2023-01-02 11:00:00'),
(3, 'IX789', 'Delhi', 'Kolkata', 1500.00, 20, '2023-01-03 12:00:00'),
(4, 'AI101', 'Hyderabad', 'Mumbai', 3500.00, 40, '2023-01-04 13:00:00'),
(5, 'SG202', 'Chennai', 'Bangalore', 1800.00, 25, '2023-01-05 14:00:00'),
(6, 'IX303', 'Kolkata', 'Delhi', 2200.00, 15, '2023-01-06 15:00:00'),
(7, 'AI404', 'Mumbai', 'Hyderabad', 3200.00, 10, '2023-01-07 16:00:00'),
(8, 'SG505', 'Delhi', 'Bangalore', 2700.00, 35, '2023-01-08 17:00:00'),
(9, 'IX606', 'Chennai', 'Kolkata', 1600.00, 45, '2023-01-09 18:00:00'),
(10, 'AI707', 'Bangalore', 'Mumbai', 2900.00, 50, '2023-01-10 19:00:00');
select * from flights;
-- Hotels Table

create table hotels (
id INT auto_increment primary key,
name varchar(100) not null,
location varchar(100) not null,
price_per_night decimal(10, 2) not null,
available_rooms int not null,
created_at timestamp default current_timestamp);

drop table hotels;

INSERT INTO hotels (id, name, location, price_per_night, available_rooms, created_at) VALUES
(1, 'Taj Mahal Hotel', 'Mumbai', 5000.00, 20, '2023-01-01 10:00:00'),
(2, 'The Leela Palace', 'Bangalore', 7000.00, 15, '2023-01-02 11:00:00'),
(3, 'ITC Grand Chola', 'Coimbatore', 6000.00, 10, '2023-01-03 12:00:00'),
(4, 'Taj Palace', 'Delhi', 5500.00, 25, '2023-01-04 13:00:00'),
(5, 'Radisson Blu', 'Chennai', 4800.00, 30, '2023-01-05 14:00:00'),
(6, 'Novotel', 'Hyderabad', 5200.00, 18, '2023-01-06 15:00:00'),
(7, 'The Orchid', 'Mumbai', 8000.00, 12, '2023-01-07 16:00:00'),
(8, 'Hilton', 'Bangalore', 6500.00, 22, '2023-01-08 17:00:00'),
(9, 'The Park', 'Kolkata', 4900.00, 14, '2023-01-09 18:00:00'),
(10, 'Radisson Blu', 'Delhi', 5300.00, 16, '2023-01-10 19:00:00');
select * from hotels;
-- Bookings Table

create table bookings (
id INT auto_increment primary key,
user_id INT, 
flight_id INT, 
hotel_id INT, 
booking_date timestamp default current_timestamp,
foreign key (user_id) references users(id),
foreign key (flight_id) references flights(id),
foreign key (hotel_id) references hotels(id));

drop table bookings;

insert into bookings (id, user_id, flight_id, hotel_id, booking_date) VALUES
(1, 1, 1, 1, '2023-01-10 10:00:00'),
(2, 2, 2, 2, '2023-01-11 11:00:00'),
(3, 3, 3, 3, '2023-01-12 12:00:00'),
(4, 4, 4, 4, '2023-01-13 13:00:00'),
(5, 5, 5, 5, '2023-01-14 14:00:00'),
(6, 6, 6, 6, '2023-01-15 15:00:00'),
(7, 7, 7, 7, '2023-01-16 16:00:00'),
(8, 8, 8, 8, '2023-01-17 17:00:00'),
(9, 9, 9, 9, '2023-01-18 18:00:00'),
(10, 10, 10, 10, '2023-01-19 19:00:00');


-- Stored Procedure to Book a Trip
delimiter //
create procedure book_trip(in p_user_id INT, 
in p_flight_id INT, 
in p_hotel_id INT) 
begin 
	declare flight_price decimal(10, 2); -- decimal (digit, decimal values) 
    declare hotel_price decimal(10, 2); 
    
    -- Get flight price
	select price into flight_price
	from flights
	where id = p_flight_id; 
    
    -- Get hotel price
	select price_per_night into hotel_price
	from hotels
	where id = p_hotel_id; 
    
    -- Insert booking
	insert into bookings (user_id, flight_id, hotel_id)values 
		(p_user_id,p_flight_id,p_hotel_id); 
        
	-- Update available seats and rooms
	update flights
	set available_seats = available_seats - 1
	where id = p_flight_id;
	
    update hotels
	set available_rooms = available_rooms - 1 
    where id = p_hotel_id; 
    end //
delimiter ;
drop procedure book_trip;

call book_trip(3,2,5); -- user id(3), flightid(2), hotel id(5)

-- Function to Calculate Total Booking Cost
delimiter //
create function calculate_total_cost(p_flight_id INT, 
p_hotel_id INT) 
returns DECIMAL(10, 2) 
deterministic 
begin 
	declare flight_price DECIMAL(10, 2); 
	declare hotel_price DECIMAL(10, 2); 
    
    -- Get flight price
	select price into flight_price
	from flights
	where id = p_flight_id; 
    
    -- Get hotel price
	select price_per_night into hotel_price
	from hotels
	where id = p_hotel_id; 
    
    return flight_price + hotel_price; 
end //
delimiter ;
drop function calculate_total_cost;

select calculate_total_cost(3,5); -- (flight_id, hotel_id)
-- Trigger to Prevent Booking if No Seats or Rooms Available
delimiter //
create trigger before_booking
before insert on bookings
for each row 
begin 
	declare flight_seats INT; 
    declare hotel_rooms INT; 
    
    -- Check available seats
	select available_seats into flight_seats
	from flights
	where id = NEW.flight_id; 
    
    if flight_seats <= 0 then 
		signal sqlstate '45000'
		set message_text = 'No available seats for this flight'; 
	end if; 
    
	-- Check available rooms
	select available_rooms into hotel_rooms
	from hotels
	where id = NEW.hotel_id; 
    
    if hotel_rooms <= 0 then 
		signal sqlstate '45000'
		set message_text = 'No available rooms for this hotel'; 
	end if; 
end //
delimiter ;
drop trigger before_booking;
select * from hotels;

-- all bookings for a specific user based on their user ID.
delimiter //
create procedure get_user_bookings(in p_user_id INT) 
begin
	select b.id as booking_id,f.flight_number,h.name as hotel_name,b.booking_date
	from bookings b
	join flights f on b.flight_id = f.id
	join hotels h on b.hotel_id = h.id
	where b.user_id = P_user_id;
end //
delimiter ;
call get_user_bookings();
drop procedure get_user_bookings;

call get_user_bookings(4);


delimiter //
create function assign_random_room(hotel_id INT) 
returns INT 
deterministic
begin 
	declare room_number INT; -- Generate a random room number between 101 and 200 for the given hotel

	set room_number = FLOOR(101 + (RAND() * 100)); -- Random room number between 101 and 200
	
    return room_number; 
end //
delimiter ;
drop function assign_random_room;
use base;
select assign_random_room(4);

select floor(101 + (120 *100));
-- Inner join
-- all bookings along with user, flight, and hotel details.
select u.username,u.email,f.flight_number,f.departure,f.arrival,h.name as hotel_name,h.location,b.booking_date
from bookings b
inner join users u on b.user_id = u.id
inner join flights f on b.flight_id = f.id
inner join hotels h on b.hotel_id = h.id;

-- Left join
-- all users and their bookings, including users who have not made any bookings.
select u.username,u.email,b.booking_date,f.flight_number,h.name as hotel_name
from users u
left join bookings b on u.id = b.user_id
left join flights f on b.flight_id = f.id
left join hotels h on b.hotel_id = h.id;

-- Right join
-- all flights and their associated bookings, including flights that have not been booked.
select f.flight_number,f.departure,f.arrival,u.username,b.booking_date
from flights f
right join bookings b on f.id = b.flight_id
right join users u on b.user_id = u.id;

-- the hotel with the highest number of bookings.
select h.name as hotel_name ,COUNT(b.id) as booking_count
from hotels h
join bookings b on h.id = b.hotel_id
group by h.id
order by booking_count desc
limit 1; -- Get the most popular hotel

--  users who have made more than one booking.
select u.username,u.email,COUNT(b.id) as total_bookings
from users u
join bookings b on u.id = b.user_id
group by u.id
having COUNT(b.id) > 1;
