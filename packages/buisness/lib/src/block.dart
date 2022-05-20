import 'package:data/data.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

GetIt getIt = GetIt.instance;

@injectable
class ProductBlock {
  final ProductService productService = getIt.get<ProductService>();

  ProductBlock() {
    print('ProductBlock created ${productService.hashCode}');
  }

  // Функция, которая добавляет указанный товар в список myCart
  void addToCart(item) {
    productService.myCart.add(item);
    print('ProductBlock.addToCart(): ${productService.myCart}');
  }

  // Функция, которая создаёт указанное количество товаров в Map array
  void createProducts(int value) {
    productService.createProducts(value);
  }

  // Функция которая очищает корзину и фоsрматированный Map out
  void clean() {
    productService.myCart.clear();
    productService.out.clear();
  }

  // Функция, которая оценивает количсество каждого товара в корзине и
  //формирует Map, который передает в переменную out
  give() async {
    await productService.give();
    print('ProductBlock.give(): ${productService.out}');
  }

  // Функция, которая возвращает Map с существующими товарами
  goods() {
    print('ProductBlock.goods(): ${productService.array}');
    return productService.array;
  }

  // Функция, которая возвращает Map с товарами в корзине и их количеством
  show() {
    print('ProductBlock.show(): ${productService.out}');
    return productService.out;
  }
}
