import 'package:data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

GetIt getIt = GetIt.instance;

@injectable
class ProductBlock extends ChangeNotifier {
  late final ProductService productService;

  ProductBlock() {
    productService = getIt.get<ProductService>();
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
    return productService.array;
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
