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
      event.map<void>(
        init: (_) async {
          _stateContrl.add(const ProductBlockState.loading());
          _stateContrl.add(
            ProductBlockState.loaded(
              prodData: await productService.createOne(),
            ),
          );
        },
        getProd: (event) async => _stateContrl.add(
          ProductBlockState.loaded(
            prodData: productService.getProductById(event.prodId),
          ),
        ),
        setProd: (event) async => _stateContrl.add(
          ProductBlockState.loaded(
            prodData: await productService.createOne(),
          ),
        ),
      );
    });
  }

  void add(ProductBlockEvent event) {
    if (_eventContrl.isClosed) return;
    _eventContrl.add(event);
  }

  void dispose() {
    _eventContrl.close();
    _stateContrl.close();
  }

  void show() {
    productService.productsShow();
  }

  void myCleaner() {
    productService.array.clear();
  }
}

@freezed
class ProductBlockState with _$ProductBlockState {
  const factory ProductBlockState.loading() = ProductLoadingState;
  const factory ProductBlockState.loaded({required ProductData prodData}) =
      ProductLoadedState;
}

@freezed
class ProductBlockEvent with _$ProductBlockEvent {
  const factory ProductBlockEvent.init() = _ProductInitEvent;
  const factory ProductBlockEvent.getProd({required int prodId}) =
      _ProductGetEvent;
  const factory ProductBlockEvent.setProd() = _ProductSetEvent;
}



// @freezed
// class ProductBlockState with _$ProductBlockState {
//   const factory ProductBlockState.loading(
//       {required Map<int, ProductData> productsCreator}) = ProductLoadingState;
//   const factory ProductBlockState.loaded() = ProductLoadedState;
// }

// @freezed
// class ProductBlockEvent with _$ProductBlockEvent {
//   const factory ProductBlockEvent.init() = _ProductInitEvent;
//   const factory ProductBlockEvent.setUser({required int prodId}) =
//       _ProductSetEvent;
// }
