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
* [Testing](#testing)
<!--te-->

## **Introduction**
### **Overview**
Cooky is a web application where users contribute and share their own recipes.

### Features
- Sign up (Create account)
- Log in
- CRUD Recipe
- Theme mode
- Show password
- Back to top
- User Access Restriction

## **Getting the Application**
### **Clone**
```bash
git clone https://github.com/jmndz/cooky.git
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
If you’ve cloned the repo, prepare the database and populate it with data by running the following command:
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

You should see the sign in page.

## App Overview
Follows the **Model-View-Controller (MVC)** architecture.

**Key Components**
- Rails: Web application framework
- ActiveRecord: ORM for database interaction

## Database Design
![erd](https://github.com/jmndz/cooky/assets/72738882/fa610607-ca97-45dc-9443-58cda6fc2377)

### ActiveRecord Models
```rb
class Recipe < ApplicationRecord
  # Create slug for recipe
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Add rich text field
  has_rich_text :ingredients
  has_rich_text :procedure

  # Add image
  has_one_attached :image, dependent: :destroy
end

```

### Associations
```rb
class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
end


class Recipe < ApplicationRecord
  belongs_to :user
end
```

For more information on rich text and image attachment for ActiveRecord, refer to the following links: [Active Storage](https://edgeguides.rubyonrails.org/active_storage_overview.html), [Action Text](https://guides.rubyonrails.org/action_text_overview.html).

## Testing
Minitest for testing models and controllers.

To run unit tests:
```bash
rails test
```
