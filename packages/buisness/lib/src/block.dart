import 'dart:async';
import 'package:data/data.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:product_model/model.dart';

part 'block.freezed.dart';

@injectable
class ProductBlock {
  final ProductService productService;
  final StreamController<ProductBlockEvent> _eventContrl = StreamController();
  final StreamController<ProductBlockState> _stateContrl =
      StreamController.broadcast();

  Stream<ProductBlockState> get state => _stateContrl.stream;

  ProductBlock({required this.productService}) {
    _eventContrl.stream.listen((event) {
      event.map<void>(init: (_) async {
        _stateContrl.add(const ProductBlockState.loading());
        await productService.createProducts(5);
        _stateContrl.add(
          // ProductBlockState.loaded(prodData: productService.array.values),
          ProductBlockState.loaded(prodData: productService),
        );
      }, setProd: (event) async {
        await productService.createOne();
        return _stateContrl.add(
          // ProductBlockState.loaded(prodData: productService.array.values),
          ProductBlockState.loaded(prodData: productService),
        );
      }, addProd: (event) async {
        await productService.give();
        return _stateContrl
            .add(ProductBlockState.loaded(prodData: productService));
      });
    });
  }

  // void addToCart(item) {
  //   mycart.add(item);
  // }

  void add(ProductBlockEvent event) {
    if (_eventContrl.isClosed) return;
    _eventContrl.add(event);
  }

  void dispose() {
    _eventContrl.close();
    _stateContrl.close();
  }

  void give() {
    productService.give();
  }

  void myCleaner() {
    productService.array.clear();
  }
}

@freezed
class ProductBlockState with _$ProductBlockState {
  const factory ProductBlockState.loading() = ProductLoadingState;
  const factory ProductBlockState.loaded(
      // {required Iterable<ProductData> prodData}) = ProductLoadedState;
      {required ProductService prodData}) = ProductLoadedState;
}

@freezed
class ProductBlockEvent with _$ProductBlockEvent {
  const factory ProductBlockEvent.init() = _ProductInitEvent;
  const factory ProductBlockEvent.setProd() = _ProductSetEvent;
  const factory ProductBlockEvent.addProd() = _ProductAddEvent;
}
