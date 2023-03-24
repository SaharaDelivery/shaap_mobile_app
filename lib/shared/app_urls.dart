abstract class AppUrls {
  //! baseUrl
  static const String _baseUrl = "https://api.shaap.io";
  static const String _accountBaseUrl = "$_baseUrl/user/account";
  static const String _restaurantBaseUrl = '$_baseUrl/restaurant';

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
  static const String getRestaurantsBasedOnCuisine =
      '$_restaurantBaseUrl/get/cuisine/<cuisine>/';
}
