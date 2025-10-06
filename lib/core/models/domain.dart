import 'dart:convert';
import 'package:http/http.dart' as http;

class DomainModel {
  final int domainId;
  final String domainNameArabic;
  final String domainNameEnglish;
  final bool isOffline;
  final bool isSync;
  final int offlineId;
  final DateTime syncDateTime;
  final DateTime modifyDateTime;
  final String domainName;
  final String language;

  const DomainModel({
    required this.domainId,
    required this.domainNameArabic,
    required this.domainNameEnglish,
    required this.isOffline,
    required this.isSync,
    required this.offlineId,
    required this.syncDateTime,
    required this.modifyDateTime,
    required this.domainName,
    required this.language,
  });

  factory DomainModel.fromJson(Map<String, dynamic> json) => DomainModel(
        domainId: json['domainId'] ?? 0,
        domainNameArabic: json['domainNameArabic'] ?? '',
        domainNameEnglish: json['domainNameEnglish'] ?? '',
        isOffline: json['isOffline'] ?? false,
        isSync: json['isSync'] ?? false,
        offlineId: json['offlineId'] ?? 0,
        syncDateTime: DateTime.parse(json['syncDateTime'] ?? DateTime.now().toIso8601String()),
        modifyDateTime: DateTime.parse(json['modifyDateTime'] ?? DateTime.now().toIso8601String()),
        domainName: json['domainName'] ?? '',
        language: json['language'] ?? 'en-US,en;q=0.9',
      );
    
  Map<String, dynamic> toJson() => {
        'domainId': domainId,
        'domainNameArabic': domainNameArabic,
        'domainNameEnglish': domainNameEnglish,
        'isOffline': isOffline,
        'isSync': isSync,
        'offlineId': offlineId,
        'syncDateTime': syncDateTime.toIso8601String(),
        'modifyDateTime': modifyDateTime.toIso8601String(),
        'domainName': domainName,
        'language': language,
      };

  DomainModel copyWith({
    int? domainId,
    String? domainNameArabic,
    String? domainNameEnglish,
    bool? isOffline,
    bool? isSync,
    int? offlineId,
    DateTime? syncDateTime,
    DateTime? modifyDateTime,
    String? domainName,
    String? language,
  }) {
    return DomainModel(
      domainId: domainId ?? this.domainId,
      domainNameArabic: domainNameArabic ?? this.domainNameArabic,
      domainNameEnglish: domainNameEnglish ?? this.domainNameEnglish,
      isOffline: isOffline ?? this.isOffline,
      isSync: isSync ?? this.isSync,
      offlineId: offlineId ?? this.offlineId,
      syncDateTime: syncDateTime ?? this.syncDateTime,
      modifyDateTime: modifyDateTime ?? this.modifyDateTime,
      domainName: domainName ?? this.domainName,
      language: language ?? this.language,
    );
  }
}

class DomainAPIHandler {
  final String baseURL = "https://pcaapi.visioncit.com/";

  Future<List<DomainModel>> getDomains() async {
    List<DomainModel> data = [];

    try {
      final uri = Uri.parse('https://pcaapi.visioncit.com/api/Domain/all');
      final response = await http.get(
        uri, 
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
        },
      );

      print('Domain Response Status: ${response.statusCode}');
      print('Domain Response Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final dynamic jsonData = json.decode(response.body);
        
        if (jsonData is List) {
          data = jsonData.map((json) => DomainModel.fromJson(json)).toList();
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          final List<dynamic> items = jsonData['data'];
          data = items.map((json) => DomainModel.fromJson(json)).toList();
        } else if (jsonData is Map) {
          data = [DomainModel.fromJson(jsonData as Map<String, dynamic>)];
        }

        print('Successfully loaded ${data.length} domains');
      } else {
        print('Domain API Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching domains: $e');
    }

    return data;
  }
}




