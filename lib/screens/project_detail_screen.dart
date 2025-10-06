import 'package:flutter/material.dart';
import 'package:pca_website/core/api_handler/api_handler.dart';
import 'package:pca_website/core/models/domain_detail.dart';
import 'package:pca_website/core/models/request.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Map<String, dynamic> project;
  final bool isArabic;
  final List<DomainDetailModel> services;

  // API handler
  final APIHandler _api = APIHandler();

  ProjectDetailScreen({
    super.key,
    required this.project,
    required this.isArabic,
    required this.services,
  });

  bool get hasData => services.isNotEmpty;

  // Use your existing API call (signature unchanged)
  Future<List<DomainDetailModel>> _getDomainDetails(int id) async {
    return await _api.getDomainDetail(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(isArabic ? 'تفاصيل المشروع' : 'Project Details'),
        actions: [
          IconButton(
            onPressed: () {
              // Share project functionality
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image Header (static as before)
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: project['image'] != null
                    ? DecorationImage(
                        image: AssetImage(project['image']!),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: Colors.grey[200],
              ),
              child: project['image'] == null
                  ? Center(
                      child: Icon(
                        project['icon'],
                        size: 100,
                        color: Colors.grey[400],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                          ],
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            project['title']!,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),

            // Project Content (static as before)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0B81B).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                project['category']!,
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Color(0xFFF0B81B),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${isArabic ? 'العميل' : 'Client'}: ${project['client']}',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Text(
                    project['description']!,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 40),

                  Text(
                    isArabic ? 'مواصفات المشروع' : 'Project Specifications',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: MediaQuery.of(context).size.width > 600
                        ? 2
                        : 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 15,
                    childAspectRatio: 4,
                    children: [
                      _buildSpecificationItem(
                        Icons.schedule,
                        isArabic ? 'مدة التنفيذ' : 'Implementation Period',
                        project['duration'] ??
                            (isArabic ? '6-12 شهر' : '6-12 Months'),
                      ),
                      _buildSpecificationItem(
                        Icons.attach_money,
                        isArabic ? 'الميزانية' : 'Budget Range',
                        project['budget'] ??
                            (isArabic
                                ? 'متفاوت حسب المشروع'
                                : 'Varies by Project'),
                      ),
                      _buildSpecificationItem(
                        Icons.engineering,
                        isArabic ? 'نطاق العمل' : 'Scope of Work',
                        isArabic
                            ? 'تصميم وتنفيذ متكامل'
                            : 'Integrated Design & Implementation',
                      ),
                      _buildSpecificationItem(
                        Icons.verified,
                        isArabic ? 'معايير الجودة' : 'Quality Standards',
                        isArabic
                            ? 'سعودية ودولية'
                            : 'Saudi & International Standards',
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  Text(
                    isArabic ? 'مميزات المشروع' : 'Project Features',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: (project['features'] as List<String>)
                        .map(
                          (feature) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange[50],
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.orange[200]!),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: Color(0xFFF0B81B),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  feature,
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Color(0xFFF0B81B),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 50),

                  // CTA
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.orange[50]!, Colors.orange[100]!],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          isArabic
                              ? 'مهتم بمشروع مماثل؟'
                              : 'Interested in a similar project?',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isArabic
                              ? 'تواصل معنا لتنفيذ مشروعك بأعلى معايير الجودة'
                              : 'Contact us to execute your project with the highest quality standards',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () =>
                                    _showQuoteRequestDialog(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF0B81B),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  isArabic ? 'اطلب عرض سعر' : 'Request Quote',
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFFF0B81B),
                                  side: const BorderSide(
                                    color: Color(0xFFF0B81B),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  isArabic ? 'مشاريع أخرى' : 'Other Projects',
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Quote dialog ----------
  void _showQuoteRequestDialog(BuildContext context) {
    // Capture the page (Scaffold) context so SnackBars show after the dialog closes.
    final BuildContext rootContext = context;

    final TextEditingController mobileController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController noteController = TextEditingController();

    // Local dialog state
    int? selectedServiceId; // keep ID to avoid Dropdown value equality issues
    DomainDetailModel? selectedServiceModel; // resolved model for submit
    List<DomainDetailModel> servicesInDialog = [];

    showDialog(
      context: context,
      builder: (ctx) {
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Dialog(
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 40,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 400, maxWidth: 500),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: StatefulBuilder(
                  builder: (dialogCtx, setState) {
                    return SizedBox(
                      height: MediaQuery.of(dialogCtx).size.height * 0.7,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isArabic ? 'طلب عرض سعر' : 'Request Quote',
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      Navigator.of(dialogCtx).pop(),
                                  icon: const Icon(Icons.close, size: 20),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              isArabic
                                  ? 'املأ النموذج أدناه وسنتواصل معك قريباً'
                                  : 'Fill out the form below and we will contact you soon',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Service Type
                            Text(
                              isArabic
                                  ? 'نوع الخدمة المطلوبة *'
                                  : 'Required Service Type *',
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 6),

                            FutureBuilder<List<DomainDetailModel>>(
                              future: _getDomainDetails(
                                1,
                              ), // <- ID = 1 as requested
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: LinearProgressIndicator(),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        isArabic
                                            ? 'تعذر تحميل الخدمات.'
                                            : 'Failed to load services.',
                                        style: const TextStyle(
                                          fontFamily: 'Cairo',
                                          color: Colors.red,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      OutlinedButton.icon(
                                        onPressed: () => setState(
                                          () {},
                                        ), // retrigger FutureBuilder
                                        icon: const Icon(Icons.refresh),
                                        label: Text(
                                          isArabic ? 'إعادة المحاولة' : 'Retry',
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                servicesInDialog = (snapshot.data ?? [])
                                    .where(
                                      (s) => s.detailName.trim().isNotEmpty,
                                    )
                                    .toList();

                                if (servicesInDialog.isEmpty) {
                                  return Text(
                                    isArabic
                                        ? 'لا توجد خدمات متاحة.'
                                        : 'No services available.',
                                    style: const TextStyle(fontFamily: 'Cairo'),
                                  );
                                }

                                // Initialize selection once by ID
                                if (selectedServiceId == null) {
                                  selectedServiceId =
                                      servicesInDialog.first.domainDetailId;
                                  selectedServiceModel = servicesInDialog.first;
                                } else {
                                  // Keep model in sync with selected ID
                                  selectedServiceModel = servicesInDialog
                                      .firstWhere(
                                        (s) =>
                                            s.domainDetailId ==
                                            selectedServiceId,
                                        orElse: () => servicesInDialog.first,
                                      );
                                }

                                return DropdownButtonFormField<int>(
                                  value: selectedServiceId,
                                  decoration: InputDecoration(
                                    hintText: isArabic
                                        ? 'اختر نوع الخدمة التي تحتاجها'
                                        : 'Select the service you need',
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                  items: servicesInDialog
                                      .map(
                                        (s) => DropdownMenuItem<int>(
                                          value: s.domainDetailId,
                                          child: Text(
                                            s.detailName,
                                            style: const TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (int? v) {
                                    if (v == null) return;
                                    setState(() {
                                      selectedServiceId = v;
                                      selectedServiceModel = servicesInDialog
                                          .firstWhere(
                                            (s) => s.domainDetailId == v,
                                          );
                                    });
                                  },
                                );
                              },
                            ),

                            const SizedBox(height: 16),

                            // Mobile Number
                            Text(
                              isArabic ? 'رقم الجوال *' : 'Mobile Number *',
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: mobileController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: isArabic
                                    ? 'أدخل رقم الجوال'
                                    : 'Enter mobile number',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Email (Optional)
                            Text(
                              isArabic
                                  ? 'البريد الإلكتروني (اختياري)'
                                  : 'Email (Optional)',
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: isArabic
                                    ? 'أدخل البريد الإلكتروني'
                                    : 'Enter email address',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Notes (Optional)
                            Text(
                              isArabic
                                  ? 'ملاحظات إضافية (اختياري)'
                                  : 'Additional Notes (Optional)',
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: noteController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText: isArabic
                                    ? 'أضف أي تفاصيل إضافية عن متطلباتك'
                                    : 'Add any additional details about your requirements',
                                hintStyle: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () =>
                                        Navigator.of(dialogCtx).pop(),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.grey,
                                      side: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: Text(
                                      isArabic ? 'إلغاء' : 'Cancel',
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (selectedServiceModel == null ||
                                          mobileController.text.isEmpty) {
                                        ScaffoldMessenger.of(
                                          rootContext,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              isArabic
                                                  ? 'يرجى تعبئة الحقول المطلوبة (نوع الخدمة ورقم الجوال)'
                                                  : 'Please fill in the required fields (Service Type and Mobile Number)',
                                              style: const TextStyle(
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      }

                                      _submitQuoteRequest(
                                        rootContext, // use the page context for SnackBars
                                        selectedServiceModel!,
                                        mobileController.text,
                                        emailController.text,
                                        noteController.text,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFF0B81B),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    child: Text(
                                      isArabic
                                          ? 'إرسال الطلب'
                                          : 'Submit Request',
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // -------------------- Submit (POST to API) --------------------
  String _digitsOnly(String input) => input.replaceAll(RegExp(r'[^0-9]'), '');
  int _parseMobileToInt(String mobile) {
    final cleaned = _digitsOnly(mobile);
    return int.tryParse(cleaned) ?? 0;
  }

  void _showAppSnack(
    BuildContext context, {
    required String message,
    required bool success,
  }) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: success ? Colors.green[600] : Colors.red[600],
        elevation: 6,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 4),
        content: Row(
          children: [
            Icon(
              success ? Icons.check_circle : Icons.error,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitQuoteRequest(
    BuildContext rootContext, // <- renamed
    DomainDetailModel service,
    String mobileNumber,
    String email,
    String notes,
  ) async {
    // Close any open dialog
    Navigator.of(rootContext).pop();

    final now = DateTime.now();
    final int organizationId = (project['organizationId'] is int)
        ? project['organizationId'] as int
        : 1;

    final req = RequestModel(
      requestId: 0,
      organizationId: organizationId,
      customerName: 'Website Lead',
      customerEmail: email,
      requestSubject: 'Quote Request - ${project['title'] ?? 'Project'}',
      requestBody: notes.isNotEmpty ? notes : 'No additional notes',
      serviceId: service.domainDetailId,
      customerMobile: _parseMobileToInt(mobileNumber),
      createDateTime: now,
      modifyDateTime: now,
      isResposed: false,
    );

    // show submitting on the page scaffold
    ScaffoldMessenger.of(rootContext).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black87,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 8), // long enough, we'll clear it
        content: Row(
          children: const [
            SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Submitting your request...',
              style: TextStyle(color: Colors.white, fontFamily: 'Cairo'),
            ),
          ],
        ),
      ),
    );

    final ok = await _api.submitRequest(req);

    // ensure previous snack is gone
    ScaffoldMessenger.of(rootContext).clearSnackBars();

    if (ok) {
      _showAppSnack(
        rootContext,
        message: isArabic
            ? 'تم إرسال طلبك بنجاح! سنتواصل معك قريباً.'
            : 'Your request has been submitted successfully! We will contact you soon.',
        success: true,
      );
    } else {
      _showAppSnack(
        rootContext,
        message: isArabic
            ? 'تعذّر إرسال الطلب. يرجى المحاولة لاحقاً.'
            : 'Failed to submit the request. Please try again later.',
        success: false,
      );
    }
  }

  // -------- reused small UI piece ----------
  Widget _buildSpecificationItem(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFF0B81B), size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
