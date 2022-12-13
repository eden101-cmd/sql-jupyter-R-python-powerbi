#Q1
select * 
from targil.hotels
where city='Haifa'
order by hotel_rank asc;

#Q2
select room_number, price 
from targil.rooms
where price>=170 and price<=380;

#Q3
select hotel_code, hotel_name, city, hotel_rank, sum(number_of_rooms)
from targil.hotels
group by hotel_name;

#Q4
select hotel_code, hotel_name, city, count(number_of_rooms)
from targil.hotels left join targil.rooms using(hotel_code)
where rooms.price>186
group by rooms.hotel_code
having number_of_rooms>2
order by number_of_rooms asc;

#Q5
select hotels.hotel_name, hotels.city, rooms.room_number, max(rooms.price)
from targil.hotels join targil.rooms using(hotel_code);

#Q6
select hotels.hotel_name, hotels.city, rooms.room_number, rooms.price
from targil.hotels left join targil.rooms 
on (hotels.hotel_code = rooms.hotel_code)
order by rooms.price desc
limit 1;

#Q7
select hotels.hotel_code, hotels.hotel_name, hotels.city, rooms.type, avg(rooms.price)
from targil.hotels left join targil.rooms 
on (hotels.hotel_code = rooms.hotel_code)
group by hotel_name, type;

#Q8
select hotels.hotel_code, hotels.hotel_name, hotels.city, guests.name, guests.city
from targil.hotels join targil.guests join targil.reservation
where reservation.from_date <= '2010-06-28' and reservation.to_date >= '2010-06-28';

#Q9
select hotels.city, count(hotels.hotel_name)
from targil.hotels 
where hotel_rank >= 4
group by city;

#Q10
select hotels.hotel_code, hotels.hotel_name, rooms.price, 
case
	when rooms.price>=100 then 'expensive'
    else 'cheap'
end as 'cheap/expensive'
from hotels join rooms using(hotel_code);

#Q11
select hotels.hotel_code, hotels.hotel_name, hotels.city, count(reservation.hotel_code)
from hotels join reservation using(hotel_code)
group by hotel_code;

#Q12
select hotels.hotel_rank, avg(datediff(reservation.to_date, reservation.from_date)) as 'average days'
from hotels join reservation using(hotel_code)
group by hotel_rank;

#Q13
select hotels.hotel_code, hotels.hotel_name, guests.name 
from hotels left join reservation on (hotels.hotel_code = reservation.hotel_code) left join guests on (reservation.id = guests.id);
 

