class Transport {
  factory Transport.fromJson(Map<String, dynamic> json) {
    return Transport(
        orderID: json['orderId']  as int,
        email: json['email'] as String,
        phone: json['phone'] as String,
        frightTo: json['frightTo'] as String,
        address: json['address'] as String ,
        description: json['description'] as String,
        status: json['status'] as String,
        name: json['name'] as String,
        orderDate: json['orderDate'] as String,
        frightFrom: json['frightfrom'] as String
    );    
  }
  Transport(
      {
      this.orderID,
      this.email,
      this.phone,
      this.frightTo,
      this.address,
      this.description,
      this.status,
      this.name,
      this.orderDate,
      this.frightFrom
      });
  int? orderID;
  String? phone;
  String? name;
  String? frightTo;
  String? frightFrom;
  String? email;
  String? status;
  String? orderDate;
  String? description;
  String? address;
}