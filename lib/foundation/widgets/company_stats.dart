import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class CompanyStatsSection extends StatelessWidget {
  const CompanyStatsSection({super.key});

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
            ? 50
            : 60,
        horizontal: isSmallScreen
            ? 20
            : isMediumScreen
            ? 30
            : 40,
      ),
      color: Colors.black,
      child: Column(
        children: [
          Text(
            languageProvider.isArabic
                ? 'الشركة في أرقام'
                : 'Company in Numbers',
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
                ? 'إنجازاتنا تتحدث عن نفسها'
                : 'Our achievements speak for themselves',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: isSmallScreen ? 16 : 18,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(
            height: isSmallScreen
                ? 30
                : isMediumScreen
                ? 40
                : 50,
          ),

          isSmallScreen
              ? Wrap(
                  spacing: 20,
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildStatItem(
                      '3+',
                      languageProvider.experienceYears,
                      Icons.calendar_today,
                      isSmallScreen,
                    ),
                    _buildStatItem(
                      '28',
                      languageProvider.clientsCount,
                      Icons.groups,
                      isSmallScreen,
                    ),
                    _buildStatItem(
                      '10M+',
                      languageProvider.projectsValue,
                      Icons.attach_money,
                      isSmallScreen,
                    ),
                    _buildStatItem(
                      '40+',
                      languageProvider.projectsCount,
                      Icons.construction,
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
                      Icons.calendar_today,
                      isSmallScreen,
                    ),
                    _buildStatItem(
                      '28',
                      languageProvider.clientsCount,
                      Icons.groups,
                      isSmallScreen,
                    ),
                    _buildStatItem(
                      '10M+',
                      languageProvider.projectsValue,
                      Icons.attach_money,
                      isSmallScreen,
                    ),
                    _buildStatItem(
                      '40+',
                      languageProvider.projectsCount,
                      Icons.construction,
                      isSmallScreen,
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String value,
    String label,
    IconData icon,
    bool isSmallScreen,
  ) {
    return Column(
      children: [
        Container(
          width: isSmallScreen ? 60 : 80,
          height: isSmallScreen ? 60 : 80,
          decoration: const BoxDecoration(
            color: Color(0xFFF0B81B),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: isSmallScreen ? 30 : 40, color: Colors.white),
        ),
        SizedBox(height: isSmallScreen ? 15 : 20),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: isSmallScreen ? 30 : 42,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: isSmallScreen ? 8 : 10),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: isSmallScreen ? 14 : 16,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
