import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/subcategory_model.dart';

class CategoryModel6Repo {
  String baseUrl = "https://kwik-backend.vercel.app";

  final headers = {
    'Content-Type': 'application/json',
    'api_Key': 'arjun',
    'api_Secret': 'digi9',
  };

  /// Fetch all subcategories (GET request)
  Future<List<SubCategoryModel>> fetchAllSubCategories() async {
    final url = Uri.parse('$baseUrl/subcategory/allsubcategories');

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> subCategoryData = json.decode(response.body);

        return subCategoryData
            .map(
                (subcategoryJson) => SubCategoryModel.fromJson(subcategoryJson))
            .toList();
      } else {
        throw Exception('Failed to load all subcategories');
      }
    } catch (e) {
      throw Exception('Error fetching all subcategories: $e');
    }
  }
}
