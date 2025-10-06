import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class CompanyStatsSection extends StatelessWidget {
  const CompanyStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      color: Colors.black,
      child: Column(
        children: [
          Text(
            languageProvider.isArabic ? 'الشركة في أرقام' : 'Company in Numbers',
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
                ? 'إنجازاتنا تتحدث عن نفسها'
                : 'Our achievements speak for themselves',
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          
          const SizedBox(height: 50),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('3+', languageProvider.experienceYears, Icons.calendar_today),
              _buildStatItem('28', languageProvider.clientsCount, Icons.groups),
              _buildStatItem('10M+', languageProvider.projectsValue, Icons.attach_money),
              _buildStatItem('40+', languageProvider.projectsCount, Icons.construction),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color:Color(0xFFF0B81B),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 40, color: Colors.white),
        ),
        const SizedBox(height: 20),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}