import 'package:product_model/model.dart';

abstract class ProductService {
  Map<ProductData, int> products = {};
  Future<Map<ProductData, int>> createProducts(int number);
  Future<Map<ProductData, int>> give();
  List<ProductData> myCart = [];
  Map<ProductData, int> myCartStructured = {};
  void clean();
}
