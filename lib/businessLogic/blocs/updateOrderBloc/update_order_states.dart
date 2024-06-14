import 'package:ar_admin/helper/enums/status_enums.dart';

class UpdateOrderStates {
  StatusEnums states;
  String paymentValue;
  String orderValue;
  bool isLoading;

  UpdateOrderStates(
      {this.states = StatusEnums.INITIAL_STATE,
      this.paymentValue = 'Pending',
      this.orderValue = 'Pending',
      this.isLoading = false});

  UpdateOrderStates copyWith(
      {StatusEnums? states,
      String? orderValue,
      String? paymentValue,
      bool? isLoading}) {
    return UpdateOrderStates(
        states: states ?? this.states,
        orderValue: orderValue ?? this.orderValue,
        paymentValue: paymentValue ?? this.paymentValue,
        isLoading: isLoading ?? this.isLoading);
  }

  List<Object>? get props => [states, orderValue, paymentValue, isLoading];
}
