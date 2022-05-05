import 'dart:async';
import 'package:data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:product_model/model.dart';
import 'package:get_it/get_it.dart';

@injectable
class ProductBlock extends ChangeNotifier {
  final ProductService productService = MyProductService();

  ProductBlock() {
    productService.createProducts(5);
  }

  void addToCart(item) async {
    productService.myCart.add(item);
    await productService.give();
    notifyListeners();
  }

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
