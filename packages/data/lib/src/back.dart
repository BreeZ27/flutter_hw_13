import 'package:product_model/model.dart';

abstract class ProductService {
  Map<int, ProductData> array = {};
  Future<Map<int, ProductData>> createProducts(int number);
  Future<Map<ProductData, int>> give();
  List<ProductData> myCart = [];
  Map<ProductData, int> out = {};
  void cleane();
}
