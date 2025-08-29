class ApiConstants{
  // static const String baseUrl = "http://192.168.40.142:5000/api/v1";
  // static const String imageBaseUrl = "http://192.168.40.142:5000";

  static const String baseUrl = "https://roam-mamun.sarv.live/api/v1";
  static const String imageBaseUrl = "https://roam-mamun.sarv.live/uploads/";
  static const String socketBaseUrl = "https://roam-mamun.sarv.live";


  static const String signUpEndPoint = "/auth/register";
  static const String signInEndPoint = "/auth/login";
  static const String accountDelete = "/users/delete";
  static const String verifyEmailEndPoint = "/auth/verify-email";
  static const String updateMoreInformationEndPoint = "/employee/update-employee-profile";
  static const String forgotPasswordPoint = "/auth/forgot-password";
  static const String resendOtpEndPoint = "/auth/resend-otp";
  static const String setPasswordEndPoint = "/auth/reset-password";
  static const String changePassword = "/auth/change-password";


  static const String support = "/setting/support";
  static const String updateProfile = "/user/me";
  static const String postJob = "/job";
  static const String nidUpload = "/tow-truck/";
  static const String towTruck = "/tow-truck";
  static const String jobDetails = "/job/details";
  static const String requestJob = "/job/req-providers";
  static  String acceptJob(String role) => "/job/${role}/accept";
  static const String completedProfile = "/tow-truck/complete-profile";
  static const String getJobFromUser = "/job/provider/requested";
  static  String getUserRequest(String role) => "/job/${role}/requested";
  static  String getJobOngoing(String role) => "/job/${role}/ongoing";
  static  String getJobCompleted(String role) => "/job/${role}/history";
  static  String message(String id) => "/message/${id}";
  static const String chatUser = "/message/thread/";
  static const String negotiate = "/job/neg";
  static const String cancelJob = "/job/cancel";
  static const String notification = "/notification";
  static const String paymentSend = "/payment/transaction/send";
  static const String completed = "/payment/transaction/transfer";



}