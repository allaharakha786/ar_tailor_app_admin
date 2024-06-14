class ProductEvents {}

class GetProductEvent extends ProductEvents {}

class ClearImagePathEvent extends ProductEvents {}

class UploadProductImageEvent extends ProductEvents {}

class AddProductEvent extends ProductEvents {
  List<String> data;
  String collectionName;
  AddProductEvent({required this.data, required this.collectionName});
}

class InitialstateEvent extends ProductEvents {}

class UpdateProductEvent extends ProductEvents {
  String title;
  String price;
  String catagory;
  String details;
  dynamic docId;
  String collectionName;
  UpdateProductEvent(
      {required this.title,
      required this.price,
      required this.details,
      required this.catagory,
      required this.docId,
      required this.collectionName});
}
