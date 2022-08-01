class PackageModel{
  String? clientName;
  String? clientUid;
  String? packageName;
  int? packageId;
  String? toLocation;
  String? fromLocation;
  String? description;
  String? status;

  PackageModel({
    required this.toLocation,
    required this.fromLocation,
    required this.clientUid,
    required this.clientName,
    required this.packageName,
    required this.packageId,
    required this.description,
    required this.status,
});

  PackageModel.fromJson(Map<String, dynamic> json) {
    toLocation = json['toLocation'];
    fromLocation = json['fromLocation'];
    clientName = json['clientName'];
    clientUid = json['clientUid'];
    packageName = json['packageName'];
    packageId = json['packageId'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toMap(){
    return {
      'toLocation' : toLocation,
      'fromLocation' : fromLocation,
      'clientName' : clientName,
      'clientUid' : clientUid,
      'packageName' : packageName,
      'packageId' : packageId,
      'description' : description,
      'status' : status,
    };
  }
}