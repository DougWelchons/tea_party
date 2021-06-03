application# Tea Party API

###### Author: [Doug Welchons](https://github.com/DougWelchons)


Tea Party is a partial backend application to handle tea subscriptions.

This project was built with:
* Ruby version 2.5.3
* Rails version 5.2.5

This project was tested with:
* RSpec version 3.10

#### Contents
- [Database schema](#database_schema)
- [Program setup](#program_setup)
- [Endpoint documentation](#endpoint_documentation)
  - [New Subscription](#new_subscription)
  - [Update Subscription](#update_subscription)
  - [Customer Subscriptions](#customer_subscriptions)

- [Testing](#testing)
  - [Running tests](#running-tests)
  - [Tests for each endpoint](#tests-for-each-endpont)
    - [New Subscription](#new_subscription_endpoint)
    - [Update Subscription](#update_subscription_endpoint)
    - [Customer Subscriptions](#customer_subscriptions_endpoint)

### Database schema
![database-schema](https://user-images.githubusercontent.com/72056427/120692132-9a557e80-c464-11eb-8550-ab2caa6cd0bc.png)

### Program setup
To run the program on you own machine follow these setup steps:
```
$ git clone git@github.com:DougWelchons/tea_party.git
$ cd tea_party
$ bundle install
```

In order to set up the database run the following:
```
$ rails db:create
$ rails db:migrate
```
If you have an existing database called `tea_party` you will have to run `rails db:drop` prior to setting up the database
alternatively you can run `rails db:{drop,create,migrate}` to set up the database.

### Endpoint Documentation

#### New Subscription
- This endpoint creates a new subscription for the corresponding customer and returns the subscription
  - required params (in the body)
    - customer_id
    - tea_id
    - title
    - price
    - frequency

  - example requests:
    - POST http://localhost:3000/api/v1/subscriptions
      Content-Type: application/json
      Accept: application/json
      ```
      body:
            {
              customer_id: 1,
              tea_id: 1,
              title: "Mint Tea Monthly",
              price: 25.99,
              frequency: "monthly"
            }
      ```

  - example response:
  ```
  {
    data: {
      id: 5,
      type: "subscription",
      attributes: {
        customer_id: 1,
        tea_id: 1,
        title: "Mint Tea Monthly",
        price: 25.99,
        frequency: "monthly"
        status: "active"
      }
    }
  }
  ```

#### Update Subscription
- This endpoint changes the status of a subscription
  - required params
    - status=<new_status> (new_status must be active or canceled)

  - example request:
    - PUT http://localhost:3000/api/v1/subscriptions/:id?status=canceled

  - example response:
  ```
  {
    data: {
      id: 5,
      type: "subscription",
      attributes: {
        customer_id: 1,
        tea_id: 1,
        title: "Mint Tea Monthly",
        price: 25.99,
        frequency: "monthly"
        status: "canceled"
      }
    }
  }
  ```

#### Customer Subscriptions
- This endpoint returns all of the customers subscriptions (active and canceled)
  - Optional params
    - status=active - returns only the active subscriptions
    - status=canceled - returns only the canceled subscriptions
  - example requests:
    - http://localhost:3000/api/v1/customers/:customer_id/subscriptions
    - http://localhost:3000/api/v1/customers/:customer_id/subscriptions?status=canceled

  - example response 1:
  ```
  {
    "data": [
         {
             "id": "1",
             "type": "subscription",
             "attributes": {
                 "title": "Mint Monthly",
                 "price": 25.99,
                 "status": "active",
                 "frequency": "monthly",
                 "customer_id": 1,
                 "tea_id": 1
             }
         },
         {
             "id": "2",
             "type": "subscription",
             "attributes": {
                 "title": "Weekly Mint",
                 "price": 25.99,
                 "status": "active",
                 "frequency": "weekly",
                 "customer_id": 1,
                 "tea_id": 1
             }
         },
         {
             "id": "3",
             "type": "subscription",
             "attributes": {
                 "title": "Twice Mint",
                 "price": 25.99,
                 "status": "canceled",
                 "frequency": "biweekly",
                 "customer_id": 1,
                 "tea_id": 1
             }
         }
     ]
  }
  ```

  - example response 2:
  
  ```
  "data": [
         {
             "id": "3",
             "type": "subscription",
             "attributes": {
                 "title": "Twice Mint",
                 "price": 25.99,
                 "status": "canceled",
                 "frequency": "biweekly",
                 "customer_id": 1,
                 "tea_id": 1
             }
         }
     ]
  }
  ```
 

### Testing
##### Running tests
- you can run the entire test suite with `bundle exec rspec`
- you can run an individual test suite with `bundle exec rspec <file path>` for example: `bundle exec rspec spec/requests/post_subscriptions_spec.rb`
- you can run an individual test or an entier describe block with `bundle exec rspec <file path>:<line number>` where the `<line number>` is the line the desired test or describe block starts on


#### Tests for each endpoint
##### New Subscription endpoint
- happy path testing includes:
  - Endpoint returns a new subscription with all relevant data
- Edge case & Sad path testing includes:
  - Endpoint returns a 400 error if no body is provided
  - Endpoint returns a 400 error if all required information is not provided

##### Update Subscription endpoint
- happy path testing includes:
  - Endpoint returns the updated subscription with all relevant data
- Edge case & Sad path testing includes:
  - Endpoint returns a 400 error if no status is provided
  - Endpoint returns a 400 error if the status is blank
  - Endpoint returns a 400 error if the status is not canceled or active
  - Endpoint returns a 404 error if the subscription does not exist

##### Customer Subscriptions endpoint
- happy path testing includes:
  - Endpoint returns all of a customers active and canceled subscriptions by default
  - Endpoint returns an empty array if customer has no subscriptions
  - Endpoint returns only the active subscriptions if the status param equals active
  - Endpoint returns only the canceled subscriptions if the status param equals canceled
  - Endpoint returns all of the subscriptions if the status param is blank
- Edge case & Sad path testing includes:
  - Endpoint returns a 404 error if the customer does not exist
  - Endpoint returns a 400 error if the status param not a valid status
