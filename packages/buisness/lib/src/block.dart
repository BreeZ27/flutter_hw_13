import 'dart:async';
import 'package:data/data.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:product_model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

GetIt getIt = GetIt.instance;

enum ProductBlockEvent { clear, add, toCart }

class MyBLoc extends Bloc<ProductBlockEvent, ProductBlock> {
  static int init = 0;

  duplicate(ProductBlock inlet) {
    ProductBlock _outlet = ProductBlock();
    _outlet.productService.out = inlet.productService.out;
    _outlet.productService.array = inlet.productService.array;
    _outlet.productService.myCart = inlet.productService.myCart;
    return _outlet;
  }

  MyBLoc() : super(ProductBlock()) {
    on(
      (ProductBlockEvent event, emit) async {
        switch (event) {
          case ProductBlockEvent.add:
            print('ProductBlockEvent.add');
            if (init == 0) {
              state.createPrd(5);
              init++;
              return emit(duplicate(state));
            } else {
              return emit(state);
            }

          case ProductBlockEvent.clear:
            state.cleaning();
            return emit(duplicate(state));

          case (ProductBlockEvent.toCart):
            print('ProductBlockEvent.toCart');
            return emit(duplicate(state));

          default:
            state.createPrd(5);
            return emit(duplicate(state));
        }
      },
    );
  }
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
