import 'package:data/data.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

GetIt getIt = GetIt.instance;

// final productBlockProvider = Provider<ProductBlock>((ref) {
//   return ProductBlock(productService: getIt.get<ProductService>());
// });

final productBlockProvider =
    StateNotifierProvider<ProductBlockNotifier, ProductBlock>((ref) {
  return ProductBlockNotifier(ref);
});

// @injectable
class ProductBlockNotifier extends StateNotifier<ProductBlock> {
  ProductBlockNotifier(this.ref)
      : super(ProductBlock(productService: getIt.get<ProductService>())) {}

  final Ref ref;

  Future<void> addProd(item) async {
    await state.addToCart(item);
    state = state;
    // state.productService.myCart = [...state.productService.myCart, item];
  }

  Future<void> createProducts(int i) async {
    // _newState = d
    await state.createProducts(i);
    print('ProductBlockNotifier createProducts');
    state = state;
  }

  void clean() => state.clean();
  giveGoods() => state.goods();
  giveShow() => state.show();
  giveSum() => state.sum();
}

// @injectable
// class ProductBlock extends StateNotifier<ProductBlock> {
//   final ProductService productService = getIt.get<ProductService>();

// ProductBlock() :super()
// @immutable
@injectable
class ProductBlock {
  static int index = 0;
  final ProductService productService;
  ProductBlock({required this.productService});

  createProducts(int i) async {
    await productService.createProducts(5);
  }

  Future<void> addToCart(item) async {
    productService.myCart.add(item);
    await productService.productsStructurer();
    print("addToCart productService.myCart: ${productService.myCart}");
    print(
        "addToCart productService.myCartStructured: ${productService.myCartStructured}");
  }

  void clean() {
    productService.clean();
    print('clean: ${productService.myCartStructured}');
  }

  void create(i) async {
    await productService.createProducts(5);
  }

  goods() {
    return productService.products;
  }

  show() => productService.myCartStructured;

  sum() {
    var _res = 0;
    for (var item in productService.myCartStructured.values) {
      _res += item;
    }
    _res *= 48;
    return _res;
  }
}
