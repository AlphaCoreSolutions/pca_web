import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onExploreServices;
  final VoidCallback onContactUs;

  const HeroSection({
    super.key,
    required this.onExploreServices,
    required this.onContactUs,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    
    return Container(
      height: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.grey[900]!,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background Pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                'assets/images/projects/construction_pattern.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Company Logo/Name
                  Column(
                    children: [
                      const Text(
                          'Power Construction Arabia Contracting Co',
                          style: TextStyle(
                            fontFamily: 'Cairo',   // ✅ matches pubspec.yaml family name
                            fontWeight: FontWeight.w700,
                            fontSize: 40,
                            color: Color(0xFFF0B81B),
                          ),
                        ),
                      Text(
                        languageProvider.companyName,
                        style: const TextStyle(
                          fontFamily: 'Cairo',   // ✅ matches pubspec.yaml family name
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Main Heading
                  Text(
                    languageProvider.isArabic
                        ? 'رواد في البناء والتطوير منذ 2019'
                        : 'Pioneers in Construction & Development Since 2019',
                    style: const TextStyle(
                      fontFamily: 'Cairo',   // ✅ matches pubspec.yaml family name
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Subheading
                  Text(
                    languageProvider.isArabic
                        ? 'شركة سعودية رائدة في مجال المقاولات العامة والكهرباء والميكانيكا والاتصالات'
                        : 'A leading Saudi company in general contracting, electricity, mechanics, and telecommunications',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[300],
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // CTA Buttons - NOW THEY WORK!
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: onExploreServices, // This will scroll to services
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF0B81B),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          languageProvider.isArabic ? 'استكشف خدماتنا' : 'Explore Our Services',
                          style: const TextStyle(
                            fontFamily: 'Cairo', 
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 20),
                      
                      OutlinedButton(
                        onPressed: onContactUs, // This will scroll to contact
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFF0B81B),
                          side: const BorderSide(color: Color(0xFFF0B81B)),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          languageProvider.isArabic ? 'اتصل بنا' : 'Contact Us',
                          style: const TextStyle(
                            fontFamily: 'Cairo', 
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}