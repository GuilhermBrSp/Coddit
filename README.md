# Rails Treinamento

Rails app template for Codus training

## Setup

* Check if you have PostgreSQL installed:

```bash
psql --version
# psql (PostgreSQL) 9.6.
```

* [Install PostgreSQL](#installing-postgres)  if necessary

* Check if you have Redis installed:

```bash
redis-server -v
# Redis server v=3.2.8 sha=00000000:0 malloc=libc bits=64 build=b533f811ec736a0c
```

* [Install redis](#installing-redis) if necessary

* Being in project root, run:

```bash
rvm install ruby-2.4.2
rvm use
gem install bundle
bin/setup
```

* Open the repository in your favorite editor, do a global search and replace:
  * `rails_treinamento` -> `rails_treinamento_<your_name>`
  * `RailsTreinamento` -> `RailsTreinamento<YourName>`

* This should be it. To check that everything was successfully installed [run the tests](#running-the-tests) and [start up the server](#starting-the-server)

* Finally, reset the project's git:

```bash
rm -rf ./.git
git init
git add -A
git commit -m "Initial Commit"
```

## Installing Postgres

### MacOS

* Follow the instructions in https://postgresapp.com

### Linux

#### Install the libs

```bash
sudo apt-get update
sudo apt-get -y install libpq-dev
sudo apt-get -y install postgresql postgresql-contrib
```

[Help](https://www.digitalocean.com/community/tutorials/como-instalar-e-utilizar-o-postgresql-no-ubuntu-16-04-pt)

#### Create user with correct permissions

```bash
sudo -u postgres createuser codus
sudo -u postgres -i
psql
ALTER USER codus CREATEDB;
```

[Help1](http://stackoverflow.com/questions/11919391/postgresql-error-fatal-role-username-does-not-exist), [Help2](http://stackoverflow.com/questions/28116927/postgres-permission-denied-to-create-database-on-rake-dbcreateall)

## Installing Redis

```bash
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
make install
cd ..
rm -rf redis-stable
rm redis-stable.tar.gz
```

[Help](https://redis.io/topics/quickstart)

## Running the tests

```bash
rspec
```

## Starting the server

* Start up redis

```bash
redis-server
```

* Start up rails

```bash
rails s
```

and, in your browser, navigate to `localhost:3000`
