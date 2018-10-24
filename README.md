Application uses MVVM architecture. It has 5 View (ProductsViewController, ProductDetailViewController, FavoritesViewController, CartViewController, ProductTableViewCell)

Each view has one view model. I used property injection to define view model.

I used 3 third party api ; Moya for networking, Quick and Nimble for testing. I implement them using Cocoapods.

I used Core Data to manage Favorites.

I try to use protocol oriented approach to generate classes.

The application can handle all the prioritised list of user stories:
1. As a Customer I can view the products and their category, price and availability information. 2. As a Customer I can add a product to my shopping cart.
3. As a Customer I can remove a product from my shopping cart.
4. As a Customer I can view the total price for the products in my shopping cart.
5. As a Customer I am unable to add Out of Stock products to the shopping cart. 6. As a Customer I can add a product to my wishlist.
7. As a Customer I can remove a product from my wishlist.
8. As a Customer I can move a product from my wishlist to the shopping cart.