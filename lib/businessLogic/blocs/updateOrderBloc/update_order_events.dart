class UpdateOrderEvents {}

class PaymentDropDownValueEvent extends UpdateOrderEvents {
  String? paymentValue;
  PaymentDropDownValueEvent({required this.paymentValue});
}

class OrderDropDownValueEvent extends UpdateOrderEvents {
  String? orderValue;
  OrderDropDownValueEvent({required this.orderValue});
}

class UpdateOrderStatusEvent extends UpdateOrderEvents {
  String? paymentValue;
  String? orderValue;
  dynamic indexId;
  UpdateOrderStatusEvent(
      {required this.orderValue,
      required this.paymentValue,
      required this.indexId});
}
