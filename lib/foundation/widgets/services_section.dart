import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: Colors.grey[50],
      child: Column(
        children: [
          Text(
            languageProvider.services,
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
                ? 'خدماتنا المتكاملة في مجال المقاولات والهندسة'
                : 'Our Integrated Contracting and Engineering Services',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          
          const SizedBox(height: 60),
          
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 0.9,
            ),
            itemCount: _getServices(languageProvider.isArabic).length,
            itemBuilder: (context, index) {
              final service = _getServices(languageProvider.isArabic)[index];
              return _buildServiceCard(service, languageProvider.isArabic);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service, bool isArabic) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.grey[50]!,
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Icon
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xFFF0B81B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  service['icon'] as IconData,
                  size: 40,
                  color: const Color(0xFFF0B81B),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Service Title
              Text(
                service['title']!,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              
              const SizedBox(height: 10),
              
              // Service Description
              Expanded(
                child: Text(
                  service['description']!,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ),
              
              const SizedBox(height: 15),
              
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
                      ),
                    ),
                    const SizedBox(height: 5),
                    ...(service['features'] as List<String>).take(3).map((feature) => 
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          '• $feature',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
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
            ? ['البنية التحتية للاتصالات', 'الألياف البصرية OSP & ISP', 'مراكز البيانات', 'أنظمة VOIP', 'أبراج الاتصالات']
            : ['Telecom Infrastructure', 'Fiber Optics OSP & ISP', 'Data Centers', 'VOIP Systems', 'Communication Towers'],
      },
      {
        'title': isArabic ? 'أعمال الكهرباء' : 'Electrical Works',
        'description': isArabic
            ? 'خدمات كهربائية كاملة للصناعات والمؤسسات بكافة أحجامها'
            : 'Complete electrical services for industries and institutions of all sizes',
        'icon': Icons.electrical_services,
        'features': isArabic 
            ? ['كابلات الجهد العالي والمنخفض', 'المحولات الكهربائية', 'لوحات التحكم MCC', 'الطاقة الشمسية', 'أنظمة التأريض']
            : ['HV/LV Cables', 'Electrical Transformers', 'MCC Control Panels', 'Solar Energy', 'Grounding Systems'],
      },
      {
        'title': isArabic ? 'الأعمال الميكانيكية' : 'Mechanical Works',
        'description': isArabic
            ? 'خدمات ميكانيكية متكاملة تشمل التصميم والتركيب والتشغيل'
            : 'Integrated mechanical services including design, installation, and operation',
        'icon': Icons.build,
        'features': isArabic 
            ? ['السباكة والصرف الصحي', 'أنظمة التكييف والتدفئة', 'المضخات والأنظمة الهيدروليكية', 'مكافحة الحرائق', 'أنظمة الغاز']
            : ['Plumbing & Sanitation', 'HVAC Systems', 'Pumps & Hydraulic Systems', 'Fire Fighting', 'Gas Systems'],
      },
      {
        'title': isArabic ? 'الإنشاءات المدنية' : 'Civil Construction',
        'description': isArabic
            ? 'تنفيذ مشاريع الإنشاءات المدنية بجميع مراحلها من الدراسة إلى التنفيذ'
            : 'Execution of civil construction projects in all phases from study to implementation',
        'icon': Icons.architecture,
        'features': isArabic 
            ? ['تطوير المواقع', 'أعمال الأسفلت والطرق', 'الأساسات والهياكل', 'المحطات الكهربائية', 'العزل المائي']
            : ['Site Development', 'Asphalt & Roads', 'Foundations & Structures', 'Electrical Substations', 'Waterproofing'],
      },
      {
        'title': isArabic ? 'أعمال الهناجر' : 'Hangar Works',
        'description': isArabic
            ? 'تصنيع وتركيب كافة أنواع الهناجر والمستودعات'
            : 'Manufacturing and installation of all types of hangars and warehouses',
        'icon': Icons.warehouse,
        'features': isArabic 
            ? ['هناجر المستودعات', 'هناجر الشركات', 'الهياكل الجاهزة', 'التصميم والتصنيع', 'الصيانة']
            : ['Warehouse Hangars', 'Company Hangars', 'Pre-engineered Structures', 'Design & Manufacturing', 'Maintenance'],
      },
      {
        'title': isArabic ? 'أنظمة التحكم والبرمجة' : 'Control Systems & Programming',
        'description': isArabic
            ? 'تصميم وبرمجة أنظمة التحكم الصناعي والأنظمة الآلية'
            : 'Design and programming of industrial control systems and automated systems',
        'icon': Icons.memory,
        'features': isArabic 
            ? ['أنظمة SCADA', 'برمجة PLC', 'الأنظمة الصناعية', 'التحكم بالآلات', 'الصيانة والتطوير']
            : ['SCADA Systems', 'PLC Programming', 'Industrial Systems', 'Machine Control', 'Maintenance & Development'],
      },
    ];
  }
}