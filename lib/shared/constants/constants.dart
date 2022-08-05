import 'package:flutter_zoom_drawer/config.dart';
import 'package:fox_delivery/models/PackageModel.dart';
import 'package:fox_delivery/models/UserMdeol.dart';

String selectedLanguage = 'en';
dynamic uId = "";
FoxUserModel? userModel;
List<PackageModel> userPackages = [];
List<String> packagesID = [];
String verificationIDReceived = '';
bool onBoarding = false;
int packageIDCounter = 1;
double sliderValue = 0;
String packageStatus = '';
DateTime now =  DateTime.now();
final drawerController = ZoomDrawerController();

