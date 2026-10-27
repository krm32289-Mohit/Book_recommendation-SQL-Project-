-- create database book_recommendation;
-- use book_recommendation;
-- create table user(
-- user_id int primary key auto_increment,
-- user_name varchar(50),
-- preferred_genre varchar(50) 
-- );

-- insert into user(user_name,preferred_genre) values("Mohit","Fiction"),
-- ("Himsnhu","Mystery"),
-- ('Rahul Sharma', 'Fiction'),
-- ('Priya Verma', 'Romance'),
-- ('Amit Kumar', 'Mystery'),
-- ('Sneha Gupta', 'Fantasy'),
-- ('Rohit Singh', 'Science Fiction'),
-- ('Ananya Patel', 'Thriller'),
-- ('Vikas Yadav', 'History'),
-- ('Neha Agarwal', 'Romance'),
-- ('Arjun Mehta', 'Self-Help'),
-- ('Pooja Mishra', 'Fiction'),
-- ('Karan Malhotra', 'Mystery'),
-- ('Simran Kaur', 'Fantasy'),
-- ('Aditya Joshi', 'Science Fiction'),
-- ('Riya Kapoor', 'Thriller'),
-- ('Manish Chauhan', 'Biography'),
-- ('Ishita Roy', 'Poetry'),
-- ('Varun Saxena', 'History'),
-- ('Meera Nair', 'Self-Help');



-- create table book(
-- book_id int primary key auto_increment,
-- title varchar(50),
-- author varchar(100),
-- genre varchar(50)
-- );
-- insert into book(title,author,genre) values('The Alchemist', 'Paulo Coelho', 'Fiction'),
-- ('Wings of Fire', 'A.P.J. Abdul Kalam', 'Biography'),
-- ('Rich Dad Poor Dad', 'Robert Kiyosaki', 'Finance'),
-- ('The Hobbit', 'J.R.R. Tolkien', 'Fantasy'),
-- ('Murder on the Orient Express', 'Agatha Christie', 'Mystery'),
-- ('The Great Gatsby', 'F. Scott Fitzgerald', 'Classic'),
-- ('Atomic Habits', 'James Clear', 'Self-Help'),
-- ('Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', 'Fantasy'),
-- ('The Da Vinci Code', 'Dan Brown', 'Thriller'),
-- ('Sapiens', 'Yuval Noah Harari', 'History'),
-- ('Think and Grow Rich', 'Napoleon Hill', 'Self-Help'),
-- ('The Fault in Our Stars', 'John Green', 'Romance'),
-- ('1984', 'George Orwell', 'Dystopian'),
-- ('The Shining', 'Stephen King', 'Horror'),
-- ('Ikigai', 'Hector Garcia', 'Self-Help'),
-- ('The Diary of a Young Girl', 'Anne Frank', 'Biography'),
-- ('The Silent Patient', 'Alex Michaelides', 'Thriller'),
-- ('Pride and Prejudice', 'Jane Austen', 'Romance'),
-- ('A Brief History of Time', 'Stephen Hawking', 'Science'),
-- ('The Jungle Book', 'Rudyard Kipling', 'Adventure');
-- select * from user;
-- select * from book;
-- create table rating(
-- user_id int,
-- book_id int,
-- rating int,
-- check (rating between 1 and 5),
-- Foreign key (user_id) references user(user_id),
-- Foreign key (book_id) references book(book_id)
-- );
-- alter table rating add primary key (user_id,book_id);

-- insert into rating(user_id,book_id,rating) values(1, 5, 5),
-- (2, 3, 4),
-- (3, 8, 5),
-- (4, 12, 3),
-- (5, 1, 4),
-- (6, 15, 5),
-- (7, 4, 2),
-- (8, 10, 4),
-- (9, 6, 5),
-- (10, 2, 3),
-- (11, 18, 4),
-- (12, 7, 5),
-- (13, 14, 3),
-- (14, 9, 4),
-- (15, 20, 5),
-- (16, 11, 2),
-- (17, 16, 4),
-- (18, 13, 5),
-- (19, 17, 3),
-- (20, 19, 4);

select * from rating;
select * from user;
select * from book;

-- select u.user_name,b.title,r.rating from user as u
-- join rating as r on u.user_id = r.user_id
-- join book as b on r.book_id = b.book_id;

select user_name,title,preferred_genre from user as u
join book as b on u.preferred_genre = b.genre;

select b.book_id,b.title from book as b
join book 
left join rating as r on r.book_id = b.book_id
and r.user_id = 1
where r.user_id is null;

select u.user_id,u.user_name,b.author,b.genre, b.title from user as u
join book as b on u.preferred_genre = b.genre
left join rating as r on b.book_id = r.book_id
and r.user_id = 2
where u.user_id = 2
and r.user_id is Null;  	-- user ne konsi book rate nhi ki vo result me aayegi


select avg(rating) from rating where book_id = 2;
select book_id,avg(rating) as avg_rating from rating group by book_id;

-- find the best rated book rate
select book_id,avg(rating) as avg_rating from rating group by book_id
Having avg(rating)>=4;

select b.book_id,b.title,b.author,avg(rating) as rating from rating r
join book b on b.book_id = r.book_id
group by book_id having(rating)>=4;


select b.book_id,b.title,b.author,b.genre,avg(all_rating.rating) as avg_rating from user as u
join book as b on u.preferred_genre = b.genre
join rating as all_rating on b.book_id = all_rating.book_id
left join rating as user_rating on b.book_id = user_rating.book_id
and user_rating.user_id = u.user_id where u.user_id = 8
and user_rating.user_id is null group by b.book_id,b.title,b.author,b.genre having avg(all_rating.rating)>=2
order by avg_rating desc limit 5;

-- how many user rate the book
select book_id,count(*) as total_rating from rating group by book_id having count(*)>=1;

-- user ki rating history
select * from rating where user_id = 2;
select b.title,b.author,r.rating from rating as r join book as b on r.book_id = b.book_id where r.user_id = 2;

select b.title,count(*) as total_rating from book as b 
join rating as r on b.book_id = r.book_id 
group by b.book_id,b.title having count(*)>=3;