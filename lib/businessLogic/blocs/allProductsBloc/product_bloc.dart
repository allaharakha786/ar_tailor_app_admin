import 'dart:io';

import 'package:ar_admin/businessLogic/blocs/allProductsBloc/product_events.dart';
import 'package:ar_admin/businessLogic/blocs/allProductsBloc/product_states.dart';
import 'package:ar_admin/helper/enums/status_enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class ProductBloc extends Bloc<ProductEvents, ProductStates> {
  ProductBloc() : super(ProductStates(states: StatusEnums.INITIAL_STATE)) {
    on<GetProductEvent>(getProductsMethod);
    on<UploadProductImageEvent>(uploadProductImage);
    on<ClearImagePathEvent>(clearImagePath);
    on<AddProductEvent>(addProductMethod);
    on<UpdateProductEvent>(updateProductMethod);
    on<InitialstateEvent>(initialstatemethod);
  }
  initialstatemethod(InitialstateEvent event, Emitter<ProductStates> emit) {
    emit(state.copyWith(states: StatusEnums.INITIAL_STATE));
  }

  addProductMethod(AddProductEvent event, Emitter<ProductStates> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await FirebaseFirestore.instance
          .collection(event.collectionName)
          .doc()
          .set({
        'title': event.data[0],
        'details': event.data[1],
        'price': event.data[2],
        'catagory': event.data[3],
        'imageUrl': event.data[4]
      });
      emit(state.copyWith(
          states: StatusEnums.PRODUCT_ADDED_STATE, isLoading: false));
    } catch (e) {
      emit(state.copyWith(states: StatusEnums.ERROR_STATE, isLoading: false));
    }
  }

  uploadProductImage(
      UploadProductImageEvent event, Emitter<ProductStates> emit) async {
    try {
      var status = await Permission.storage.status;

      if (status.isGranted) {
        FilePickerResult? pickedFile =
            await FilePicker.platform.pickFiles(type: FileType.media);

        if (pickedFile != null) {
          emit(state.copyWith(
              states: StatusEnums.IMAGE_UPLOADING_STATE,
              isImageUploading: true));

          String path = pickedFile.files.single.path!;
          String fileName = path.split('/').last;
          final ref = FirebaseStorage.instance.ref().child('images/$fileName');

          final uploadTask = ref.putFile(File(path));
          var snap = await uploadTask.whenComplete(() => null);
          final downloadUrl = await snap.ref.getDownloadURL();

          emit(state.copyWith(
              states: StatusEnums.IMAGE_UPLOADED_STATE,
              imageUrl: downloadUrl,
              isImageUploading: false));
        }
      } else {
        await Permission.storage.request();
      }
    } catch (e) {
      emit(state.copyWith(
          states: StatusEnums.ERROR_STATE, isImageUploading: false));
    }
  }

  clearImagePath(ClearImagePathEvent event, Emitter<ProductStates> emit) {
    emit(state.copyWith(imageUrl: ''));
  }

  getProductsMethod(GetProductEvent event, Emitter<ProductStates> emit) async {
    try {
      emit(state.copyWith(states: StatusEnums.LOADING_STATE));
      QuerySnapshot<Map<String, dynamic>> data =
          await FirebaseFirestore.instance.collection('cloths').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshot = data.docs;

      emit(state.copyWith(
          states: StatusEnums.PRODUCT_LOADED_STATE, data: snapshot));
    } catch (e) {
      emit(state.copyWith(states: StatusEnums.ERROR_STATE));
    }
  }

  updateProductMethod(
      UpdateProductEvent event, Emitter<ProductStates> emit) async {
    try {
      emit(state.copyWith(states: StatusEnums.LOADING_STATE, isLoading: true));
      await FirebaseFirestore.instance
          .collection(event.collectionName)
          .doc(event.docId)
          .update({
        'title': event.title,
        'details': event.details,
        'price': event.price,
        'catagory': event.catagory
      });

      emit(state.copyWith(
          states: StatusEnums.PRODUCT_UPDATED_STATE, isLoading: false));
    } catch (e) {
      emit(state.copyWith(states: StatusEnums.ERROR_STATE, isLoading: false));
    }
  }
}
