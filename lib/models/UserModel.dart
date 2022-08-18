class FoxUserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? deviceToken;
  String? phone;
  String? location;
  String? uId;
  int? packageNumber;
  int? completedPackages;
  int? notCompletedPackages;
  bool? isEmailVerified;

  FoxUserModel({
    required this.firstName,
    required this.lastName,
    required this.uId,
    required this.email,
    required this.phone,
    required this.location,
    required this.isEmailVerified,
    required this.deviceToken,
    required this.completedPackages,
    required this.notCompletedPackages,
    required this.packageNumber
  });

  FoxUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    deviceToken = json['deviceToken'];
    lastName = json['lastName'];
    phone = json['phone'];
    location = json['location'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    completedPackages = json['completedPackages'];
    notCompletedPackages = json['notCompletedPackages'];
    packageNumber = json['packageNumber'];
  }

  Map<String, dynamic> toMap(){
    return {
      'firstName' : firstName,
      'lastName' : lastName,
      'email' : email,
      'phone' : phone,
      'uId' : uId,
      'location' : location,
      'deviceToken' : deviceToken,
      'isEmailVerified' : isEmailVerified,
      'completedPackages' : completedPackages,
      'notCompletedPackages' : notCompletedPackages,
      'packageNumber' : packageNumber,
    };
  }
}
