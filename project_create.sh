#!/bin/bash

# Copy base Rails gemfiles
cp docker/app/Gemfile app
cp docker/app/Gemfile.lock app

# Create new Rails app
docker-compose run --no-deps app rails new . --force --database=postgresql

# Change root ownership to user
sudo chown -R $USER:$USER app

# Build containers
docker-compose build

# Setting up database connection
cp docker/app/database.yml app/config

# Create database
docker-compose up -d
docker-compose run app rake db:create

docker-compose stop
