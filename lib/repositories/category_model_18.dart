import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/subcategory_model.dart';

class Categorymodel18Repository {
  String baseUrl = "https://kwik-backend.vercel.app";

  final headers = {
    'Content-Type':
        'application/json', // Add this to specify the content type as JSON
    'api_Key': 'arjun',
    'api_Secret': 'digi9',
  };

  /// Fetch all subcategories of a given category ID (GET request)
  Future<List<SubCategoryModel>> fetchSubCategories(String categoryId) async {
    final url = Uri.parse('$baseUrl/subcategory/allsubcategories');

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> subCategoryData = json.decode(response.body);

        // Map the list of subcategories to SubCategoryModel objects
        return subCategoryData
            .map(
                (subcategoryJson) => SubCategoryModel.fromJson(subcategoryJson))
            .toList();
      } else {
        throw Exception('Failed to load subcategories');
      }
    } catch (e) {
      throw Exception('Error fetching subcategories: $e');
    }
  }
}
