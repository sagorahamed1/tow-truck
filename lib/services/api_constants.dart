class ApiConstants{
  // static const String baseUrl = "http://192.168.40.142:5000/api/v1";
  // static const String imageBaseUrl = "http://192.168.40.142:5000";

  static const String baseUrl = "https://roam-mamun.sarv.live/api/v1";
  static const String imageBaseUrl = "https://roam-mamun.sarv.live";


  static const String signUpEndPoint = "/auth/register";
  static const String signInEndPoint = "/auth/login";
  static const String accountDelete = "/users/delete";
  static const String verifyEmailEndPoint = "/auth/verify-email";
  static const String updateMoreInformationEndPoint = "/employee/update-employee-profile";
  static const String forgotPasswordPoint = "/auth/forgot-password";
  static const String resendOtpEndPoint = "/auth/resend-otp";
  static const String setPasswordEndPoint = "/auth/reset-password";
  static const String userServicesEndPoint = "/services/get-service";
  static const String userBookEndPoint = "/customer/create-appointment";
  static const String changePassword = "/settings/change-password";
  static const String profileEndPoint = "/settings/get-login-user";
  static const String updateProfile = "/user-profile-update";
  static const String employeeUnableToService = "/employee/create-unable-appointment";
  static const String employeeCheckInAppointment = "/employee/employee-checkIn-appointment";
  static const String employeeUnAbleToService = "/employee/create-unable-appointment";
  static const String employeeWorkSubmission = "/employee/work-submission";
  static const String employeeWorkSubmissionPhoto = "/employee/work-upload-photo";

  static  String userAppointmentEndPoint(String page) => "/customer/login-user-appointment-list?page=$page&limit=10";
  static  String userAppointmentDetailsEndPoint(String id) => "/customer/login-user-assign-appointment-list/$id";
  static  String userAssignAppointmentEndPoint(String page) => "/customer/login-user-assign-appointment-list?page=$page";
  static  String employeeCheckInEndPoint({String status = ''}) => "/employee/create-and-update-attendance?status=$status";
  static  String employeeTextField({String id = ''}) => "/employee/get-Input-field?serviceId=$id";
  static  String getSubMission({String id = ''}) => "/employee/get-work-submission?assignAppointmentId=$id";
  static  String getSubMissionUser({String id = ''}) => "/customer/appointment-result?assignAppointmentId=$id";
  static  String employeeCheckBox({String id = ''}) => "/employee/get-CheckBox-field?serviceId=$id";
  static  String employeeAppointmentEndPoint(String page,{String date = ''}) => "/employee/get-assign-appointment?page=$page&searchDate=$date";





  ///manager
  static  String managerRequestAppointment({required String id}) => "/manager/get-appointment-request/$id";
  static  String managerGetEmployee({required String search}) => "/manager/get-employee?search=${search}";
  static  String managerGetCustomer({required String search}) => "/manager/get-customers?search=${search}";
  static  String managerGetAppointment({required String date}) => "/manager/get-assign-appointment?endDate=${date}";
  static  String serviceTechDetails({required String id}) => "/manager/get-employee/${id}";
  static  String managerSchudule({required String id, date}) => "/manager/get-assign-employee-appointment?employeeId=$id&appointmentDate=$date";
  static  String employeeAttendance({required String id, date}) => "/admin/get-all-employee-attendance?date=$date&id=$id";
  static const String managerGetService = "/manager/get-service";
  static  String notification(String page) => "/notification?page=$page";
  static const String managerAssignAppointment = "/manager/assign-employee";
  static const String getUnAbleToService = "/manager/unable-service-request-list";
  static const String privacyPolicy = "/settings/privacy-policy";
  static const String termCondition = "/settings/terms-condition";
  static const String aboutUs = "/settings/about-us";
  static const String updateDateAppointment = "/manager/update-appointment-request-date";
  static const String changeServiceTech = "/manager/change-service-tech";
  static  String unAbleToServiceDenyOrAccept({String id = ""}) => "/manager/unable-service-status?id=$id";



  ///Chat==>
  static const String getChatUserList = "/chat/get-chat";
  static const String createChat = "/chat/chat-create";
  static const String sendMessageWithImage = "/chat/create-message-with-file";
  static const String unreadUserMessageCount = "/users/unreadCount";
  static  String getMessage({String id = '', page}) => "/chat/get-message/$id?page=${page??""}";
}