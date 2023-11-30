# Cooky App Documentation

## Table Of Contents
<!--ts-->
* [Introduction](#introduction)
  * [Overview](#overview)
* [Getting the Application](#getting-the-application)
  * [Clone](#clone)
* [Get Started](#get-started)
  * [System Requirements](#system-requirements)
  * [Rails Installation](#rails-installation)
  * [Gems](#gems)
  * [Install the Required Gems](#install-the-required-gems)
  * [Database Setup](#database-setup)
  * [Server](#server)
* [App Overview](#app-overview)
* [Database Design](#database-design)
* [API Documentation](#api-documentation)
* [Testing](#testing)
<!--te-->

## **Introduction**
### **Overview**
Cooky is a web application where users contribute and share their own recipes.

## **Getting the Application**
### **Clone**
```bash
git clone git://github.com/jmndz/cooky.git
```

## **Get Started**
### **System Requirements**
Before generating your application, you will need:
- Ruby (v3.2.2)
- Ruby on Rails (v7.1.2)
- PostgreSQL

### **Rails Installation**
I recommend using the guide provided by GoRails:
- [Mac](https://gorails.com/setup/macos/13-ventura)
- [Ubuntu](https://gorails.com/setup/ubuntu/22.04)
- [Windows](https://gorails.com/setup/windows/10)

### **Gems**
Here are the gems used by the application:
- [Pagy](https://github.com/ddnexus/pagy#pagy) for managing pagination efficiently
- [Faker](https://github.com/faker-ruby/faker#faker) for generating fake data (used for unit testing and seeding)
- [Devise](http://github.com/plataformatec/devise) for authentication and user management
- [Bootstrap](https://github.com/twbs/bootstrap-rubygem#bootstrap-ruby-gem--) for CSS and JavaScript
- [FriendlyId](https://github.com/norman/friendly_id#friendlyid) for generating user-friendly URL
- [Requestjs-Rails](https://github.com/rails/requestjs-rails#requestjs-for-rails) for processing HTTP requests

### **Install the Required Gems**
Run the `bundle install` command to install the required gems on your computer:
```bash
bundle install
```

### Database Setup
If you’ve cloned the repo, prepare the database and populate it with data by running the commands:
```bash
rails db:setup         # does db:create, db:schema:load, db:seed
```
Use `rails db:reset` if you want to empty and reseed the database.

### Server
To run the server, execute the following command:
```bash
rails s
```
To see the application in action, open a browser window and navigate to http://localhost:3000/.

You should see the sign up page.

## App Overview

## Database Design

## API Documentation

## Testing
Minitest for testing models and controllers.

To run unit tests:
```bash
rails test
```
