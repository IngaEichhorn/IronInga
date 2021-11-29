# Lab | SQL basics (selection and aggregation)

# Query 1
# Get the id values of the first 5 clients from district_id with a value equals to 1.
use bank;
select client_id from client where district_id=1 limit 5;


# Query 2
# In the client table, get an id value of the last client where the district_id equals to 72.
select max(client_id) from client where district_id=72;

# Query 3
# Get the 3 lowest amounts in the loan table.
select amount from loan order by amount limit 3;

# Query 4
# What are the possible values for status, ordered alphabetically in ascending order in the loan table?
select * from loan;
select distinct(status) from loan order by status asc;

# Query 5
# What is the loan_id of the highest payment received in the loan table?
select * from loan;
select loan_id from loan order by payments desc limit 1;

# Query 6
# What is the loan amount of the lowest 5 account_ids in the loan table? Show the account_id and the corresponding amount
select account_id as "lowest_id" , amount from loan order by account_id limit 5;

# Query 7
# What are the account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?
select amount, account_id from loan where duration=60 order by amount limit 5;

#Query 8
#What are the unique values of k_symbol in the order table?
select distinct(k_symbol) from bank.order where k_symbol<>" ";
#k_symbol<>" " not equal to empty(space)
#bank.order, otherwise only order will mean the funtion

#Query 9
#In the order table, what are the order_ids of the client with the account_id 34?
select order_id from bank.order where account_id=34;

#Query 10
#In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?
select distinct account_id from bank.order where order_id between 29540 and 29560;

#Query 11
#In the order table, what are the individual amounts that were sent to (account_to) id 30067122?
select amount from bank.order where account_to=30067122;

#Query 12
#In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793 in descending order, from newest to oldest.
select trans_id ,date, type, amount from trans where account_id=793 order by trans_id desc limit 10;

#Query 13
#In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by the district_id in ascending order.
select district_id,count(*) from client where district_id<10 group by district_id order by district_id asc;

#Query 14
#In the card table, how many cards exist for each type? Rank the result starting with the most frequent type.
select type,count(*) from card group by type order by count(*) desc;

#Query 15
#Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.
select account_id,sum(amount) from loan group by account_id order by sum(amount) desc limit 10;