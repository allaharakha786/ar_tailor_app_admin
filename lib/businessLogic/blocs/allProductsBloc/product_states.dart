import 'package:ar_admin/helper/enums/status_enums.dart';

class ProductStates {
  StatusEnums states;
  String imageUrl;
  List data;
  bool isImageUploading;
  bool isLoading;
  ProductStates(
      {this.states = StatusEnums.INITIAL_STATE,
      this.data = const [],
      this.imageUrl = '',
      this.isImageUploading = false,
      this.isLoading = false});

  ProductStates copyWith(
      {StatusEnums? states,
      List? data,
      String? imageUrl,
      bool? isImageUploading,
      bool? isLoading}) {
    return ProductStates(
        states: states ?? this.states,
        data: data ?? this.data,
        imageUrl: imageUrl ?? this.imageUrl,
        isImageUploading: isImageUploading ?? this.isImageUploading,
        isLoading: isLoading ?? this.isLoading);
  }

  List<Object>? get props =>
      [states, imageUrl, data, isImageUploading, isLoading];
}
