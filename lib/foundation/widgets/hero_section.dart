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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 600;
    final isMediumScreen = screenWidth <= 1024;

    return Container(
      height: isSmallScreen
          ? 500
          : isMediumScreen
          ? 550
          : 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.grey[900]!],
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
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen
                    ? 20
                    : isMediumScreen
                    ? 30
                    : 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Company Logo/Name
                  Column(
                    children: [
                      Text(
                        'Power Construction Arabia Contracting Co',
                        style: TextStyle(
                          fontFamily:
                              'Cairo', // ✅ matches pubspec.yaml family name
                          fontWeight: FontWeight.w700,
                          fontSize: isSmallScreen
                              ? 24
                              : isMediumScreen
                              ? 32
                              : 40,
                          color: const Color(0xFFF0B81B),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        languageProvider.companyName,
                        style: TextStyle(
                          fontFamily:
                              'Cairo', // ✅ matches pubspec.yaml family name
                          fontSize: isSmallScreen
                              ? 16
                              : isMediumScreen
                              ? 20
                              : 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  SizedBox(height: isSmallScreen ? 30 : 40),

                  // Main Heading
                  Text(
                    languageProvider.isArabic
                        ? 'رواد في البناء والتطوير منذ 2019'
                        : 'Pioneers in Construction & Development Since 2019',
                    style: TextStyle(
                      fontFamily: 'Cairo', // ✅ matches pubspec.yaml family name
                      fontSize: isSmallScreen
                          ? 28
                          : isMediumScreen
                          ? 38
                          : 48,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: isSmallScreen ? 15 : 20),

                  // Subheading
                  Text(
                    languageProvider.isArabic
                        ? 'شركة سعودية رائدة في مجال المقاولات العامة والكهرباء والميكانيكا والاتصالات'
                        : 'A leading Saudi company in general contracting, electricity, mechanics, and telecommunications',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: isSmallScreen
                          ? 14
                          : isMediumScreen
                          ? 17
                          : 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[300],
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: isSmallScreen ? 30 : 40),

                  // CTA Buttons - Responsive
                  if (isSmallScreen)
                    // Mobile: Stacked buttons
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: onExploreServices,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF0B81B),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              languageProvider.isArabic
                                  ? 'استكشف خدماتنا'
                                  : 'Explore Our Services',
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: onContactUs,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFFF0B81B),
                              side: const BorderSide(color: Color(0xFFF0B81B)),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              languageProvider.isArabic
                                  ? 'اتصل بنا'
                                  : 'Contact Us',
                              style: const TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    // Desktop/Tablet: Side by side buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed:
                              onExploreServices, // This will scroll to services
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF0B81B),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: isMediumScreen ? 30 : 40,
                              vertical: isMediumScreen ? 16 : 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            languageProvider.isArabic
                                ? 'استكشف خدماتنا'
                                : 'Explore Our Services',
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
                            padding: EdgeInsets.symmetric(
                              horizontal: isMediumScreen ? 30 : 40,
                              vertical: isMediumScreen ? 16 : 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            languageProvider.isArabic
                                ? 'اتصل بنا'
                                : 'Contact Us',
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
