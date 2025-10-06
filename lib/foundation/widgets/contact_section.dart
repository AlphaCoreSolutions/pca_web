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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 600;
    final isMediumScreen = screenWidth <= 1024;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen
            ? 40
            : isMediumScreen
            ? 60
            : 80,
        horizontal: isSmallScreen
            ? 20
            : isMediumScreen
            ? 30
            : 40,
      ),
      color: Colors.grey[900],
      child: Column(
        children: [
          Text(
            languageProvider.contact,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: isSmallScreen
                  ? 28
                  : isMediumScreen
                  ? 32
                  : 36,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFF0B81B),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isSmallScreen ? 8 : 10),
          Text(
            languageProvider.isArabic
                ? 'تواصل مع شركة قوة البنية العربية للمقاولات'
                : 'Contact Power Construction Arabia Contracting Company',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: isSmallScreen ? 16 : 18,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: isSmallScreen
                ? 20
                : isMediumScreen
                ? 30
                : 40,
          ),

          isSmallScreen
              ? Column(
                  children: [
                    // Contact Info Section
                    Column(
                      crossAxisAlignment: languageProvider.isArabic
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        _buildContactInfo(
                          Icons.business,
                          languageProvider.companyName,
                          languageProvider.isArabic,
                          isSmallScreen,
                        ),
                        _buildContactInfo(
                          Icons.assignment_ind,
                          languageProvider.companyCR,
                          languageProvider.isArabic,
                          isSmallScreen,
                        ),
                        _buildContactInfo(
                          Icons.location_on,
                          contactInfo['address']!,
                          languageProvider.isArabic,
                          isSmallScreen,
                        ),
                        _buildContactInfo(
                          Icons.phone,
                          contactInfo['phone']!,
                          languageProvider.isArabic,
                          isSmallScreen,
                        ),
                        _buildContactInfo(
                          Icons.email,
                          contactInfo['email']!,
                          languageProvider.isArabic,
                          isSmallScreen,
                        ),
                        _buildContactInfo(
                          Icons.access_time,
                          contactInfo['working_hours']!,
                          languageProvider.isArabic,
                          isSmallScreen,
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Contact Form Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(isSmallScreen ? 20 : 30),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: _buildForm(languageProvider, isSmallScreen),
                    ),
                  ],
                )
              : Row(
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
                            isSmallScreen,
                          ),
                          _buildContactInfo(
                            Icons.assignment_ind,
                            languageProvider.companyCR,
                            languageProvider.isArabic,
                            isSmallScreen,
                          ),
                          _buildContactInfo(
                            Icons.location_on,
                            contactInfo['address']!,
                            languageProvider.isArabic,
                            isSmallScreen,
                          ),
                          _buildContactInfo(
                            Icons.phone,
                            contactInfo['phone']!,
                            languageProvider.isArabic,
                            isSmallScreen,
                          ),
                          _buildContactInfo(
                            Icons.email,
                            contactInfo['email']!,
                            languageProvider.isArabic,
                            isSmallScreen,
                          ),
                          _buildContactInfo(
                            Icons.access_time,
                            contactInfo['working_hours']!,
                            languageProvider.isArabic,
                            isSmallScreen,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: isMediumScreen ? 40 : 60),

                    // Contact Form
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(isMediumScreen ? 25 : 30),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: _buildForm(languageProvider, isSmallScreen),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildForm(LanguageProvider languageProvider, bool isSmallScreen) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            languageProvider.isArabic ? 'ارسل رسالة' : 'Send Message',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: isSmallScreen ? 20 : 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: isSmallScreen ? 20 : 30),

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
            validator: (value) => _validateRequired(value, 'name'),
          ),
          SizedBox(height: isSmallScreen ? 15 : 20),

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
          SizedBox(height: isSmallScreen ? 15 : 20),

          // Mobile
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
          SizedBox(height: isSmallScreen ? 15 : 20),

          // Subject
          TextFormField(
            controller: _subjectController,
            decoration: InputDecoration(
              labelText: languageProvider.isArabic ? 'الموضوع' : 'Subject',
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
            validator: (value) => _validateRequired(value, 'subject'),
          ),
          SizedBox(height: isSmallScreen ? 15 : 20),

          // Message
          TextFormField(
            controller: _messageController,
            maxLines: isSmallScreen ? 3 : 4,
            decoration: InputDecoration(
              labelText: languageProvider.isArabic ? 'الرسالة' : 'Message',
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
            validator: (value) => _validateRequired(value, 'message'),
          ),
          SizedBox(height: isSmallScreen ? 20 : 30),

          // Submit
          ElevatedButton(
            onPressed: _isLoading ? null : () => _submitForm(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF0B81B),
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, isSmallScreen ? 45 : 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              disabledBackgroundColor: Colors.grey[600],
            ),
            child: _isLoading
                ? SizedBox(
                    height: isSmallScreen ? 18 : 20,
                    width: isSmallScreen ? 18 : 20,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    languageProvider.isArabic
                        ? 'إرسال الرسالة'
                        : 'Send Message',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(
    IconData icon,
    String text,
    bool isArabic,
    bool isSmallScreen,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 15 : 20),
      child: Row(
        mainAxisAlignment: isArabic
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isArabic)
            Icon(
              icon,
              color: const Color(0xFFF0B81B),
              size: isSmallScreen ? 20 : 24,
            ),
          if (!isArabic) SizedBox(width: isSmallScreen ? 10 : 15),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: isSmallScreen ? 14 : 16,
                color: Colors.white,
              ),
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
            ),
          ),
          if (isArabic) SizedBox(width: isSmallScreen ? 10 : 15),
          if (isArabic)
            Icon(
              icon,
              color: const Color(0xFFF0B81B),
              size: isSmallScreen ? 20 : 24,
            ),
        ],
      ),
    );
  }
}
