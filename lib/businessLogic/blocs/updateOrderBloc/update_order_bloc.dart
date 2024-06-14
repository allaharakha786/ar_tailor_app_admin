import 'package:ar_admin/businessLogic/blocs/updateOrderBloc/update_order_events.dart';
import 'package:ar_admin/businessLogic/blocs/updateOrderBloc/update_order_states.dart';
import 'package:ar_admin/helper/enums/status_enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateOrderBloc extends Bloc<UpdateOrderEvents, UpdateOrderStates> {
  UpdateOrderBloc()
      : super(UpdateOrderStates(states: StatusEnums.INITIAL_STATE)) {
    on<PaymentDropDownValueEvent>(paymentDropDownButton);
    on<OrderDropDownValueEvent>(orderDropDownMethod);
    on<UpdateOrderStatusEvent>(updateOrderStatusMethod);
  }
  updateOrderStatusMethod(
      UpdateOrderStatusEvent event, Emitter<UpdateOrderStates> emit) async {
    try {
      emit(state.copyWith(isLoading: true, states: StatusEnums.INITIAL_STATE));
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(event.indexId)
          .update({
        'paymentStatus': event.paymentValue,
        'status': event.orderValue
      });

      emit(state.copyWith(
        isLoading: false,
        states: StatusEnums.ORDER_STATUS_UPDATED,
      ));
    } catch (e) {
      emit(state.copyWith(states: StatusEnums.ERROR_STATE, isLoading: false));
    }
  }

  orderDropDownMethod(
      OrderDropDownValueEvent event, Emitter<UpdateOrderStates> emit) {
    emit(state.copyWith(
        orderValue: event.orderValue, states: StatusEnums.INITIAL_STATE));
  }

  paymentDropDownButton(
      PaymentDropDownValueEvent event, Emitter<UpdateOrderStates> emit) {
    emit(state.copyWith(
        paymentValue: event.paymentValue, states: StatusEnums.INITIAL_STATE));
  }
}
