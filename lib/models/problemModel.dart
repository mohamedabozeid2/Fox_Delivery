class ProblemModel{
  String? clientFirstName;
  String? clientLastName;
  String? clientUid;
  String? problem;
  String? phoneNumber;

  ProblemModel({
    required this.clientUid,
    required this.clientLastName,
    required this.clientFirstName,
    required this.problem,
    required this.phoneNumber
});

  ProblemModel.fromJson(Map<String, dynamic> json){
    clientFirstName = json['clientFirstName'];
    clientUid = json['clientUid'];
    clientLastName = json['clientLastName'];
    problem = json['problem'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toMap(){
    return {
      'clientFirstName' : clientFirstName,
      'clientLastName' : clientLastName,
      'clientUid' : clientUid,
      'problem' : problem,
      'phoneNumber' : phoneNumber,
    };
  }
}