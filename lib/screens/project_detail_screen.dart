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
    final screenWidth = MediaQuery.of(context).size.width;
    final isMediumScreen = screenWidth > 768;
    final isSmallScreen = screenWidth <= 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          isArabic ? 'تفاصيل المشروع' : 'Project Details',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: isSmallScreen ? 18 : 20,
          ),
        ),
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
            // Project Image Header - Responsive
            Container(
              height: isSmallScreen
                  ? 250
                  : isMediumScreen
                  ? 350
                  : 400,
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
                          padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                          child: Text(
                            project['title']!,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: isSmallScreen
                                  ? 24
                                  : isMediumScreen
                                  ? 28
                                  : 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),

            // Project Content - Responsive padding
            Padding(
              padding: EdgeInsets.all(
                isSmallScreen
                    ? 16
                    : isMediumScreen
                    ? 24
                    : 32,
              ),
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
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 12 : 16,
                                vertical: isSmallScreen ? 6 : 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0B81B).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                project['category']!,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: const Color(0xFFF0B81B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: isSmallScreen ? 12 : 14,
                                ),
                              ),
                            ),
                            SizedBox(height: isSmallScreen ? 8 : 10),
                            Text(
                              '${isArabic ? 'العميل' : 'Client'}: ${project['client']}',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: isSmallScreen ? 14 : 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: isSmallScreen ? 20 : 30),

                  Text(
                    project['description']!,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: isSmallScreen ? 14 : 16,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 30 : 40),

                  Text(
                    isArabic ? 'مواصفات المشروع' : 'Project Specifications',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: isSmallScreen
                          ? 20
                          : isMediumScreen
                          ? 24
                          : 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 16 : 20),

                  // Responsive specifications grid
                  if (isSmallScreen)
                    // Mobile: Single column
                    Column(
                      children: [
                        _buildSpecificationItem(
                          Icons.schedule,
                          isArabic ? 'مدة التنفيذ' : 'Implementation Period',
                          project['duration'] ??
                              (isArabic ? '6-12 شهر' : '6-12 Months'),
                          isSmallScreen: isSmallScreen,
                        ),
                        const SizedBox(height: 15),
                        _buildSpecificationItem(
                          Icons.attach_money,
                          isArabic ? 'الميزانية' : 'Budget Range',
                          project['budget'] ??
                              (isArabic
                                  ? 'متفاوت حسب المشروع'
                                  : 'Varies by Project'),
                          isSmallScreen: isSmallScreen,
                        ),
                        const SizedBox(height: 15),
                        _buildSpecificationItem(
                          Icons.engineering,
                          isArabic ? 'نطاق العمل' : 'Scope of Work',
                          isArabic
                              ? 'تصميم وتنفيذ متكامل'
                              : 'Integrated Design & Implementation',
                          isSmallScreen: isSmallScreen,
                        ),
                        const SizedBox(height: 15),
                        _buildSpecificationItem(
                          Icons.verified,
                          isArabic ? 'معايير الجودة' : 'Quality Standards',
                          isArabic
                              ? 'سعودية ودولية'
                              : 'Saudi & International Standards',
                          isSmallScreen: isSmallScreen,
                        ),
                      ],
                    )
                  else
                    // Desktop/Tablet: Grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: isMediumScreen ? 2 : 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 15,
                      childAspectRatio: isMediumScreen ? 4 : 3,
                      children: [
                        _buildSpecificationItem(
                          Icons.schedule,
                          isArabic ? 'مدة التنفيذ' : 'Implementation Period',
                          project['duration'] ??
                              (isArabic ? '6-12 شهر' : '6-12 Months'),
                          isSmallScreen: isSmallScreen,
                        ),
                        _buildSpecificationItem(
                          Icons.attach_money,
                          isArabic ? 'الميزانية' : 'Budget Range',
                          project['budget'] ??
                              (isArabic
                                  ? 'متفاوت حسب المشروع'
                                  : 'Varies by Project'),
                          isSmallScreen: isSmallScreen,
                        ),
                        _buildSpecificationItem(
                          Icons.engineering,
                          isArabic ? 'نطاق العمل' : 'Scope of Work',
                          isArabic
                              ? 'تصميم وتنفيذ متكامل'
                              : 'Integrated Design & Implementation',
                          isSmallScreen: isSmallScreen,
                        ),
                        _buildSpecificationItem(
                          Icons.verified,
                          isArabic ? 'معايير الجودة' : 'Quality Standards',
                          isArabic
                              ? 'سعودية ودولية'
                              : 'Saudi & International Standards',
                          isSmallScreen: isSmallScreen,
                        ),
                      ],
                    ),

                  SizedBox(height: isSmallScreen ? 30 : 40),

                  Text(
                    isArabic ? 'مميزات المشروع' : 'Project Features',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: isSmallScreen
                          ? 20
                          : isMediumScreen
                          ? 24
                          : 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 16 : 20),

                  Wrap(
                    spacing: isSmallScreen ? 8 : 10,
                    runSpacing: isSmallScreen ? 8 : 10,
                    children: (project['features'] as List<String>)
                        .map(
                          (feature) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 16,
                              vertical: isSmallScreen ? 8 : 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange[50],
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.orange[200]!),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: isSmallScreen ? 14 : 16,
                                  color: const Color(0xFFF0B81B),
                                ),
                                SizedBox(width: isSmallScreen ? 6 : 8),
                                Text(
                                  feature,
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    color: const Color(0xFFF0B81B),
                                    fontWeight: FontWeight.w500,
                                    fontSize: isSmallScreen ? 12 : 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  SizedBox(height: isSmallScreen ? 40 : 50),

                  // CTA - Responsive
                  Container(
                    padding: EdgeInsets.all(isSmallScreen ? 20 : 30),
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
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: isSmallScreen
                                ? 18
                                : isMediumScreen
                                ? 22
                                : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: isSmallScreen ? 8 : 10),
                        Text(
                          isArabic
                              ? 'تواصل معنا لتنفيذ مشروعك بأعلى معايير الجودة'
                              : 'Contact us to execute your project with the highest quality standards',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: isSmallScreen ? 14 : 16,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: isSmallScreen ? 20 : 25),
                        // Responsive button layout
                        if (isSmallScreen)
                          // Mobile: Stacked buttons
                          Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
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
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
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
                          )
                        else
                          // Desktop/Tablet: Side by side buttons
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

    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 600;

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
            insetPadding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 16 : 20,
              vertical: isSmallScreen ? 20 : 40,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: isSmallScreen ? 300 : 400,
                maxWidth: isSmallScreen ? 350 : 500,
              ),
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                child: StatefulBuilder(
                  builder: (dialogCtx, setState) {
                    return SizedBox(
                      height:
                          MediaQuery.of(dialogCtx).size.height *
                          (isSmallScreen ? 0.8 : 0.7),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    isArabic ? 'طلب عرض سعر' : 'Request Quote',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: isSmallScreen ? 18 : 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      Navigator.of(dialogCtx).pop(),
                                  icon: const Icon(Icons.close, size: 20),
                                ),
                              ],
                            ),
                            SizedBox(height: isSmallScreen ? 6 : 8),
                            Text(
                              isArabic
                                  ? 'املأ النموذج أدناه وسنتواصل معك قريباً'
                                  : 'Fill out the form below and we will contact you soon',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: isSmallScreen ? 12 : 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: isSmallScreen ? 16 : 20),

                            // Service Type
                            Text(
                              isArabic
                                  ? 'نوع الخدمة المطلوبة *'
                                  : 'Required Service Type *',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: isSmallScreen ? 12 : 14,
                              ),
                            ),
                            SizedBox(height: isSmallScreen ? 4 : 6),

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
                                  initialValue: selectedServiceId,
                                  decoration: InputDecoration(
                                    hintText: isArabic
                                        ? 'اختر نوع الخدمة التي تحتاجها'
                                        : 'Select the service you need',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: isSmallScreen ? 12 : 14,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: isSmallScreen ? 10 : 12,
                                      vertical: isSmallScreen ? 10 : 12,
                                    ),
                                  ),
                                  items: servicesInDialog
                                      .map(
                                        (s) => DropdownMenuItem<int>(
                                          value: s.domainDetailId,
                                          child: Text(
                                            s.detailName,
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: isSmallScreen ? 12 : 14,
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

                            SizedBox(height: isSmallScreen ? 12 : 16),

                            // Mobile Number
                            Text(
                              isArabic ? 'رقم الجوال *' : 'Mobile Number *',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: isSmallScreen ? 12 : 14,
                              ),
                            ),
                            SizedBox(height: isSmallScreen ? 4 : 6),
                            TextFormField(
                              controller: mobileController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: isArabic
                                    ? 'أدخل رقم الجوال'
                                    : 'Enter mobile number',
                                hintStyle: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: isSmallScreen ? 12 : 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 10 : 12,
                                  vertical: isSmallScreen ? 10 : 12,
                                ),
                              ),
                            ),

                            SizedBox(height: isSmallScreen ? 12 : 16),

                            // Email (Optional)
                            Text(
                              isArabic
                                  ? 'البريد الإلكتروني (اختياري)'
                                  : 'Email (Optional)',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: isSmallScreen ? 12 : 14,
                              ),
                            ),
                            SizedBox(height: isSmallScreen ? 4 : 6),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: isArabic
                                    ? 'أدخل البريد الإلكتروني'
                                    : 'Enter email address',
                                hintStyle: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: isSmallScreen ? 12 : 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 10 : 12,
                                  vertical: isSmallScreen ? 10 : 12,
                                ),
                              ),
                            ),

                            SizedBox(height: isSmallScreen ? 12 : 16),

                            // Notes (Optional)
                            Text(
                              isArabic
                                  ? 'ملاحظات إضافية (اختياري)'
                                  : 'Additional Notes (Optional)',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: isSmallScreen ? 12 : 14,
                              ),
                            ),
                            SizedBox(height: isSmallScreen ? 4 : 6),
                            TextFormField(
                              controller: noteController,
                              maxLines: isSmallScreen ? 2 : 3,
                              decoration: InputDecoration(
                                hintText: isArabic
                                    ? 'أضف أي تفاصيل إضافية عن متطلباتك'
                                    : 'Add any additional details about your requirements',
                                hintStyle: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: isSmallScreen ? 12 : 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 10 : 12,
                                  vertical: isSmallScreen ? 10 : 12,
                                ),
                              ),
                            ),

                            SizedBox(height: isSmallScreen ? 20 : 24),

                            // Buttons - Responsive
                            if (isSmallScreen)
                              // Mobile: Stacked buttons
                              Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
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
                                        backgroundColor: const Color(
                                          0xFFF0B81B,
                                        ),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        isArabic
                                            ? 'إرسال الطلب'
                                            : 'Submit Request',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: isSmallScreen ? 12 : 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: double.infinity,
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
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        isArabic ? 'إلغاء' : 'Cancel',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: isSmallScreen ? 12 : 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else
                              // Desktop/Tablet: Side by side buttons
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
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
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
                                        backgroundColor: const Color(
                                          0xFFF0B81B,
                                        ),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
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
  Widget _buildSpecificationItem(
    IconData icon,
    String title,
    String value, {
    bool isSmallScreen = false,
  }) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 15),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFFF0B81B),
            size: isSmallScreen ? 20 : 24,
          ),
          SizedBox(width: isSmallScreen ? 12 : 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: isSmallScreen ? 12 : 14,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 3 : 5),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: isSmallScreen ? 13 : 14,
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
