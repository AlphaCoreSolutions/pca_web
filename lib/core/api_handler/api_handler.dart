import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pca_website/core/models/domain_detail.dart';
import '../models/request.dart';

class APIHandler {
  final String baseURL = "https://pcaapi.visioncit.com/api";

  Map<String, String> get headers => {
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json",
  };

  Future<bool> submitRequest(RequestModel request) async {
    try {
      final uri = Uri.parse('$baseURL/Request/add');
      final response = await http.post(
        uri,
        headers: headers,
        body: json.encode(request.toJson()),
      );

      print('Submit Request Status: ${response.statusCode}');
      print('Submit Request Response: ${response.body}');

      return response.statusCode >= 200 && response.statusCode <= 299;
    } catch (e) {
      print('Error submitting request: $e');
      return false;
    }
  }

  Future<List<RequestModel>> getAllRequests() async {
    List<RequestModel> data = [];
    try {
      final uri = Uri.parse('$baseURL/Request/all');
      final response = await http.get(
        uri,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
        },
      );

      print('Request Response Status: ${response.statusCode}');
      print('Request Response Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final dynamic jsonData = json.decode(response.body);

        if (jsonData is List) {
          data = jsonData.map((json) => RequestModel.fromJson(json)).toList();
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          final List<dynamic> items = jsonData['data'];
          data = items.map((json) => RequestModel.fromJson(json)).toList();
        }

        print('Successfully loaded ${data.length} requests');
      } else {
        print(
          'Request API Error: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      print('Error fetching requests: $e');
    }

    return data;
  }

  // Get request by ID
  Future<RequestModel?> getRequestById(int requestId) async {
    try {
      final uri = Uri.parse('$baseURL/Request/$requestId');
      final response = await http.get(
        uri,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
        },
      );

      print('Request by ID Status: ${response.statusCode}');
      print('Request by ID Response: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final dynamic jsonData = json.decode(response.body);
        return RequestModel.fromJson(jsonData as Map<String, dynamic>);
      } else {
        print('Request by ID Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching request by ID: $e');
      return null;
    }
  }

  Future<List<DomainDetailModel>> getDomainDetail(int id) async {
    try {
      final uri = Uri.parse('${baseURL}/Domain/detail/$id');
      final response = await http.get(
        uri,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
        },
      );

      print('Domain Detail Response Status: ${response.statusCode}');
      print('Domain Detail Response Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final dynamic jsonData = json.decode(response.body);

        // Case A: top-level list
        if (jsonData is List) {
          return jsonData
              .map(
                (e) => DomainDetailModel.fromJson(
                  Map<String, dynamic>.from(e as Map),
                ),
              )
              .toList();
        }

        // Case B: wrapped under "data"
        if (jsonData is Map && jsonData.containsKey('data')) {
          final data = jsonData['data'];
          if (data is List) {
            return data
                .map(
                  (e) => DomainDetailModel.fromJson(
                    Map<String, dynamic>.from(e as Map),
                  ),
                )
                .toList();
          } else if (data is Map) {
            return [
              DomainDetailModel.fromJson(Map<String, dynamic>.from(data)),
            ];
          }
          return [];
        }

        // Case C: single object (your current API response)
        if (jsonData is Map) {
          return [
            DomainDetailModel.fromJson(Map<String, dynamic>.from(jsonData)),
          ];
        }

        print(
          'Unexpected JSON format for Domain Details (type: ${jsonData.runtimeType})',
        );
        return [];
      } else {
        print(
          'Domain Detail API Error: ${response.statusCode} - ${response.reasonPhrase}',
        );
        return [];
      }
    } catch (e) {
      print('Error fetching domain details: $e');
      return [];
    }
  }
}
