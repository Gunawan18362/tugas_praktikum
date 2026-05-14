import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/constants/api_constants.dart';
import '../models/product_model.dart';

class ProductService {

  // GET PRODUCTS
  Future<List<ProductModel>> getProducts(
    String token,
  ) async {

    try {

      final url = Uri.parse(
        '${ApiConstants.baseUrl}/api/products',
      );

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('GET PRODUCTS SUCCESS');
      print(response.body);

      if (response.statusCode == 200) {

        final data =
            jsonDecode(response.body);

        final List products =
            data['data']['products'];

        return products
            .map(
              (e) => ProductModel.fromJson(e),
            )
            .toList();
      }

      return [];

    } catch (e) {

      print('GET PRODUCTS ERROR');
      print(e);

      return [];
    }
  }

  // ADD PRODUCT
  Future<bool> addProduct(
    String token,
    String name,
    int price,
    String description,
  ) async {

    try {

      final url = Uri.parse(
        '${ApiConstants.baseUrl}/api/products',
      );

      final body = {
        'name': name,
        'price': price,
        'description': description,
      };

      print('TOKEN: $token');
      print('BODY: $body');

      final response = await http.post(
        url,

        headers: {
          'Content-Type':
              'application/json',
          'Accept':
              'application/json',
          'Authorization':
              'Bearer $token',
        },

        body: jsonEncode(body),
      );

      print(
        'STATUS CODE: ${response.statusCode}',
      );

      print(
        'RESPONSE: ${response.body}',
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        print(
          'PRODUCT BERHASIL DITAMBAHKAN',
        );

        return true;

      } else {

        print(
          'GAGAL MENAMBAHKAN PRODUCT',
        );

        return false;
      }

    } catch (e) {

      print('ERROR ADD PRODUCT');
      print(e);

      return false;
    }
  }

  // DELETE PRODUCT
  Future<bool> deleteProduct(
    String token,
    int productId,
  ) async {

    try {

      final url = Uri.parse(
        '${ApiConstants.baseUrl}/api/products/$productId',
      );

      final response = await http.delete(
        url,
        headers: {
          'Accept':
              'application/json',
          'Authorization':
              'Bearer $token',
        },
      );

      print(
        'DELETE RESPONSE: ${response.body}',
      );

      return response.statusCode == 200 ||
          response.statusCode == 201;

    } catch (e) {

      print('DELETE ERROR');
      print(e);

      return false;
    }
  }

  // SUBMIT TUGAS
  Future<bool> submitTugas(
    String token,
    String name,
    String githubUrl,
  ) async {

    try {

      final url = Uri.parse(
        '${ApiConstants.baseUrl}/api/products/submit',
      );

      final response = await http.post(
        url,

        headers: {
          'Content-Type':
              'application/json',
          'Accept':
              'application/json',
          'Authorization':
              'Bearer $token',
        },

        body: jsonEncode({
          'name': name,
          'description':
              'Dikirim dari aplikasi Flutter',
          'github_url':
              githubUrl,
        }),
      );

      print(
        'SUBMIT RESPONSE: ${response.body}',
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        print(
          'TUGAS BERHASIL DIKIRIM',
        );

        return true;

      } else {

        print(
          'GAGAL MENGIRIM TUGAS',
        );

        return false;
      }

    } catch (e) {

      print('SUBMIT ERROR');
      print(e);

      return false;
    }
  }
}