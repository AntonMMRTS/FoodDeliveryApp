## FoodDeliveryApp


FoodDeliveryApp is my pet-project, it is classical food delivery application, pretty simple for users.
The application is based on the MVC pattern. User interface was make in code, without storyboard. 
We use Firebase for storage and getting data., also for authentication with phone number.
For adding and storage goods to basket use Realm database.
For cache images from Firebase Storage use library SDWebImage or NSCache.
Almost every viewController has UICollectionView or UITableView.

## Description

### The home screen of the application is the MenuViewController:

![Screenshot 2021-03-05 at 11 12 52](https://user-images.githubusercontent.com/79893831/133057523-e760dbee-f749-4b6d-af0d-a4f9f98647cb.png)

* Image is uploaded via SDWebImage.
* By clicking on the red button  we add good to the basket.
* On the top part of screen there is list of categories (Pizza, Pasta, Lasagna etc..)
* By clicking on the goods cell we open ProductDetailViewController which contain detail information about good (price, weight, energy value) etc
![Screenshot 2021-03-05 at 11 12 52](https://user-images.githubusercontent.com/79893831/133063401-4ef09f1e-4057-4e92-b839-a7868e31b551.png)

### Sales screen:

![Simulator Screen Shot - iPhone 11 - 2021-09-13 at 16 54 28](https://user-images.githubusercontent.com/79893831/133063792-8fd0c857-1300-409e-b8d1-1404740f9780.png)

* SalesViewController give us information about all current sales.


### MyOrders screen:

* OrdersViewController has information about all user orders

![Simulator Screen Shot - iPhone 11 - 2021-09-13 at 16 57 48](https://user-images.githubusercontent.com/79893831/133064686-4209f3a8-f3ea-4050-bf4d-47ed566215b4.png)


### Basket Screen: 

![Simulator Screen Shot - iPhone 11 - 2021-09-13 at 17 02 49](https://user-images.githubusercontent.com/79893831/133065099-31dba57f-e91f-46cd-8e2c-40182e3c695b.png)

* Here we can see all goods which we want to order, also we can decrement or increment amount of goods.
* If we did not auth we must auth with phone number
![Simulator Screen Shot - iPhone 11 - 2021-09-13 at 17 09 55](https://user-images.githubusercontent.com/79893831/133066501-31c87010-f93a-4dfe-a866-5a2c9f6e4156.png)


### Order screen:

* After auth we can continue order goods, here we should enter adress, comments and other order details
![Simulator Screen Shot - iPhone 11 - 2021-09-13 at 17 17 17](https://user-images.githubusercontent.com/79893831/133066996-efeb4563-fba0-49c4-8f60-2bd9a1d5d046.png)
