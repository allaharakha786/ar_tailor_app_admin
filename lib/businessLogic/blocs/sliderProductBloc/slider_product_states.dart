import 'package:ar_admin/helper/enums/status_enums.dart';

class SliderProductStates {
  StatusEnums states;
  List data;

  SliderProductStates({
    this.states = StatusEnums.INITIAL_STATE,
    this.data = const [],
  });

  SliderProductStates copyWith({
    StatusEnums? states,
    List? data,
  }) {
    return SliderProductStates(
      states: states ?? this.states,
      data: data ?? this.data,
    );
  }

  List<Object>? get props => [
        states,
        data,
      ];
}
