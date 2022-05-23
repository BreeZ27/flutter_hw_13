import 'product_service.dart';
import 'package:injectable/injectable.dart';
import 'package:product_model/model.dart';

@LazySingleton(as: ProductService)
class ProductServiceImpl implements ProductService {
  static int index = 0;

  @override
  Map<ProductData, int> products = {};

  @override
  Future<Map<ProductData, int>> createProducts(int number) async {
    await Future.delayed(const Duration(milliseconds: 100));

    for (var i = index; i < index + number; i++) {
      print('DATA: Product with index $i created');
      products[ProductData(id: i)] = i;
    }
    index += number;
    return products;
  }

  @override
  Future<Map<ProductData, int>> productsStructurer() async {
    Map<ProductData, int> _answer = {};

    await Future.delayed(const Duration(seconds: 1));

    for (var item in myCart) {
      if (_answer.keys.contains(item) == false) {
        _answer[item] = 1;
      } else {
        _answer[item] = _answer[item]! + 1;
      }
    }

    return myCartStructured = _answer;
  }

  @override
  clean() {
    myCart.clear();
    myCartStructured.clear();
  }

  @override
  Map<ProductData, int> myCartStructured = {};

  @override
  List<ProductData> myCart = [];
}
