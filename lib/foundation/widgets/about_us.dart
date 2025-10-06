import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey[100]!, Colors.white],
        ),
      ),
      child: Column(
        children: [
          Text(
            languageProvider.aboutUs,
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
          SizedBox(
            height: isSmallScreen
                ? 20
                : isMediumScreen
                ? 30
                : 40,
          ),

          // Company Introduction
          isSmallScreen
              ? Column(
                  children: [
                    // Image Section
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/projects/construction_pattern.jpeg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Text Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          languageProvider.companyName,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
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
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 20),

                        Text(
                          languageProvider.isArabic
                              ? 'واحدة من أبرز شركات المقاولات في المملكة العربية السعودية، ملتزمون بالجودة في موظفينا وخدماتنا. نسعى إلى تحقيق الأفضل من خلال قيمنا والتزامنا بالتصرف بشكل أخلاقي في كل ما نقوم به.'
                              : 'One of the leading contracting companies in Saudi Arabia, committed to quality in our employees and services. We strive to achieve the best through our values and commitment to ethical behavior in everything we do.',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14,
                            color: Colors.grey[700],
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 30),

                        // Statistics Row
                        _buildStatisticsRow(languageProvider, isSmallScreen),
                      ],
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: isMediumScreen ? 250 : 300,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/projects/construction_pattern.jpeg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: isMediumScreen ? 30 : 40),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            languageProvider.companyName,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: isMediumScreen ? 24 : 28,
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
                              fontSize: isMediumScreen ? 15 : 16,
                              color: Colors.grey[700],
                              height: 1.6,
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Statistics Row
                          _buildStatisticsRow(languageProvider, isSmallScreen),
                        ],
                      ),
                    ),
                  ],
                ),

          SizedBox(
            height: isSmallScreen
                ? 40
                : isMediumScreen
                ? 50
                : 60,
          ),

          // Vision, Mission, Values
          isSmallScreen
              ? Column(
                  children: [
                    _buildVisionCard(languageProvider, isSmallScreen),
                    const SizedBox(height: 20),
                    _buildMissionCard(languageProvider, isSmallScreen),
                    const SizedBox(height: 20),
                    _buildValuesCard(languageProvider, isSmallScreen),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: _buildVisionCard(languageProvider, isSmallScreen),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildMissionCard(languageProvider, isSmallScreen),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildValuesCard(languageProvider, isSmallScreen),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildStatisticsRow(
    LanguageProvider languageProvider,
    bool isSmallScreen,
  ) {
    return isSmallScreen
        ? Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildStatItem(
                '3+',
                languageProvider.experienceYears,
                isSmallScreen,
              ),
              _buildStatItem(
                '28',
                languageProvider.clientsCount,
                isSmallScreen,
              ),
              _buildStatItem(
                '10M+',
                languageProvider.projectsValue,
                isSmallScreen,
              ),
              _buildStatItem(
                '40+',
                languageProvider.projectsCount,
                isSmallScreen,
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                '3+',
                languageProvider.experienceYears,
                isSmallScreen,
              ),
              _buildStatItem(
                '28',
                languageProvider.clientsCount,
                isSmallScreen,
              ),
              _buildStatItem(
                '10M+',
                languageProvider.projectsValue,
                isSmallScreen,
              ),
              _buildStatItem(
                '40+',
                languageProvider.projectsCount,
                isSmallScreen,
              ),
            ],
          );
  }

  Widget _buildStatItem(String value, String label, bool isSmallScreen) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: isSmallScreen ? 24 : 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF0B81B),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: isSmallScreen ? 12 : 14,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildVisionCard(
    LanguageProvider languageProvider,
    bool isSmallScreen,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 15 : 20),
        child: Column(
          children: [
            Icon(
              Icons.visibility,
              color: const Color(0xFFF0B81B),
              size: isSmallScreen ? 30 : 40,
            ),
            SizedBox(height: isSmallScreen ? 10 : 15),
            Text(
              languageProvider.vision,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: isSmallScreen ? 18 : 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF0B81B),
              ),
            ),
            SizedBox(height: isSmallScreen ? 8 : 10),
            Text(
              languageProvider.isArabic
                  ? 'أن نكون من أبرز الشركات في مجال المقاولات من خلال التطوير المستمر لخدماتنا وإضافة قيمة للعملاء بالالتزام وثقة في العمل'
                  : 'To be one of the leading companies in contracting through continuous development of our services and adding value to customers with commitment and trust in work',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: isSmallScreen ? 13 : 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionCard(
    LanguageProvider languageProvider,
    bool isSmallScreen,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 15 : 20),
        child: Column(
          children: [
            Icon(
              Icons.flag,
              color: const Color(0xFFF0B81B),
              size: isSmallScreen ? 30 : 40,
            ),
            SizedBox(height: isSmallScreen ? 10 : 15),
            Text(
              languageProvider.mission,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: isSmallScreen ? 18 : 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF0B81B),
              ),
            ),
            SizedBox(height: isSmallScreen ? 8 : 10),
            Text(
              languageProvider.isArabic
                  ? 'أن نكون الشركة الأولى لعملائنا، المزود المثالي الذي يوفر حلول شاملة في المجالات الهندسية والإنشائية'
                  : 'To be the first choice company for our customers, the ideal provider offering comprehensive solutions in engineering and construction fields',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: isSmallScreen ? 13 : 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValuesCard(
    LanguageProvider languageProvider,
    bool isSmallScreen,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 15 : 20),
        child: Column(
          children: [
            Icon(
              Icons.star,
              color: const Color(0xFFF0B81B),
              size: isSmallScreen ? 30 : 40,
            ),
            SizedBox(height: isSmallScreen ? 10 : 15),
            Text(
              languageProvider.values,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: isSmallScreen ? 18 : 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF0B81B),
              ),
            ),
            SizedBox(height: isSmallScreen ? 8 : 10),
            Text(
              languageProvider.isArabic
                  ? 'الجودة الفائقة، الالتزام بالتسليم في الوقت المحدد، الشفافية والوضوح، رضا العملاء'
                  : 'High quality, commitment to timely delivery, transparency and clarity, customer satisfaction',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: isSmallScreen ? 13 : 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
