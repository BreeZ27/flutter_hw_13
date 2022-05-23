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
    // productService.createProducts(5);
  }

  addToCart(item) async {
    productService.myCart.add(item);
    await productService.productsStructurer();
    notifyListeners();
  }

  createProducts(int value) async {
    await productService.createProducts(value);
    notifyListeners();
  }

  void clean() {
    productService.clean();
    notifyListeners();
  }

  goods() {
    return productService.products;
  }

  show() {
    return productService.myCartStructured;
  }

  sum() {
    var res = 0;
    for (var item in productService.myCartStructured.values) {
      res += item;
    }
    res *= 48;
    return res;
  }
}

// @injectable
// class ProductBlock {
//   final ProductService productService = getIt.get<ProductService>();

//   ProductBlock() {
//     print('ProductBlock created ${productService.hashCode}');
//   }

//   // Функция, которая добавляет указанный товар в список myCart
//   void addToCart(item) {
//     productService.myCart.add(item);
//     print('ProductBlock.addToCart(): ${productService.myCart}');
//   }

//   // Функция, которая создаёт указанное количество товаров в Map array
//   Future<void> createProducts(int value) async {
//     await productService.createProducts(value);
//   }

//   // Функция которая очищает корзину и форматированный Map out
//   void clean() {
//     productService.clean();
//     notifyListeners();
//   }

//   // Функция, которая оценивает количсество каждого товара в корзине и
//   //формирует Map, который передает в переменную out
//   give() async {
//     await productService.productsStructurer();
//     print('ProductBlock.give(): ${productService.myCartStructured}');
//     notifyListeners();
//   }

//   // Функция, которая возвращает Map с существующими товарами
//   goods() {
//     print('ProductBlock.goods(): ${productService.products}');
//     return productService.products;
//   }

//   // Функция, которая возвращает Map с товарами в корзине и их количеством
//   show() {
//     print('ProductBlock.show(): ${productService.myCartStructured}');
//     return productService.myCartStructured;
//   }

//   sum() {
//     var res = 0;
//     for (var item in productService.out.values) {
//       res += item;
//     }
//     res *= 48;
//     return res;
//   }
// }
