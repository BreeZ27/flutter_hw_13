import 'package:data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductBlock extends ChangeNotifier {
  final ProductService productService;

  ProductBlock({required this.productService}) {
    productService.createProducts(5);
  }

  void addToCart(item) async {
    productService.myCart.add(item);
    await productService.give();
    notifyListeners();
  }

  void cleane() {
    productService.cleane();
    notifyListeners();
  }

  goods() {
    return productService.array.values;
  }

  show() {
    return productService.out;
  }

  sum() {
    var res = 0;
    for (var item in productService.out.values) {
      res += item;
    }
    res *= 48;
    return res;
  }
}
