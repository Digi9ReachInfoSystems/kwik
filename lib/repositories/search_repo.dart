import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kwik/models/product_model.dart';

class SearchRepo {
  final String baseUrl = "https://kwik-backend.vercel.app";

  final headers = {
    'api_Key': "arjun",
    'api_Secret': "digi9",
  };
  Future<Map<String, dynamic>> searchProducts(
      String query, String userId) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/product/search/product/user/$userId?query=$query"),
        headers: headers,
      );

      print("Search API Response:");
      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body) as Map<String, dynamic>;

        if (!decodedData.containsKey('data')) {
          throw Exception("Key 'data' not found in response");
        }

        final data = decodedData['data'] as List;
        final searchHistory = decodedData['searchHistory'] ?? [];

        return {
          "products": data,
          "searchHistory": searchHistory,
        };
      } else {
        throw Exception(
            "Failed to load search results: ${response.statusCode}");
      }
    } catch (e) {
      print("Error in searchProducts: $e");
      throw Exception("Search failed: $e");
    }
  }

  Future<Map<String, dynamic>> getInitialProducts() async {
    final response = await http.get(
      Uri.parse(
          "$baseUrl/product/get/recommendedProductsByUserOrder/s5ZdLnYhnVfAramtr7knGduOI872"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      // Ensure 'allProducts' key exists before parsing
      if (decodedData.containsKey('allProducts')) {
        List<dynamic> data = decodedData['allProducts'];

        List<dynamic> searchHistory = decodedData['searchHistory'];

        return {
          "products": data.map((json) => ProductModel.fromJson(json)).toList(),
          "searchHistory": searchHistory.map((e) => e["query"]).toList()
        };
      } else {
        throw Exception("Key 'allProducts' not found in response");
      }
    } else {
      throw Exception("Failed to load initial products");
    }
  }
}
