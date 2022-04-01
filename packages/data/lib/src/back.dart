import 'package:product_model/model.dart';

abstract class ProductService {
  Map<int, ProductData> array = {};
  Future<Map<int, ProductData>> createProducts(int number);
  Future<ProductData> createOne();
  ProductData getProductById(int id);
  String productsShow();
  Iterable<ProductData> give();
}

abstract class BoxService {
  List<ProductData> array = [];
  void addProductById(int id);
  // Iterable<ProductData> give();
}
