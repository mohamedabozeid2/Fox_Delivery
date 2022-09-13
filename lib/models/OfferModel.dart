class OfferModel{
  String? label;
  String? body;
  String? offerImage;
  String? offerPercentage;
  String? expire;



  OfferModel({
    required this.label,
    required this.body,
    required this.offerImage,
    required this.offerPercentage,
    required this.expire,

  });

  OfferModel.fromJson(Map<String, dynamic> json){
    label = json['label'];
    body = json['body'];
    offerImage = json['offerImage'];
    offerPercentage = json['offerPercentage'];
    expire = json['expire'];

  }

  Map<String, dynamic> toMap(){
    return {
      'label' : label,
      'body' : body,
      'offerImage' : offerImage,
      'offerPercentage' : offerPercentage,
      'expire' : expire,
    };
  }
}