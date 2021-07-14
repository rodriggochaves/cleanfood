# CleanFood in practice

Before diving into implementation, some thought about the existing domain will be quite helpful to develop an application.
In this topic we'll explore the food delivery domain as it is, without any automated application in the process. Later we'll
focus on entities and use case that we found after looking to our domain.

### Food delivery domain

First, let's think about how a food delivery occurs without a software managing it. In order to help us I'm going to list
a script of what it was like to order a pizza in Parapipa Pizza before there were several apps that help us to do that.

1. A customer sees a pizza catalog from Parapipa Pizza possibly with a promotion.
2. The customer calls the Parapipa Pizza store and orders a pepperoni pizza to a attendant.
3. The attendant takes the order, and the customer's address. He/She passes the order to the restaurant kitchen.
4. The pizzeria kitchen then prepares the pizza.
5. When the pizza is ready, the Parapipa Pizza passes the pizza to a delivery driver.
6. The delivery driver delivers the pizza to the customer's address.
7. The customer pays for the pizza and receives it.

Keep in mind that this is the happy path. The Parapipa Pizza could, for example, have its pepperoni sold out or
the attendant could have misunderstood the address and subsequently the delivery person arrived at the wrong house.

It's important to be aware of these unhappy paths, but to start simple we'll focus on happy path first.

### CleanFood entities

From here, we'll start to think in a modeling from real world to our software.
Bellow I'll list possible entities that we can find in the pizza delivery example listed before.

- **Customer:** A person that orders a food delivery from a merchant catalog to himself/herself and pays for it.
- **(Food) Store:** The store that has an available food catalog and accepts food delivery orders from customers, delivering food through a driver.
- **(Food) Catalog:** From where customer can check available food and prices for a specific store.
- **Driver:** A person responsible for delivering an ordered food from merchant to customer.
- **Order:** A customer delivery request that informs customer address and chosen foods from merchant catalog.

There may be other entities that will become clearer as we evolve the project. Beforehand, it is expected, for example,
that there is a Merchant entity that owns one or more stores or a Product entity which represent options from a Catalog,
but as said before, let's start simple.

Looking at these entities and their domain we expect certain critical business data and critical business rules
from them. I'll list examples bellow for some cases:

- **Critical Business Data**
  - **Customer:** address, payment info
  - **Store:** catalog
  - **Catalog:** products (food) listing, prices
  - **Order:** products chosen (by a customer), address to deliver


- **Critical Business Rules**
  - Customer: place an order for a store, pay an order
  - Store: confirm customer's order, pass the prepared order to a driver
  - Driver: delivers order to customer

# Use cases


### Customer orders food from a store
  - Input: Customer's address, Customer's payment info, products from store's catalog
  - Output:
    1. Order's status
  - Happy path:
    1. Validate payment info
    2. If success
      - Charge customer
      - Notify the store
      - persist the order
      - return order status
    3. Else
      - Invalid payment info
