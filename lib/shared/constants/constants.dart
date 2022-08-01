import 'package:fox_delivery/models/PackageModel.dart';
import 'package:fox_delivery/models/UserMdeol.dart';

String selectedLanguage = 'en';
dynamic uId = "";
FoxUserModel? userModel;
List<PackageModel> userPackages = [];
String verificationIDReceived = '';
bool onBoarding = false;
int packageIDCounter = 0;
