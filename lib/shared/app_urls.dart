abstract class AppUrls {
  //! baseUrl
  static const String _baseUrl = "https://api.shaap.io";
  static const String _accountBaseUrl = "$_baseUrl/user/account";
  static const String _restaurantBaseUrl = '$_baseUrl/restaurant';
  static const String _ordersBaseUrl = "$_baseUrl/user/order";
  static const String _cartBaseUrl = "$_baseUrl/user/order/item";
  static const String _addressBaseUrl = "$_baseUrl/user/order/address";

  //! auth
  static const String userSignUp = '$_accountBaseUrl/register/';
  static String profileDetails({required String id}) =>
      '$_accountBaseUrl/setup/$id/';
  static const String userLogin = '$_accountBaseUrl/login/';
  static const String userLogout = '$_accountBaseUrl/logout/';
  static const String getUserData = '$_accountBaseUrl/token/';

  //! restaurant
  static const String getAllRestaurants = '$_restaurantBaseUrl/get/all/';
  static const String filterRestaurants = '$_restaurantBaseUrl/filter/';
  static String getRestaurantsBasedOnCuisine({required String cuisineName}) =>
      "$_restaurantBaseUrl/get/cuisine/$cuisineName";
  static String getRestaurantDetails({required String restaurantId}) =>
      "$_restaurantBaseUrl/get/$restaurantId";

  //!menu
  static String getRestaurantsMenuItems({required String restaurantId}) =>
      "$_restaurantBaseUrl/menu/item/get/all/$restaurantId";
  static String getRestaurantsMenuItemDetails({required String menuId}) =>
      "$_restaurantBaseUrl/menu/item/get/$menuId";

  //! orders
  static const String createAnOrder = '$_ordersBaseUrl/place/';
  static String checkIfOrderExistsInRestaurant(
          {required String restaurantId}) =>
      '$_ordersBaseUrl/exists/$restaurantId';
  static String getOrderDetails({required String orderId}) =>
      '$_ordersBaseUrl/details/$orderId';
  static const String getOrderHistory = '$_ordersBaseUrl/history/';

  //! cart
  static const String increaseCartItemQuantityAddItemsToCart =
      '$_cartBaseUrl/add/';
  static String getAllCartItems({required String orderId}) =>
      '$_cartBaseUrl/get/all/$orderId';
  static String removeItemFromCart({required String cartItemId}) =>
      '$_cartBaseUrl/delete/$cartItemId/';
  static String reduceItemFromCart({required String cartItemId}) =>
      '$_cartBaseUrl/reduce/$cartItemId/';

  //! addresses
  static const String createOrderAddress = '$_addressBaseUrl/add/';
  static const String getSavedAddress = '$_addressBaseUrl/get/saved/';
  static String editAddress({required String addressId}) =>
      '$_addressBaseUrl/edit/$addressId/';

  //! address !, area,
  //! address 2, specific, house
}
