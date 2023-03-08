abstract class AppUrls {
  //! baseUrl
  static const String _accountBaseUrl = "https://api.shaap.io/user/account";

  //! auth
  static const String userSignUp = '$_accountBaseUrl/register/';
  static String profileDetails({required String id}) =>
      '$_accountBaseUrl/setup/$id/';
  static const String userLogin = '$_accountBaseUrl/login/';
  static const String userLogout = '$_accountBaseUrl/logout/';
}
