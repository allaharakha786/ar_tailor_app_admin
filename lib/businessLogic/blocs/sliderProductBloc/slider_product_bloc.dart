import 'package:ar_admin/businessLogic/blocs/sliderProductBloc/slider_product_events.dart';
import 'package:ar_admin/businessLogic/blocs/sliderProductBloc/slider_product_states.dart';
import 'package:ar_admin/helper/enums/status_enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliderProductBloc extends Bloc<SliderProductEvent, SliderProductStates> {
  SliderProductBloc()
      : super(SliderProductStates(states: StatusEnums.INITIAL_STATE)) {
    on<GetSliderProductEvent>(getProductsMethod);
  }

  getProductsMethod(
      GetSliderProductEvent event, Emitter<SliderProductStates> emit) async {
    try {
      emit(state.copyWith(states: StatusEnums.LOADING_STATE));
      QuerySnapshot<Map<String, dynamic>> data =
          await FirebaseFirestore.instance.collection('sliderImages').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshot = data.docs;
      emit(state.copyWith(
          states: StatusEnums.PRODUCT_LOADED_STATE, data: snapshot));
    } catch (e) {
      emit(state.copyWith(states: StatusEnums.ERROR_STATE));
    }
  }
}
