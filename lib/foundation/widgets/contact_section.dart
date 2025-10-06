import 'package:flutter/material.dart';
import 'package:pca_website/core/api_handler/api_handler.dart';
import 'package:pca_website/core/models/request.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController =
      TextEditingController(); // NEW
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isLoading = false;

  // Use a valid Domain Detail (service) id that exists in your DB.
  static const int _contactServiceId = 1; // adjust if needed
  static const int _defaultOrganizationId = 1;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose(); // NEW
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // -------- helpers ----------
  String _digitsOnly(String input) => input.replaceAll(RegExp(r'[^0-9]'), '');
  int _parseMobileToInt(String mobile) {
    final cleaned = _digitsOnly(mobile);
    return int.tryParse(cleaned) ?? 0;
  }

  // -------- validators ----------
  String? _validateEmail(String? value) {
    final isArabic = Provider.of<LanguageProvider>(
      context,
      listen: false,
    ).isArabic;
    if (value == null || value.trim().isEmpty) {
      return isArabic ? 'البريد الإلكتروني مطلوب' : 'Email is required';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return isArabic ? 'البريد الإلكتروني غير صالح' : 'Invalid email address';
    }
    return null;
  }

  String? _validateRequired(String? value, String fieldName) {
    final lang = Provider.of<LanguageProvider>(context, listen: false);
    final empty = value == null || value.trim().isEmpty;
    if (!empty) return null;

    if (lang.isArabic) {
      switch (fieldName) {
        case 'name':
          return 'الاسم مطلوب';
        case 'subject':
          return 'الموضوع مطلوب';
        case 'message':
          return 'الرسالة مطلوبة';
        default:
          return 'هذا الحقل مطلوب';
      }
    } else {
      switch (fieldName) {
        case 'name':
          return 'Name is required';
        case 'subject':
          return 'Subject is required';
        case 'message':
          return 'Message is required';
        default:
          return 'This field is required';
      }
    }
  }

  String? _validateMobile(String? value) {
    // NEW
    final isArabic = Provider.of<LanguageProvider>(
      context,
      listen: false,
    ).isArabic;
    if (value == null || value.trim().isEmpty) {
      return isArabic ? 'رقم الجوال مطلوب' : 'Mobile number is required';
    }
    final digits = _digitsOnly(value);
    if (digits.length < 8) {
      return isArabic ? 'رقم الجوال غير صالح' : 'Invalid mobile number';
    }
    return null;
  }

  // -------- submit ----------
  Future<void> _submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final languageProvider = Provider.of<LanguageProvider>(
        context,
        listen: false,
      );

      final request = RequestModel(
        requestId: 0,
        organizationId: _defaultOrganizationId,
        customerName: _nameController.text.trim(),
        customerEmail: _emailController.text.trim(),
        requestSubject: _subjectController.text.trim(),
        requestBody: _messageController.text.trim(),
        customerMobile: _parseMobileToInt(_mobileController.text), // NEW
        serviceId: _contactServiceId,
        createDateTime: DateTime.now(),
        modifyDateTime: DateTime.now(),
        isResposed: false,
      );

      // Debug
      // ignore: avoid_print
      print('Contact submit payload: ${request.toJson()}');

      final api = APIHandler();
      final ok = await api.submitRequest(request);

      if (!mounted) return;

      if (ok) {
        _showSnackBar(
          context,
          languageProvider.isArabic
              ? 'تم إرسال الرسالة بنجاح'
              : 'Message sent successfully',
          Colors.green,
        );
        _nameController.clear();
        _emailController.clear();
        _mobileController.clear(); // NEW
        _subjectController.clear();
        _messageController.clear();
      } else {
        _showSnackBar(
          context,
          languageProvider.isArabic
              ? 'فشل في إرسال الرسالة. حاول مرة أخرى.'
              : 'Failed to send message. Please try again.',
          Colors.red,
        );
      }
    } on Exception catch (e) {
      // ignore: avoid_print
      print('Contact submit exception: $e');
      final isArabic = Provider.of<LanguageProvider>(
        context,
        listen: false,
      ).isArabic;
      final hint = isArabic
          ? 'تعذر الاتصال بالخادم. تحقق من CORS/SSL أو الشبكة.'
          : 'Could not reach the server. Check CORS/SSL or network.';
      _showSnackBar(context, '$e\n$hint', Colors.red);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // -------- UI helpers ----------
  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
        content: Text(message, style: const TextStyle(fontFamily: 'Cairo')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final contactInfo = languageProvider.contactInfo;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: Colors.grey[900],
      child: Column(
        children: [
          Text(
            languageProvider.contact,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF0B81B),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            languageProvider.isArabic
                ? 'تواصل مع شركة قوة البنية العربية للمقاولات'
                : 'Contact Power Construction Arabia Contracting Company',
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 40),

          Row(
            children: [
              // Contact Info
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: languageProvider.isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    _buildContactInfo(
                      Icons.business,
                      languageProvider.companyName,
                      languageProvider.isArabic,
                    ),
                    _buildContactInfo(
                      Icons.assignment_ind,
                      languageProvider.companyCR,
                      languageProvider.isArabic,
                    ),
                    _buildContactInfo(
                      Icons.location_on,
                      contactInfo['address']!,
                      languageProvider.isArabic,
                    ),
                    _buildContactInfo(
                      Icons.phone,
                      contactInfo['phone']!,
                      languageProvider.isArabic,
                    ),
                    _buildContactInfo(
                      Icons.email,
                      contactInfo['email']!,
                      languageProvider.isArabic,
                    ),
                    _buildContactInfo(
                      Icons.access_time,
                      contactInfo['working_hours']!,
                      languageProvider.isArabic,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 60),

              // Contact Form
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          languageProvider.isArabic
                              ? 'ارسل رسالة'
                              : 'Send Message',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Name
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: languageProvider.isArabic
                                ? 'الاسم الكامل'
                                : 'Full Name',
                            labelStyle: const TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.grey[700],
                          ),
                          validator: (value) =>
                              _validateRequired(value, 'name'),
                        ),
                        const SizedBox(height: 20),

                        // Email
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: languageProvider.isArabic
                                ? 'البريد الإلكتروني'
                                : 'Email',
                            labelStyle: const TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.grey[700],
                          ),
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),

                        // Mobile (NEW)
                        TextFormField(
                          controller: _mobileController,
                          decoration: InputDecoration(
                            labelText: languageProvider.isArabic
                                ? 'رقم الجوال'
                                : 'Mobile Number',
                            hintText: languageProvider.isArabic
                                ? 'مثال: 0555555555'
                                : 'e.g. 0555555555',
                            labelStyle: const TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.grey[700],
                          ),
                          keyboardType: TextInputType.phone,
                          validator: _validateMobile,
                        ),
                        const SizedBox(height: 20),

                        // Subject
                        TextFormField(
                          controller: _subjectController,
                          decoration: InputDecoration(
                            labelText: languageProvider.isArabic
                                ? 'الموضوع'
                                : 'Subject',
                            labelStyle: const TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.grey[700],
                          ),
                          validator: (value) =>
                              _validateRequired(value, 'subject'),
                        ),
                        const SizedBox(height: 20),

                        // Message
                        TextFormField(
                          controller: _messageController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: languageProvider.isArabic
                                ? 'الرسالة'
                                : 'Message',
                            labelStyle: const TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.grey[700],
                          ),
                          validator: (value) =>
                              _validateRequired(value, 'message'),
                        ),
                        const SizedBox(height: 30),

                        // Submit
                        ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () => _submitForm(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF0B81B),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            disabledBackgroundColor: Colors.grey[600],
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
                                  languageProvider.isArabic
                                      ? 'إرسال الرسالة'
                                      : 'Send Message',
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text, bool isArabic) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isArabic
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isArabic) Icon(icon, color: const Color(0xFFF0B81B), size: 24),
          if (!isArabic) const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
            ),
          ),
          if (isArabic) const SizedBox(width: 15),
          if (isArabic) Icon(icon, color: const Color(0xFFF0B81B), size: 24),
        ],
      ),
    );
  }
}
