# README

### Initialize

To start this project you can follow the next steps:
* rake db:create
* rake db:migrate
* rake db:seed
* rails server

After running the seeds you will have an Admin User and a Normal User:
* **Admin User**: you can login to the admin site to create products and promotions. The product's price is an Integer so €10.00 is translated as 1000
  * Email: admin@example.com
  * Password: password
* **Normal User**: you can login to the main page to see the products, added to the cart and check the cart with the total price
  * Email: user@example.com
  * Password: password

### Improvement on Page

* Admin Page
  * Instead of creating manually the models to be used for the admin, we can use a gem like **ActiveAdmin**
  * In the Promotion form can be create a custom input for the type of the promotion and validate the keys inside the rules
  * Add better inputs for the price on the Front-End because in the database we save it like Integer (with the cents) but we can translate that data when we sent the values
* Store Page
  * Improve style of the flash message and remove the box

### General Improvement on the Code

* Add a generic page error for multiples HTTP status code and add rescue_from on the application controller to manage all type of errors
* Add tests to check in the controller the role that has permissions to do an action
* Add a better authorization instead of checking the role of the user using **Pundit** or **CanCan** and with that create tests for the policies with the right context
* Caching rules or add calculation on the background to improve the performance on the calculation of the total price of the Cart (Basket).
* Instead of adding products in the cart and then calculate the price, we can add an amount in that relation to reduce the code around the calculation and with that adding more validations
* In this case with the views, we need to add more tests around that but that can be a problem on how long will run the tests
