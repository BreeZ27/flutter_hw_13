import 'package:data/data.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:product_model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

GetIt getIt = GetIt.instance;

enum ProductBlockEvent { clear, add, toCart }

class MyBLoC extends Cubit<ProductBlock> {
  // Переменная, которая при инициализации и вызове метода add() один раз
  //создаёт товары в Map array
  static int init = 0;

  // Функция, которая создаёт копию текущего ProductBlock
  // используется для передачи в функцию emit нового состояния ProductBlock
  duplicate(ProductBlock inlet) {
    ProductBlock _outlet = ProductBlock();
    _outlet.productService.out = inlet.productService.out;
    _outlet.productService.array = inlet.productService.array;
    _outlet.productService.myCart = inlet.productService.myCart;
    return _outlet;
  }

  MyBLoC() : super(ProductBlock());

  void add() {
    if (init == 0) {
      state.createProducts(5);
      init++;
    }
    emit(duplicate(state));
  }

  void clear() {
    state.clean();
    emit(duplicate(state));
  }

  void toCart(ProductData e) async {
    state.addToCart(e);
    await state.give();
    emit(duplicate(state));
  }
}

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

  // Функция которая очищает корзину и форматированный Map out
  void clean() {
    productService.clean();
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
