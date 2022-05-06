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

    for (var i = index; i < index + number; i++) {
      print('DATA: Product with index $i created');
      array[i] = ProductData(id: i);
    }
    index += number;
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
  Future<Map<ProductData, int>> give() async {
    Map<ProductData, int> _answer = {};

    await Future.delayed(const Duration(seconds: 1));

    for (var item in myCart) {
      if (_answer.keys.contains(item) == false) {
        _answer[item] = 1;
      } else {
        _answer[item] = _answer[item]! + 1;
      }
    }

    return out = _answer;
  }

  @override
  cleane() {
    myCart.clear();
    out.clear();
  }

  @override
  void addToCart(ProductData item) {
    myCart.add(item);
  }

  @override
  store() {
    return array.values;
  }

  @override
  show() {
    return out;
  }

  @override
  Map<ProductData, int> out = {};

  @override
  List<ProductData> myCart = [];
}
