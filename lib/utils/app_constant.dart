
class AppConstants{

  ///=======================Prefs Helper data===============================>
  static const String role = "role";
  // static String roleMock = 'roleMock';
  static String bearerToken = 'token';
  static String email = 'email';
  static String name = 'name';
  static String isLogged = 'isLogged';
  static String isHotDeals = 'true';
   static String userId = 'userId';
  static String userIdTest = '';
  static String businessID = '';
  static String image = '';
  static String dateOfBirth = '';
  static String stribeUrl = '';

  static RegExp emailValidate = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static bool validatePassword(String value) {
    RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]).{8,}$');
    return regex.hasMatch(value);
  }



}
enum Status { loading, completed, error, internetError }