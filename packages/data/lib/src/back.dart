import 'package:product_model/model.dart';

abstract class ProductService {
  Map<int, ProductData> array = {};
  Future<Map<int, ProductData>> createProducts(int number);
  ProductData getProductById(int id);
  String productsShow();
}
