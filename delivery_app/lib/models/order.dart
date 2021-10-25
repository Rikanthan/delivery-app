class Order {
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        orderID: json['orderId'] as int,
        ownerName: json['ownerName'] as String,
        stockAddress: json['stockAddress'] as String,
        deliveryAddress: json['deliveryAddress'] as String,
        ownerEmail: json['ownerEmail'] as String ,
        ownerPhone: json['ownerPhoneNumber'] as String,
        status: json['status'] as String,
        orderDate: json['orderDate'] as String,
        description: json['description'] as String
    );    
  }
//https://laraexpress.herokuapp.com/order/getAllOrder
  Order(
      {
      this.orderID,
      this.ownerName,
      this.stockAddress,
      this.deliveryAddress,
      this.ownerEmail,
      this.ownerPhone,
      this.status,
      this.orderDate,
      this.description});
  int? orderID;
  String? ownerPhone;
  String? ownerName;
  String? stockAddress;
  String? deliveryAddress;
  String? ownerEmail;
  String? status;
  String? orderDate;
  String? description;
}