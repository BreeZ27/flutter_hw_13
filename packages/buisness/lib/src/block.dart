import 'dart:async';
import 'package:data/data.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:product_model/model.dart';

GetIt getIt = GetIt.instance;

enum ProductBlockEvent { clear, add }

@injectable
class ProductBlock {
  final ProductService productService = getIt.get<ProductService>();
  final _stateContrl = StreamController<ProductBlock>();
  final _eventContrl = StreamController<ProductBlockEvent>();

  Stream<ProductBlock> get state => _stateContrl.stream;
  Sink<ProductBlockEvent> get action => _eventContrl.sink;

  ProductBlock() {
    // productService = ;
    _eventContrl.stream.listen((_handleEvent));
  }

  void _handleEvent(ProductBlockEvent action) async {
    if (action == ProductBlockEvent.clear) {
      productService.cleane();
    }
    // _stateContrl.add(event)
  }

  void addToCart(item) {
    productService.myCart.add(item);
  }

  // void add(ProductBlockEvent event) {
  //   if (_eventContrl.isClosed) return;
  //   _eventContrl.add(event);
  // }

  void dispose() {
    _eventContrl.close();
    _stateContrl.close();
  }

  void give() {
    productService.give();
  }

  goods() {
    return productService.array.values;
  }

  show() {
    return productService.out;
  }
}
