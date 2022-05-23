import 'dart:async';
import 'package:data/data.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:product_model/model.dart';

GetIt getIt = GetIt.instance;

enum ProductBlockEvent { clear, add, toCart }

class MyCubit {
  final ProductBlock productBlock = ProductBlock();

  final _stateContrl1 = StreamController<Map<ProductData, int>>();
  final _stateContrl2 = StreamController<Map<ProductData, int>>();
  final _sumContrl = StreamController<int>();

  Stream<Map<ProductData, int>> get cartState => _stateContrl1.stream;
  Stream<Map<ProductData, int>> get goodsState => _stateContrl2.stream;
  Stream<int> get sumState => _sumContrl.stream;

  void handleEvent(ProductBlockEvent action) async {
    switch (action) {
      case ProductBlockEvent.clear:
        productBlock.cleaning();
        print('_handleEvent clear');
        break;
      case ProductBlockEvent.add:
        productBlock.createPrd(5);
        print('_handleEvent add');
        break;
      default:
        // productBlock.createPrd(5);
        print('_handleEvent default');
        break;
    }
    await Future.delayed(const Duration(seconds: 2));
    _stateContrl2.add(productBlock.goods());
    _stateContrl1.add(productBlock.show());
    _sumContrl.add(productBlock.sum());
  }

  void addProduct(ProductData item) async {
    print('MyBLoc._addProduct($item)');
    productBlock.addToCart(item);
    await productBlock.productsStructurer();
    _stateContrl1.add(productBlock.show());
    _sumContrl.add(productBlock.sum());
  }

  void dispose() {
    _stateContrl1.close();
    _stateContrl2.close();
  }
}

@injectable
class ProductBlock {
  final ProductService productService = getIt.get<ProductService>();

  ProductBlock() {}

  void addToCart(item) {
    productService.myCart.add(item);
    print('addToCart: ${productService.myCart}');
  }

  void createPrd(int value) {
    productService.createProducts(value);
  }

  void cleaning() {
    productService.myCart.clear();
    productService.myCartStructured.clear();
  }

  productsStructurer() async {
    await productService.productsStructurer();
    print('ProductBlock.give(): ${productService.myCartStructured}');
  }

  goods() {
    print('ProductBlock.goods(): ${productService.products}');
    return productService.products;
  }

  show() {
    print('ProductBlock.show(): ${productService.myCartStructured}');
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
