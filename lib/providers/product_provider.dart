import 'package:flutter/material.dart';

import '../core/storage/secure_storage.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductProvider
    extends ChangeNotifier {

  final ProductService _service =
      ProductService();

  List<ProductModel> products = [];

  bool isLoading = false;

  // FETCH PRODUCTS
  Future<void> fetchProducts() async {

    isLoading = true;
    notifyListeners();

    final token =
        await SecureStorage.getToken();
    print('TOKEN: $token');

    if (token != null) {

      products =
          await _service.getProducts(
        token,
      );
    }

    isLoading = false;
    notifyListeners();
  }

  // ADD PRODUCT
  Future<bool> addProduct(
    String name,
    int price,
    String description,
  ) async {

    final token =
        await SecureStorage.getToken();

    if (token == null) return false;

    final success =
        await _service.addProduct(
      token,
      name,
      price,
      description,
    );

    if (success) {
      await fetchProducts();
    }

    return success;
  }

  // DELETE PRODUCT
  Future<bool> deleteProduct(
    int productId,
  ) async {

    final token =
        await SecureStorage.getToken();

    if (token == null) return false;

    final success =
        await _service.deleteProduct(
      token,
      productId,
    );

    if (success) {
      await fetchProducts();
    }

    return success;
  }

  // SUBMIT TUGAS
  Future<bool> submitTugas(
    String name,
    String githubUrl,
  ) async {

    final token =
        await SecureStorage.getToken();

    if (token == null) return false;

    return await _service.submitTugas(
      token,
      name,
      githubUrl,
    );
  }
}