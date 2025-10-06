import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[100]!,
            Colors.white,
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            languageProvider.aboutUs,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF0B81B),
            ),
          ),
          const SizedBox(height: 40),
          
          // Company Introduction
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/company-building.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageProvider.companyName,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    Text(
                      languageProvider.companyFounded,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        color: Color(0xFFF0B81B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Text(
                      languageProvider.isArabic
                          ? 'واحدة من أبرز شركات المقاولات في المملكة العربية السعودية، ملتزمون بالجودة في موظفينا وخدماتنا. نسعى إلى تحقيق الأفضل من خلال قيمنا والتزامنا بالتصرف بشكل أخلاقي في كل ما نقوم به.'
                          : 'One of the leading contracting companies in Saudi Arabia, committed to quality in our employees and services. We strive to achieve the best through our values and commitment to ethical behavior in everything we do.',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.6,
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Statistics Row
                    _buildStatisticsRow(languageProvider),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 60),
          
          // Vision, Mission, Values
          Row(
            children: [
              Expanded(child: _buildVisionCard(languageProvider)),
              const SizedBox(width: 20),
              Expanded(child: _buildMissionCard(languageProvider)),
              const SizedBox(width: 20),
              Expanded(child: _buildValuesCard(languageProvider)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsRow(LanguageProvider languageProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem('3+', languageProvider.experienceYears),
        _buildStatItem('28', languageProvider.clientsCount),
        _buildStatItem('10M+', languageProvider.projectsValue),
        _buildStatItem('40+', languageProvider.projectsCount),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF0B81B),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 14,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildVisionCard(LanguageProvider languageProvider) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.visibility, color: Color(0xFFF0B81B), size: 40),
            const SizedBox(height: 15),
            Text(
              languageProvider.vision,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF0B81B),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              languageProvider.isArabic
                  ? 'أن نكون من أبرز الشركات في مجال المقاولات من خلال التطوير المستمر لخدماتنا وإضافة قيمة للعملاء بالالتزام وثقة في العمل'
                  : 'To be one of the leading companies in contracting through continuous development of our services and adding value to customers with commitment and trust in work',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionCard(LanguageProvider languageProvider) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.flag, color: Color(0xFFF0B81B), size: 40),
            const SizedBox(height: 15),
            Text(
              languageProvider.mission,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF0B81B),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              languageProvider.isArabic
                  ? 'أن نكون الشركة الأولى لعملائنا، المزود المثالي الذي يوفر حلول شاملة في المجالات الهندسية والإنشائية'
                  : 'To be the first choice company for our customers, the ideal provider offering comprehensive solutions in engineering and construction fields',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValuesCard(LanguageProvider languageProvider) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.star, color: Color(0xFFF0B81B), size: 40),
            const SizedBox(height: 15),
            Text(
              languageProvider.values,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF0B81B),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              languageProvider.isArabic
                  ? 'الجودة الفائقة، الالتزام بالتسليم في الوقت المحدد، الشفافية والوضوح، رضا العملاء'
                  : 'High quality, commitment to timely delivery, transparency and clarity, customer satisfaction',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}