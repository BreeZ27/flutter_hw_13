import 'back.dart';
import 'package:injectable/injectable.dart';
import 'package:product_model/model.dart';

@LazySingleton(as: ProductService)
class MyProductService implements ProductService {
  static int index = 0;

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
  Future<ProductData> createOne() async {
    await Future.delayed(const Duration(seconds: 1));

    var _new = ProductData(id: index);

    array[index] = _new;
    index++;

    return _new;
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
