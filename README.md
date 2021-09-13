## FoodDeliveryApp


FoodDeliveryApp is my pet-project, it is classical food delivery application, pretty simple for users.
The application is based on the MVC pattern. User interface was make in code, without storyboard. 
We use Firebase for storage and getting data., also for authentication with phone number.
For adding and storage goods to basket use Realm database.
For cache images from Firebase Storage use library SDWebImage or NSCache.
Almost every viewController has UICollectionView or UITableView.

## Description

### The home screen of the application is the MenuViewController:

![Screenshot 2021-03-05 at 11 12 52](https://user-images.githubusercontent.com/79893831/133105293-6bf373b8-bc4e-43ad-a58e-0dd29e184407.png)

* Image is uploaded via SDWebImage.
* By clicking on the red button  we add good to the basket.
* On the top part of screen there is list of categories (Pizza, Pasta, Lasagna etc..)
* By clicking on the goods cell we open ProductDetailViewController which contain detail information about good (price, weight, energy value) etc

![Screenshot 2021-03-05 at 11 12 52](https://user-images.githubusercontent.com/79893831/133106134-9d33119d-52ed-4547-b292-bd31c683245e.png)

### Sales screen:

* SalesViewController give us information about all current sales.

![Simulator Screen Shot - iPhone 11 - 2021-09-13 at 16 54 28](https://user-images.githubusercontent.com/79893831/133107590-b9459be2-dc76-410f-b723-b0ae4fbc636e.png)


### MyOrders screen:

* OrdersViewController has information about all user orders

![Simulator Screen Shot - iPhone 11 - 2021-09-13 at 16 57 48](https://user-images.githubusercontent.com/79893831/133108301-4662e67a-0bc4-499a-bebb-af9c297a424e.png)


### Basket Screen: 

* Here we can see all goods which we want to order, also we can decrement or increment amount of goods.

![Simulator Screen Shot - iPhone 11 - 2021-09-13 at 17 02 49](https://user-images.githubusercontent.com/79893831/133108631-d035da3c-b57f-4d96-9c26-5481698f6d56.png)

* If we did not auth we must auth with phone number

![Simulator Screen Shot - iPhone 11 - 2021-09-13 at 17 09 55](https://user-images.githubusercontent.com/79893831/133108922-9f9cff5d-4263-464b-b88d-2d3933343660.png)


### Order screen:

* After auth we can continue order goods, here we should enter adress, comments and other order details

![Simulator Screen Shot - iPhone 11 - 2021-09-13 at 17 17 17](https://user-images.githubusercontent.com/79893831/133109270-fb9cc37a-3e32-4885-aee9-6ed0fcf7608d.png)
