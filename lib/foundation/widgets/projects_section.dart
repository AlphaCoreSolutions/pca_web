import 'package:flutter/material.dart';
import 'package:pca_website/screens/project_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: Colors.white,
      child: Column(
        children: [
          // Section Title
          Text(
            languageProvider.isArabic ? 'اعمالنا' : 'Our Projects',
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
                ? 'أبرز المشاريع التي نفخر بتنفيذها'
                : 'Highlighted Projects We Are Proud Of',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),

          const SizedBox(height: 60),

          // Projects Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 1200
                  ? 3
                  : MediaQuery.of(context).size.width > 768
                  ? 2
                  : 1,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 0.8,
            ),
            itemCount: _getProjects(languageProvider.isArabic).length,
            itemBuilder: (context, index) {
              final project = _getProjects(languageProvider.isArabic)[index];
              return _buildProjectCard(
                context,
                project,
                languageProvider.isArabic,
              );
            },
          ),

          const SizedBox(height: 60),

          // Project Categories
          Text(
            languageProvider.isArabic ? 'مجالات تخصصنا' : 'Our Specializations',
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF0B81B),
            ),
          ),

          const SizedBox(height: 40),

          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: _getProjectCategories(
              languageProvider.isArabic,
            ).map((category) => _buildCategoryChip(category)).toList(),
          ),

          const SizedBox(height: 40),

          // Call to Action
          Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.orange[50]!, Colors.orange[100]!],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.construction,
                  size: 60,
                  color: Color(0xFFF0B81B),
                ),
                const SizedBox(height: 20),
                Text(
                  languageProvider.isArabic
                      ? 'هل تبحث عن شريك موثوق لمشروعك القادم؟'
                      : 'Looking for a reliable partner for your next project?',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  languageProvider.isArabic
                      ? 'تواصل معنا اليوم لتنفيذ مشروعك بأعلى معايير الجودة والاحترافية'
                      : 'Contact us today to execute your project with the highest standards of quality and professionalism',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to contact section
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF0B81B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    languageProvider.isArabic
                        ? 'اتصل بنا الآن'
                        : 'Contact Us Now',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    Map<String, dynamic> project,
    bool isArabic,
  ) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[50]!, Colors.white],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Colors.grey[200],
                  image: project['image'] != null
                      ? DecorationImage(
                          image: AssetImage(project['image']!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: project['image'] == null
                    ? Center(
                        child: Icon(
                          project['icon'],
                          size: 60,
                          color: Colors.grey[400],
                        ),
                      )
                    : Stack(
                        children: [
                          // Image overlay
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.3),
                                ],
                              ),
                            ),
                          ),
                          // View Details button on image hover
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Opacity(
                              opacity: 0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  _navigateToProjectDetail(
                                    context,
                                    project,
                                    isArabic,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF0B81B),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  isArabic ? 'عرض' : 'View',
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            // Project Content
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Category
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
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
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Project Title
                    Text(
                      project['title']!,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 10),

                    // Project Description
                    Expanded(
                      child: Text(
                        project['description']!,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Project Features
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (project['features'] as List<String>)
                          .take(2)
                          .map(
                            (feature) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                feature,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 10,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),

                    const SizedBox(height: 15),

                    // View Details Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _navigateToProjectDetail(context, project, isArabic);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF0B81B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          isArabic ? 'عرض التفاصيل' : 'View Details',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToProjectDetail(
    BuildContext context,
    Map<String, dynamic> project,
    bool isArabic,
  ) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ProjectDetailScreen(
              project: project,
              isArabic: isArabic,
              services: [],
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  Widget _buildCategoryChip(Map<String, dynamic> category) {
    return InkWell(
      onTap: () {
        // Filter projects by category
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.orange[50],
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.orange[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              category['icon'] as IconData,
              color: const Color(0xFFF0B81B),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              category['title']!,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFFF0B81B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getProjects(bool isArabic) {
    return [
      {
        'title': isArabic
            ? 'مشاريع الاتصالات والبنية التحتية'
            : 'Telecommunications & Infrastructure Projects',
        'category': isArabic ? 'الاتصالات' : 'Telecommunications',
        'description': isArabic
            ? 'تنفيذ مشاريع البنية التحتية للاتصالات بما في ذلك أبراج الاتصالات، كابلات الألياف البصرية، ومراكز البيانات لأنظمة GCM وVOIP'
            : 'Implementation of telecommunications infrastructure projects including communication towers, fiber optic cables, and data centers for GCM and VOIP systems',
        'features': isArabic
            ? [
                'أبراج GCM',
                'الألياف البصرية OSP/ISP',
                'مراكز البيانات',
                'أنظمة VOIP',
                'أنظمة الإنذار',
              ]
            : [
                'GCM Towers',
                'Fiber Optics OSP/ISP',
                'Data Centers',
                'VOIP Systems',
                'Alarm Systems',
              ],
        'icon': Icons.settings_input_antenna,
        'image': 'assets/images/projects/telecom_project.jpg',
        'client': isArabic ? 'شركات الاتصالات' : 'Telecom Companies',
        'duration': isArabic ? '6-9 أشهر' : '6-9 Months',
        'budget': isArabic ? '1-5 مليون ريال' : '1-5 Million SAR',
      },
      {
        'title': isArabic
            ? 'المشاريع الكهربائية والطاقة الشمسية'
            : 'Electrical & Solar Energy Projects',
        'category': isArabic ? 'الكهرباء' : 'Electrical',
        'description': isArabic
            ? 'تركيب أنظمة الكهرباء والمحولات والطاقة الشمسية مع أنظمة المزامنة للمشاريع الصناعية والتجارية'
            : 'Installation of electrical systems, transformers, solar energy with synchronization systems for industrial and commercial projects',
        'features': isArabic
            ? [
                'كابلات HV/LV',
                'المحولات',
                'الطاقة الشمسية',
                'أنظمة التأريض',
                'لوحات MCC',
              ]
            : [
                'HV/LV Cables',
                'Transformers',
                'Solar Energy',
                'Grounding Systems',
                'MCC Panels',
              ],
        'icon': Icons.electrical_services,
        'image': 'assets/images/projects/electrical_project.jpg',
        'client': isArabic ? 'القطاع الصناعي' : 'Industrial Sector',
        'duration': isArabic ? '3-6 أشهر' : '3-6 Months',
        'budget': isArabic ? '500 ألف-2 مليون ريال' : '500K-2 Million SAR',
      },
      {
        'title': isArabic
            ? 'المشاريع الميكانيكية والصناعية'
            : 'Mechanical & Industrial Projects',
        'category': isArabic ? 'الميكانيكا' : 'Mechanical',
        'description': isArabic
            ? 'تنفيذ المشاريع الميكانيكية المتكاملة لأنظمة التكييف والتدفئة والسباكة والأنظمة الهيدروليكية والتحكم VFD'
            : 'Implementation of integrated mechanical projects for HVAC, plumbing, hydraulic systems and VFD control',
        'features': isArabic
            ? [
                'أنظمة HVAC',
                'السباكة والصرف',
                'المضخات الهيدروليكية',
                'مكافحة الحرائق',
                'أنظمة VFD',
              ]
            : [
                'HVAC Systems',
                'Plumbing & Drainage',
                'Hydraulic Pumps',
                'Fire Fighting',
                'VFD Systems',
              ],
        'icon': Icons.build,
        'image': 'assets/images/projects/mechanical_project.jpeg',
        'client': isArabic ? 'المنشآت الصناعية' : 'Industrial Facilities',
        'duration': isArabic ? '4-8 أشهر' : '4-8 Months',
        'budget': isArabic ? '750 ألف-3 مليون ريال' : '750K-3 Million SAR',
      },
      {
        'title': isArabic
            ? 'مشاريع الإنشاءات المدنية والطرق'
            : 'Civil Construction & Roads Projects',
        'category': isArabic ? 'المدنية' : 'Civil',
        'description': isArabic
            ? 'تنفيذ مشاريع البنية التحتية والطرق والأسفلت والمباني الصناعية مع أعمال الصرف والعزل المائي'
            : 'Implementation of infrastructure projects, roads, asphalt, industrial buildings with drainage and waterproofing works',
        'features': isArabic
            ? [
                'الطرق والأسفلت',
                'الأساسات الخرسانية',
                'المحطات الكهربائية',
                'العزل المائي',
                'أعمال الصرف',
              ]
            : [
                'Roads & Asphalt',
                'Concrete Foundations',
                'Electrical Stations',
                'Waterproofing',
                'Drainage Works',
              ],
        'icon': Icons.architecture,
        'image': 'assets/images/projects/civil_project.jpeg',
        'client': isArabic
            ? 'القطاع الحكومي والخاص'
            : 'Government & Private Sector',
        'duration': isArabic ? '8-12 أشهر' : '8-12 Months',
        'budget': isArabic ? '2-10 مليون ريال' : '2-10 Million SAR',
      },
      {
        'title': isArabic
            ? 'مشاريع الهناجر والمستودعات'
            : 'Hangar & Warehouse Projects',
        'category': isArabic ? 'الهنجرة' : 'Hangars',
        'description': isArabic
            ? 'تصميم وتصنيع وتركيب الهناجر والمستودعات الجاهزة للقطاعات الحكومية والخاصة والصناعية'
            : 'Design, manufacturing, and installation of pre-engineered hangars and warehouses for government, private and industrial sectors',
        'features': isArabic
            ? [
                'هناجر جاهزة',
                'المستودعات الصناعية',
                'الهياكل الفولاذية',
                'التصميم المتكامل',
                'الصيانة الدورية',
              ]
            : [
                'Pre-engineered Hangars',
                'Industrial Warehouses',
                'Steel Structures',
                'Integrated Design',
                'Periodic Maintenance',
              ],
        'icon': Icons.warehouse,
        'image': 'assets/images/projects/hangar_project.jpeg',
        'client': isArabic ? 'القطاع اللوجستي' : 'Logistics Sector',
        'duration': isArabic ? '2-4 أشهر' : '2-4 Months',
        'budget': isArabic ? '1-3 مليون ريال' : '1-3 Million SAR',
      },
      {
        'title': isArabic
            ? 'مشاريع أنظمة التحكم الآلي والSCADA'
            : 'Automated Control & SCADA Systems Projects',
        'category': isArabic ? 'التحكم الآلي' : 'Control Systems',
        'description': isArabic
            ? 'تصميم وبرمجة أنظمة SCADA وPLC للتحكم في العمليات الصناعية والآلات مع أنظمة المراقبة CCTV'
            : 'Design and programming of SCADA and PLC systems for industrial process and machine control with CCTV monitoring systems',
        'features': isArabic
            ? [
                'أنظمة SCADA',
                'برمجة PLC',
                'التحكم الصناعي',
                'أنظمة المراقبة',
                'الصيانة الذكية',
              ]
            : [
                'SCADA Systems',
                'PLC Programming',
                'Industrial Control',
                'Monitoring Systems',
                'Smart Maintenance',
              ],
        'icon': Icons.memory,
        'image': 'assets/images/projects/control_project.jpeg',
        'client': isArabic ? 'المصانع والمنشآت' : 'Factories & Facilities',
        'duration': isArabic ? '3-5 أشهر' : '3-5 Months',
        'budget': isArabic ? '500 ألف-1.5 مليون ريال' : '500K-1.5 Million SAR',
      },
    ];
  }

  List<Map<String, dynamic>> _getProjectCategories(bool isArabic) {
    return [
      {
        'title': isArabic ? 'الاتصالات' : 'Telecommunications',
        'icon': Icons.settings_input_antenna,
        'count': '12+',
      },
      {
        'title': isArabic ? 'الكهرباء' : 'Electrical',
        'icon': Icons.electrical_services,
        'count': '8+',
      },
      {
        'title': isArabic ? 'الميكانيكا' : 'Mechanical',
        'icon': Icons.build,
        'count': '6+',
      },
      {
        'title': isArabic ? 'المدنية' : 'Civil',
        'icon': Icons.architecture,
        'count': '10+',
      },
      {
        'title': isArabic ? 'الهنجرة' : 'Hangars',
        'icon': Icons.warehouse,
        'count': '4+',
      },
      {
        'title': isArabic ? 'التحكم الآلي' : 'Control Systems',
        'icon': Icons.memory,
        'count': '5+',
      },
    ];
  }
}
