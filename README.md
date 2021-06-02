application# Tea Party API

###### Author: [Doug Welchons](https://github.com/DougWelchons)


Tea Party is a partial backend application to handle tea subscriptions.

This project was built with:
* Ruby version 2.5.3
* Rails version 5.2.5

This project was tested with:
* RSpec version 3.10

#### Contents
- [program setup](#program-setup)
- [Endpoint documentation](#endpoint-documentation)
  - [New Subscription](#new_subscription)
  - [Cancel Subscription](#cancel_subscription)
  - [Customer Subscriptions](#customer_subscriptions)

- [Testing](#testing)
  - [Running tests](#running-tests)
  - [Tests for each endpoint](#tests-for-each-endpont)
    - [New Subscription](#new_subscription_endpoint)
    - [Cancel Subscription](#cancel_subscription_endpoint)
    - [Customer Subscriptions](#customer_subscriptions_endpoint)

### program setup
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

#### Cancel Subscription
- This endpoint changes the status of a subscription to "cancelled".
  - example request:
    - PUT http://localhost:3000/api/v1/subscriptions/:id?status="cancelled"

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
        status: "cancelled"
      }
    }
  }
  ```

#### Customer Subscriptions
- This endpoint returns all of the customers subscriptions (active and cancelled)
  - example requests:
    - http://localhost:3000/api/v1/customers/:id/subscriptions

  - example response:
  ```

  ```

### Testing
##### Running tests
- you can run the entire test suite with `bundle exec rspec`
- you can run an individual test suite with `bundle exec rspec <file path>` for example: `bundle exec rspec spec/requests/post_subscriptions_spec.rb`
- you can run an individual test or an entier describe block with `bundle exec rspec <file path>:<line number>` where the `<line number>` is the line the desired test or describe block starts on


#### Tests for each endpoint
##### New Subscription endpoint
- happy path testing includes:
  -
- Edge case & Sad path testing includes:
  -

##### Cancel Subscription endpoint
- happy path testing includes:
  -
- Edge case & Sad path testing includes:
  -

##### Customer Subscriptions endpoint
- happy path testing includes:
  -
- Edge case & Sad path testing includes:
  - 
