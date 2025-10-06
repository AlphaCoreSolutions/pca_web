class DomainDetailModel {
  final int domainDetailId;
  final String detailNameArabic;
  final String detailNameEnglish;
  final bool isOffline;
  final bool isSync;
  final int offlineId;
  final DateTime syncDateTime;
  final DateTime modifyDateTime;
  final int domainId;
  final dynamic domain;
  final String detailName;
  final String language;

  const DomainDetailModel({
    required this.domainDetailId,
    required this.detailNameArabic,
    required this.detailNameEnglish,
    required this.isOffline,
    required this.isSync,
    required this.offlineId,
    required this.syncDateTime,
    required this.modifyDateTime,
    required this.domainId,
    required this.domain,
    required this.detailName,
    required this.language,
  });

  factory DomainDetailModel.fromJson(Map<String, dynamic> json) =>
      DomainDetailModel(
        domainDetailId: json['domainDetailId'] ?? 0,
        detailNameArabic: json['detailNameArabic'] ?? '',
        detailNameEnglish: json['detailNameEnglish'] ?? '',
        isOffline: json['isOffline'] ?? false,
        isSync: json['isSync'] ?? false,
        offlineId: json['offlineId'] ?? 0,
        syncDateTime: DateTime.parse(
          json['syncDateTime'] ?? DateTime.now().toIso8601String(),
        ),
        modifyDateTime: DateTime.parse(
          json['modifyDateTime'] ?? DateTime.now().toIso8601String(),
        ),
        domainId: json['domainId'] ?? 0,
        domain: json['domain'],
        detailName: json['detailName'] ?? '',
        language: json['language'] ?? 'en-US,en;q=0.9',
      );

  Map<String, dynamic> toJson() => {
    'domainDetailId': domainDetailId,
    'detailNameArabic': detailNameArabic,
    'detailNameEnglish': detailNameEnglish,
    'isOffline': isOffline,
    'isSync': isSync,
    'offlineId': offlineId,
    'syncDateTime': syncDateTime.toIso8601String(),
    'modifyDateTime': modifyDateTime.toIso8601String(),
    'domainId': domainId,
    'domain': domain,
    'detailName': detailName,
    'language': language,
  };
}
