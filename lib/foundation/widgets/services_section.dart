import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
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
      color: Colors.grey[50],
      child: Column(
        children: [
          Text(
            languageProvider.services,
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
                ? 'خدماتنا المتكاملة في مجال المقاولات والهندسة'
                : 'Our Integrated Contracting and Engineering Services',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: isSmallScreen
                  ? 14
                  : isMediumScreen
                  ? 16
                  : 18,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(
            height: isSmallScreen
                ? 30
                : isMediumScreen
                ? 45
                : 60,
          ),

          // Responsive Grid
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: isSmallScreen
                    ? 15
                    : isMediumScreen
                    ? 20
                    : 30,
                runSpacing: isSmallScreen
                    ? 15
                    : isMediumScreen
                    ? 20
                    : 30,
                children: _getServices(languageProvider.isArabic).map((
                  service,
                ) {
                  final cardWidth = isSmallScreen
                      ? constraints.maxWidth
                      : isMediumScreen
                      ? (constraints.maxWidth - 20) / 2
                      : (constraints.maxWidth - 60) / 3;

                  return SizedBox(
                    width: cardWidth,
                    child: _buildServiceCard(
                      service,
                      languageProvider.isArabic,
                      isSmallScreen: isSmallScreen,
                      isMediumScreen: isMediumScreen,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    Map<String, dynamic> service,
    bool isArabic, {
    bool isSmallScreen = false,
    bool isMediumScreen = false,
  }) {
    return IntrinsicHeight(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.grey[50]!],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Service Icon
                Container(
                  padding: EdgeInsets.all(isSmallScreen ? 12 : 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0B81B).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    service['icon'] as IconData,
                    size: isSmallScreen
                        ? 32
                        : isMediumScreen
                        ? 36
                        : 40,
                    color: const Color(0xFFF0B81B),
                  ),
                ),

                SizedBox(height: isSmallScreen ? 12 : 16),

                // Service Title
                Text(
                  service['title']!,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: isSmallScreen
                        ? 18
                        : isMediumScreen
                        ? 19
                        : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: isSmallScreen ? 4 : 6),

                // Service Description
                Text(
                  service['description']!,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: isSmallScreen ? 12 : 13,
                    color: Colors.grey[700],
                    height: 1.3,
                  ),
                  maxLines: isSmallScreen ? 3 : 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: isSmallScreen ? 8 : 10),

                // Features List
                if (service['features'] != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isArabic ? 'تشمل خدماتنا:' : 'Our services include:',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          fontSize: isSmallScreen ? 12 : 13,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 4 : 6),
                      for (String feature
                          in (service['features'] as List<String>))
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: isSmallScreen ? 2 : 3,
                          ),
                          child: Text(
                            '• $feature',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: isSmallScreen ? 10 : 11,
                              color: Colors.grey[600],
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getServices(bool isArabic) {
    return [
      {
        'title': isArabic ? 'أعمال الاتصالات' : 'Telecommunications Works',
        'description': isArabic
            ? 'بناء البنية التحتية للاتصالات، ربط كابلات الألياف البصرية، تجهيز غرف مراكز البيانات'
            : 'Building telecommunications infrastructure, fiber optic cable connections, data center room preparation',
        'icon': Icons.settings_input_antenna,
        'features': isArabic
            ? [
                'البنية التحتية للاتصالات',
                'الألياف البصرية OSP & ISP',
                'مراكز البيانات',
                'أنظمة VOIP',
                'أبراج الاتصالات',
              ]
            : [
                'Telecom Infrastructure',
                'Fiber Optics OSP & ISP',
                'Data Centers',
                'VOIP Systems',
                'Communication Towers',
              ],
      },
      {
        'title': isArabic ? 'أعمال الكهرباء' : 'Electrical Works',
        'description': isArabic
            ? 'خدمات كهربائية كاملة للصناعات والمؤسسات بكافة أحجامها'
            : 'Complete electrical services for industries and institutions of all sizes',
        'icon': Icons.electrical_services,
        'features': isArabic
            ? [
                'كابلات الجهد العالي والمنخفض',
                'المحولات الكهربائية',
                'لوحات التحكم MCC',
                'الطاقة الشمسية',
                'أنظمة التأريض',
              ]
            : [
                'HV/LV Cables',
                'Electrical Transformers',
                'MCC Control Panels',
                'Solar Energy',
                'Grounding Systems',
              ],
      },
      {
        'title': isArabic ? 'الأعمال الميكانيكية' : 'Mechanical Works',
        'description': isArabic
            ? 'خدمات ميكانيكية متكاملة تشمل التصميم والتركيب والتشغيل'
            : 'Integrated mechanical services including design, installation, and operation',
        'icon': Icons.build,
        'features': isArabic
            ? [
                'السباكة والصرف الصحي',
                'أنظمة التكييف والتدفئة',
                'المضخات والأنظمة الهيدروليكية',
                'مكافحة الحرائق',
                'أنظمة الغاز',
              ]
            : [
                'Plumbing & Sanitation',
                'HVAC Systems',
                'Pumps & Hydraulic Systems',
                'Fire Fighting',
                'Gas Systems',
              ],
      },
      {
        'title': isArabic ? 'الإنشاءات المدنية' : 'Civil Construction',
        'description': isArabic
            ? 'تنفيذ مشاريع الإنشاءات المدنية بجميع مراحلها من الدراسة إلى التنفيذ'
            : 'Execution of civil construction projects in all phases from study to implementation',
        'icon': Icons.architecture,
        'features': isArabic
            ? [
                'تطوير المواقع',
                'أعمال الأسفلت والطرق',
                'الأساسات والهياكل',
                'المحطات الكهربائية',
                'العزل المائي',
              ]
            : [
                'Site Development',
                'Asphalt & Roads',
                'Foundations & Structures',
                'Electrical Substations',
                'Waterproofing',
              ],
      },
      {
        'title': isArabic ? 'أعمال الهناجر' : 'Hangar Works',
        'description': isArabic
            ? 'تصنيع وتركيب كافة أنواع الهناجر والمستودعات'
            : 'Manufacturing and installation of all types of hangars and warehouses',
        'icon': Icons.warehouse,
        'features': isArabic
            ? [
                'هناجر المستودعات',
                'هناجر الشركات',
                'الهياكل الجاهزة',
                'التصميم والتصنيع',
                'الصيانة',
              ]
            : [
                'Warehouse Hangars',
                'Company Hangars',
                'Pre-engineered Structures',
                'Design & Manufacturing',
                'Maintenance',
              ],
      },
      {
        'title': isArabic
            ? 'أنظمة التحكم والبرمجة'
            : 'Control Systems & Programming',
        'description': isArabic
            ? 'تصميم وبرمجة أنظمة التحكم الصناعي والأنظمة الآلية'
            : 'Design and programming of industrial control systems and automated systems',
        'icon': Icons.memory,
        'features': isArabic
            ? [
                'أنظمة SCADA',
                'برمجة PLC',
                'الأنظمة الصناعية',
                'التحكم بالآلات',
                'الصيانة والتطوير',
              ]
            : [
                'SCADA Systems',
                'PLC Programming',
                'Industrial Systems',
                'Machine Control',
                'Maintenance & Development',
              ],
      },
    ];
  }
}
