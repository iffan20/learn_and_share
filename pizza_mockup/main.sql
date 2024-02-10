-- create pizza_order table 
create table pizza_order (
  order_id int,
  order_date date,
  payment_type text
);
-- add values in pizza_order table
insert into pizza_order (order_id, order_date, payment_type)
values
  (1, '2022-01-01', 'Cash'),
  (2, '2022-01-01', 'Cash'),
  (3, '2022-01-01', 'Credit card'),
  (4, '2022-01-01', 'Credit card'),
  (5, '2022-01-02', 'Credit card'),
  (6, '2022-01-02', 'Cash'),
  (7, '2022-01-02', 'Credit card');
-- create menu_detail table 
create table menu_detail (
  menu_id int,
  menu_name text,
  menu_desc text,
  menu_price int
);
-- add values in menu_detail table
insert into menu_detail (menu_id, menu_name, menu_desc, menu_price )
values
  (1, 'Hawaiian', 'Ham, pineapple, and pizza sauce', 10),
  (2, 'Pepperoni', 'Pepperoni, pizza sauce, and cheese', 12),
  (3, 'Veggie', 'Mushroom, onion, and pizza sauce', 10),
  (4, 'Meat Lovers', 'Sausage, pepperoni, bacon, and pizza', 12),
  (5, 'Cheese', 'Mozzarella, pizza sauce, and cheese', 12);
-- create order_detail table 
create table order_detail (
  order_id int,
  menu_id int,
  quantity int
);
-- add values in order_detail table
insert into order_detail (order_id, menu_id, quantity)
values 
  (1, 2, 5),
  (1, 4, 2),
  (2, 2, 3),
  (2, 3, 2),
  (2, 2, 1),
  (3, 1, 1),
  (3, 5, 2),
  (4, 4, 3),
  (4, 3, 1),
  (4, 1, 1),
  (5, 2, 2),
  (5, 5, 2),
  (5, 4, 4),
  (6, 1, 2),
  (6, 3, 1),
  (6, 3, 1),
  (7, 1, 1),
  (7, 2, 1),
  (7, 4, 1);

.mod box
-- which order most expensive total price
select 
  po.order_id,
  count(md.menu_id) as total_menu,
  sum(od.quantity) as total_quantity,
  sum(md.menu_price * od.quantity) as total_price
from  
  order_detail od
  join pizza_order po on od.order_id = po.order_id
  join menu_detail md on od.menu_id = md.menu_id
group by po.order_id
order by total_price desc
limit  3;

-- Top three menu
.mod box
select
  md.menu_name,
  sum(od.quantity) as total_quantity,
  sum(md.menu_price * od.quantity) as total_price
from
  order_detail od
  join menu_detail md on od.menu_id = md.menu_id
group by md.menu_name
order by total_price desc;

with  firstday_only  as (
  select *
  from pizza_order where strftime('%d',order_date) = '01')
select   
  md.menu_name,
  count(od.order_id) as total_order,
  avg(md.menu_price * od.quantity) as avg_price
from 
  order_detail od
  join firstday_only fo on od.order_id = fo.order_id
  join menu_detail md on od.menu_id = md.menu_id
group by menu_name
order by total_order desc, avg_price desc
  
