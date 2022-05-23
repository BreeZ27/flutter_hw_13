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
  Future<void> addToCart(item) async {
    productService.myCart.add(item);
    await productService.productsStructurer();
    print('ProductBlock.addToCart(): ${productService.myCart}');
  }

  // Функция, которая создаёт указанное количество товаров в Map array
  Future<void> createProducts(int value) async {
    await productService.createProducts(value);
  }

  // Функция которая очищает корзину и фоsрматированный Map out
  void clean() {
    productService.myCart.clear();
    productService.myCartStructured.clear();
  }

  // Функция, которая оценивает количсество каждого товара в корзине и
  //формирует Map, который передает в переменную out
  productsStructurer() async {
    await productService.productsStructurer();
    print('ProductBlock.give(): ${productService.myCartStructured}');
  }

  // Функция, которая возвращает Map с существующими товарами
  goods() {
    print('ProductBlock.goods(): ${productService.products}');
    return productService.products;
  }

  // Функция, которая возвращает Map с товарами в корзине и их количеством
  show() {
    print('ProductBlock.show(): ${productService.myCartStructured}');
    return productService.myCartStructured;
  }
}
