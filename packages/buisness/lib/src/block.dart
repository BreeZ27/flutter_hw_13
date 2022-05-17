import 'dart:async';
import 'package:data/data.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:product_model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

GetIt getIt = GetIt.instance;

enum ProductBlockEvent { clear, add, toCart, add_0, add_1, add_2, add_3, add_4 }
// abstract class ProductBlockEvent{}
// class

// class MyBLoc extends Bloc<ProductBlockEvent, Map<ProductData, int>> {
// @injectable
class MyBLoc extends Bloc<ProductBlockEvent, ProductBlock> {
  // final ProductBlock productBlock = ProductBlock();
  // late final ProductBlock productBlock;

  int init = 0;
  MyBLoc() : super(ProductBlock()) {
    if (init == 0) {
      state.createPrd(5);
      // productBlock.createPrd(5);
      // emit(state);
      init++;
    }
    on((ProductBlockEvent event, emit) {
      switch (event) {
        case ProductBlockEvent.add:
          state.createPrd(5);
          return emit(state);

        case ProductBlockEvent.clear:
          state.cleaning();
          return emit(state);

        case ProductBlockEvent.add_0:
          state.addToCart(state.goods().keys[0]);
          return emit(state);

        case (ProductBlockEvent.toCart):
          print('ProductBlockEvent.toCart');
          // state.addToCart(ProductData);
          return emit(state);

        default:
          print('emit: default');
      }
      // if (event == ProductBlockEvent.add) {
      //   state.createPrd(5);
      //   emit(state);
      // }
    });
  }

  // Stream<ProductBlock> toCart(ProductBlockEvent event, ProductData e) async* {
  //   print('Stream toCart');
  //   if (event == ProductBlockEvent.toCart) {
  //     productBlock.addToCart(e);
  //     productBlock.give();
  //   }
  //   yield productBlock;
  // }

  // @override
  // Stream<ProductBlock> mapEventToState(ProductBlockEvent event) async* {
  //   switch (event) {
  //     case ProductBlockEvent.add:
  //       productBlock.createPrd(5);
  //       print('Stream: ProductBlockEvent.add');
  //       yield productBlock;
  //       break;
  //     case ProductBlockEvent.clear:
  //       productBlock.cleaning();
  //       print('Stream: ProductBlockEvent.clear');
  //       yield productBlock;
  //       break;
  //     case ProductBlockEvent.add_0:
  //       productBlock.addToCart(productBlock.goods().keys[0]);
  //       yield productBlock;
  //       break;
  //     default:
  //       print('Stream: default');
  //   }
  // }

  // void _handleEvent(ProductBlockEvent action) async {
  //   switch (action) {
  //     case ProductBlockEvent.clear:
  //       productBlock.cleaning();
  //       print('_handleEvent clear');
  //       break;
  //     case ProductBlockEvent.add:
  //       productBlock.createPrd(5);
  //       print('_handleEvent add');
  //       break;
  //     default:
  //       // productBlock.createPrd(5);
  //       print('_handleEvent default');
  //       break;
  //   }
  //   await Future.delayed(const Duration(seconds: 2));
  // _stateContrl2.add(productBlock.goods());
  // _stateContrl1.add(productBlock.show());
  // }

  // void _addProduct(ProductData item) async {
  //   print('MyBLoc._addProduct($item)');
  //   productBlock.addToCart(item);
  //   await productBlock.give();
  // _stateContrl1.add(productBlock.show());
  // }
}

@injectable
class ProductBlock {
  final ProductService productService = getIt.get<ProductService>();

  ProductBlock() {
    print('ProductBlock created ${productService.hashCode}');
  }

  void addToCart(item) {
    productService.myCart.add(item);
    print('ProductBlock.addToCart(): ${productService.myCart}');
  }

  void createPrd(int value) {
    productService.createProducts(value);
  }

  void cleaning() {
    productService.cleane();
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
