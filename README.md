## FoodDeliveryApp


FoodDeliveryApp is my pet-project, it is classical food delivery application, pretty handy and simple for users.
The application is based on the MVC pattern. User interface was make in code, without storyboard. 
We use Firebase for storage and getting data., also for authentication with phone number.
For adding and storage goods to basket use Realm database.
For cache images from Firebase Storage use library SDWebImage or NSCache.
Almost every viewController has UICollectionView or UITableView.

## Description

### The home screen of the application is the MenuViewController:

<img width="150" src="https://user-images.githubusercontent.com/79893831/133198057-d9000d1d-7891-41eb-a919-dd31db810956.png"> <img width="150" src="https://user-images.githubusercontent.com/79893831/133198605-debe7769-9b68-4aa4-bf54-b7dbb6fd542a.png"> <img width="150" src="https://user-images.githubusercontent.com/79893831/133198780-833147f4-d93e-4427-816c-09fdc248dead.png"> <img width="150" src="https://user-images.githubusercontent.com/79893831/133198951-17ed04d4-d0a7-4e82-8d8e-841ead10fdeb.png">

 

* Image is uploaded via SDWebImage.
* By clicking on the red button  we add good to the basket.
* On the top part of screen there is list of categories (Pizza, Pasta, Lasagna etc..)
* By clicking on the goods cell we open ProductDetailViewController which contain detail information about good (price, weight, energy value) etc

<img width="150" src="https://user-images.githubusercontent.com/79893831/133200778-34c7735c-5bc2-4ab4-9ab4-995ee1b5413f.png"> <img width="150" src="https://user-images.githubusercontent.com/79893831/133200963-5b272dd6-afc2-459f-9d5d-c9b474350a57.png"> <img width="150" src="https://user-images.githubusercontent.com/79893831/133201103-e85a2806-c44b-48b1-8f81-7bac3b8a0f9b.png"> <img width="150" src="https://user-images.githubusercontent.com/79893831/133201228-e20b1842-2839-4317-8443-536a49e98caf.png">

### Sales screen:

* SalesViewController give us information about all current sales.

<img width="150" src="https://user-images.githubusercontent.com/79893831/133107590-b9459be2-dc76-410f-b723-b0ae4fbc636e.png">


### MyOrders screen:

* OrdersViewController has information about all user orders

<img width="150" src="https://user-images.githubusercontent.com/79893831/133108301-4662e67a-0bc4-499a-bebb-af9c297a424e.png">


### Basket Screen: 

* Here we can see all goods which we want to order, also we can decrement or increment amount of goods.

<img width="150" src="https://user-images.githubusercontent.com/79893831/133108631-d035da3c-b57f-4d96-9c26-5481698f6d56.png">

* If we did not auth we must auth with phone number

<img width="150" src="https://user-images.githubusercontent.com/79893831/133108922-9f9cff5d-4263-464b-b88d-2d3933343660.png"> <img width="150" src="https://user-images.githubusercontent.com/79893831/133201534-6a8b15f5-8881-4619-bc5e-90577be81de3.png">


### Order screen:

* After auth we can continue order goods, here we should enter address, comments and other order details

<img width="150" src="https://user-images.githubusercontent.com/79893831/133109270-fb9cc37a-3e32-4885-aee9-6ed0fcf7608d.png">
