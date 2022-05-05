import 'dart:async';
import 'package:data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:product_model/model.dart';
import 'package:get_it/get_it.dart';

// part 'block.freezed.dart';

@injectable
class ProductBlock extends ChangeNotifier {
  final ProductService productService = MyProductService();

  ProductBlock() {
    productService.createProducts(5);
  }
  // final StreamController<ProductBlockEvent> _eventContrl = StreamController();
  // final StreamController<ProductBlockState> _stateContrl =
  //     StreamController.broadcast();

  // Stream<ProductBlockState> get state => _stateContrl.stream;

  // ProductBlock({required this.productService}) {
  //   _eventContrl.stream.listen((event) {
  //     event.map<void>(init: (_) async {
  //       _stateContrl.add(const ProductBlockState.loading());
  //       await productService.createProducts(5);
  //       _stateContrl.add(
  //         ProductBlockState.loaded(prodData: productService),
  //       );
  //     }, setProd: (event) async {
  //       await productService.createOne();
  //       return _stateContrl.add(
  //         ProductBlockState.loaded(prodData: productService),
  //       );
  //     }, addProd: (event) async {
  //       await productService.give();
  //       return _stateContrl
  //           .add(ProductBlockState.loaded(prodData: productService));
  //     }, cleanProd: (event) {
  //       productService.cleane();
  //       return _stateContrl
  //           .add(ProductBlockState.loaded(prodData: productService));
  //     });
  //   });
  // }

  void addToCart(item) async {
    productService.myCart.add(item);
    await productService.give();
    notifyListeners();
  }

  // void add(ProductBlockEvent event) {
  //   if (_eventContrl.isClosed) return;
  //   _eventContrl.add(event);
  // }

  // void dispose() {
  //   _eventContrl.close();
  //   _stateContrl.close();
  // }

  // void give() {
  //   productService.give();
  // }

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
}

// @freezed
// class ProductBlockState with _$ProductBlockState {
//   const factory ProductBlockState.loading() = ProductLoadingState;
//   const factory ProductBlockState.loaded(
//       // {required Iterable<ProductData> prodData}) = ProductLoadedState;
//       {required ProductService prodData}) = ProductLoadedState;
// }

// @freezed
// class ProductBlockEvent with _$ProductBlockEvent {
//   const factory ProductBlockEvent.init() = _ProductInitEvent;
//   const factory ProductBlockEvent.setProd() = _ProductSetEvent;
//   const factory ProductBlockEvent.addProd() = _ProductAddEvent;
//   const factory ProductBlockEvent.cleanProd() = _ProductCleanEvent;
// }
