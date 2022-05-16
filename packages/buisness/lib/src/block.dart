import 'dart:async';
import 'package:data/data.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:product_model/model.dart';

GetIt getIt = GetIt.instance;

enum ProductBlockEvent { clear, add, toCart }

class MyBLoc {
  final ProductBlock productBlock = ProductBlock();

  final _stateContrl = StreamController<ProductBlock>();
  final _eventContrl = StreamController<ProductBlockEvent>();

  final _cartContrl = StreamController<ProductData>();

  final _stateContrl1 = StreamController<Map<ProductData, int>>();
  final _stateContrl2 = StreamController<Map<ProductData, int>>();

  Stream<ProductBlock> get state => _stateContrl.stream;

  Stream<Map<ProductData, int>> get cartState => _stateContrl1.stream;
  Stream<Map<ProductData, int>> get goodsState => _stateContrl2.stream;

  Sink<ProductBlockEvent> get action => _eventContrl.sink;
  Sink<ProductData> get addAction => _cartContrl.sink;

  MyBLoc() {
    _eventContrl.stream.listen(_handleEvent);
    _cartContrl.stream.listen((item) {
      _addProduct(item);
    });
    // _handleEvent(ProductBlockEvent.add);
  }

  void _handleEvent(ProductBlockEvent action) async {
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
  }

  void _addProduct(ProductData item) async {
    print('MyBLoc._addProduct($item)');
    productBlock.addToCart(item);
    await productBlock.give();
    _stateContrl1.add(productBlock.show());
  }

  void dispose() {
    _eventContrl.close();
    _stateContrl.close();
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
    productService.out.clear();
  }

  give() async {
    await productService.give();
    print('ProductBlock.give(): ${productService.out}');
  }

  goods() {
    print('ProductBlock.goods(): ${productService.array}');
    return productService.array;
  }

  show() {
    print('ProductBlock.show(): ${productService.out}');
    return productService.out;
  }
}
