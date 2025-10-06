class RequestModel {
  final int requestId;
  final int organizationId;
  final String customerName;
  final String customerEmail;
  final String requestSubject;
  final String requestBody;
  final int serviceId;
  final int customerMobile;
  final DateTime createDateTime;
  final DateTime modifyDateTime;
  final bool isResposed;

  const RequestModel ({
    required this.requestId,
    required this.organizationId,
    required this.customerName,
    required this.customerEmail,
    required this.requestSubject,
    required this.requestBody,
    required this.serviceId,
    required this.customerMobile,
    required this.createDateTime,
    required this.modifyDateTime,
    required this.isResposed,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        requestId: json['requestId'] ?? 0,
        organizationId: json['organizationId'] ?? 1,
        customerName: json['customerName'] ?? '',
        customerEmail: json['customerEmail'] ?? '',
        requestSubject: json['requestSubject'] ?? '',
        requestBody: json['requestBody'] ?? '',
        customerMobile: json['customerMobile'] ?? 0,
        serviceId: json['serviceId'] ?? 0,
        createDateTime: DateTime.parse(json['createDateTime'] ?? DateTime.now().toIso8601String()),
        modifyDateTime: DateTime.parse(json['modifyDateTime'] ?? DateTime.now().toIso8601String()),
        isResposed: json['isResposed'] ?? false,
      );
    
  Map<String, dynamic> toJson() => {
        'requestId': requestId,
        'organizationId': organizationId,
        'customerName': customerName,
        'customerEmail': customerEmail,
        'requestSubject': requestSubject,
        'requestBody': requestBody,
        'customerMobile': customerMobile,
        'serviceId': serviceId,
        'createDateTime': createDateTime.toIso8601String(),
        'modifyDateTime': modifyDateTime.toIso8601String(),
        'isResposed': isResposed,
      };
}

