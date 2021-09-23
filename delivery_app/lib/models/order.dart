class Order {
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        orderID: json['orderId'],
        ownerName: json['ownerName'],
        stockAddress: json['stockAddress'],
        deliveryAddress: json['deliveryAddress'],
        ownerEmail: json['ownerEmail'],
        ownerPhone: json['ownerPhoneNumber'],
        status: json['status'],
        orderDate: json['orderDate']
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
      this.orderDate});
  int? orderID;
  String? ownerPhone;
  String? ownerName;
  String? stockAddress;
  String? deliveryAddress;
  String? ownerEmail;
  String? status;
  String? orderDate;
}