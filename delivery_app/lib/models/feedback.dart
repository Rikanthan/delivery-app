class Feedbacks {
  factory Feedbacks.fromJson(Map<String, dynamic> json) {
    return Feedbacks(
        feedbackId: json['feedbackId'] as int,
        name: json['name'] as String,
        phoneNumber: json['phoneNumber'] as String,
        email: json['email'] as String,
        message : json['message'] as String ,
        rating: json['rating'] as int,
        sendDate: json['sentDate'] as String,
    );    
  }
  Feedbacks(
      {
        this.feedbackId,
        this.name,
        this.phoneNumber,
        this.email,
        this.message,
        this.rating,
        this.sendDate
      });
  int? feedbackId;
  String? name;
  String? phoneNumber;
  String? email;
  String? message;
  int? rating;
  String? sendDate;
}