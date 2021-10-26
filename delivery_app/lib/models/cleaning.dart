class Cleaning {
  factory Cleaning.fromJson(Map<String, dynamic> json) {
    return Cleaning(
        orderID: json['orderId'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        address: json['address'] as String,
        description: json['description'] as String,
        orderDate: json['orderDate'] as String,
        status: json['status'] as String,
        phone: json['phone'] as String
    );    
  }
  Cleaning(
      {
      this.orderID,
      this.name,
      this.email,
      this.address,
      this.description,
      this.orderDate,
      this.status,
      this.phone
      });
  int? orderID;
  String? name;
  String? email;
  String? address;
  String? phone;
  String? status;
  String? orderDate;
  String? description;
}