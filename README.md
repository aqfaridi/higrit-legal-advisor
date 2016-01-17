# higrit-legal-advisor

HiGrit is a blogging engine built on ruby on rails platform with postgres database to organize and simplify legal search services.

Demo : http://infinite-earth-9525.herokuapp.com/

## Some features:

- tags (or categories)
- nested comments (reply)
- integrated bootstrap in rails
- multiple users
- Post a Free Query : Post your free online legal query with us.
- Get Instant Answers : Lawyers from various domains will get back to you in a while.
- Search Queries Tag-wise and Rate : Get all the categorised answers and rate the queries and answers

# Prerequisites

## Ruby,rails and devkit 
- Install ruby rubyinstaller-2.2.3-x64.exe
- Install rails on cmd prompt : 
```ruby
gem install rails 
```
- check version 
```ruby
rails -v
ruby -v
```

- Install devkit DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe

##  DataBase Setup :

1. Download and Install postgresql-9.4.5-3-windows-x64.exe
2. set password of postgres user : root
3. change data cluster path to other Disk except C:\   eg. F:\data (in case of cluster error)
 
- Open psql Shell : 

i. Press Enter to continue with default user(postgres) and port 5432

ii. Create New SuperUser for Project 
```ruby
postgres=# CREATE ROLE rubyuser LOGIN ENCRYPTED PASSWORD 'md57c9aeb504d6af71fa00e37ca8336a466' SUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;

postgres=# \password rubyuser
```

iii. Install postgres adapter in cmd prompt
```ruby
gem install pg
gem install activerecord-postgresql-adapter
```
iv. Open psql and login with postgres user
```ruby
postgres=# CREATE DATABASE higrit_development OWNER rubyuser;
postgres=# CREATE DATABASE higrit_test OWNER rubyuser;
postgres=# CREATE DATABASE higrit_production OWNER rubyuser;
```

## Some commands of postgres 

- \l : show databases
- \c library_development : connect database_name
- \dt : show tables
- \d+ tablename  : show table description


# Configuration

1. Navigate to devkit folder in c: drive
2. Open Git Bash there and execute : 
```ruby
git clone https://github.com/aqfaridi/higrit-legal-advisor.git
```
 OR

 Download zip github repository and simply extract it to devkit folder 

3. Open config/database.yml file 

change development: 
```ruby
development:
   adapter: postgresql
   encoding: unicode
   database: higrit_development
   username: rubyuser 
   password: root
```

database => name of database in postgres you want to use for development

username => owner of the database



- You can create different database, open psql : 
```ruby
postgres=# CREATE DATABASE <database_name> OWNER <username>;
```

4. Open cmd prompt in project folder , run bundle to install required gems and Migration to create Tables in db
```ruby
bundle install 
rake db:migrate
```

5. Run server 
```ruby
rails s
```

6. Open Browser and put url

```ruby
localhost:3000
```
Here you go !! signup the new user , sign in and create blog .. Enjoy :)


### Dont Forget to put some categories of blog in Category table : 
1. Open cmd prompt in project folder to open rails console
```ruby
rails c
Category.create(name:"Divorce")
Category.create(name:"Crime")
```

and so on to add categories of legal queries
