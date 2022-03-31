import 'back.dart';
import 'package:injectable/injectable.dart';
import 'package:product_model/model.dart';

@LazySingleton(as: ProductService)
class MyProductService implements ProductService {
  @override
  Map<int, ProductData> array = {};

  @override
  Future<Map<int, ProductData>> createProducts(int number) async {
    await Future.delayed(const Duration(milliseconds: 100));

    for (var i = 0; i < number; i++) {
      array[i] = ProductData(id: i);
    }
    return array;
  }

  @override
  ProductData getProductById(int id) {
    var _prod = array[id];
    return _prod!;
  }

  @override
  String productsShow() {
    return array.toString();
  }
}
