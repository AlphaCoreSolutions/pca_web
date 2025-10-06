import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class CeoMessageSection extends StatelessWidget {
  const CeoMessageSection({super.key});

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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.white],
        ),
      ),
      child: isSmallScreen
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // CEO Image/Icon - Mobile Layout
                Container(
                  height: isSmallScreen ? 200 : 250,
                  width: isSmallScreen ? 200 : 250,
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.person,
                    size: isSmallScreen ? 70 : 80,
                    color: const Color(0xFFF0B81B),
                  ),
                ),

                SizedBox(height: isSmallScreen ? 30 : 40),

                // CEO Message - Mobile Layout
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageProvider.isArabic
                          ? 'رسالة الرئيس التنفيذي'
                          : 'CEO Message',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: isSmallScreen
                            ? 24
                            : isMediumScreen
                            ? 28
                            : 32,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF0B81B),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: isSmallScreen ? 15 : 20),

                    Center(
                      child: Container(
                        width: isSmallScreen ? 80 : 100,
                        height: 4,
                        color: const Color(0xFFF0B81B),
                      ),
                    ),

                    SizedBox(height: isSmallScreen ? 20 : 30),

                    Text(
                      languageProvider.isArabic
                          ? 'مرحباً بكم في شركة قوة البنية العربية للمقاولات. يسعدني أن أرحب بكم في واحدة من أبرز شركات المقاولات في المملكة العربية السعودية. نحن في شركة قوة البنية ملتزمون بالجودة في موظفينا وخدماتنا. نعمل بجد كل يوم لكسب ثقة وولاء عملائنا.'
                          : 'Welcome to Power Construction Arabia Contracting Company. I am delighted to welcome you to one of the leading contracting companies in Saudi Arabia. At Power Construction, we are committed to quality in our employees and services. We work hard every day to earn the trust and loyalty of our clients.',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: isSmallScreen ? 14 : 16,
                        color: Colors.grey[800],
                        height: 1.8,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: isSmallScreen ? 15 : 20),

                    Text(
                      languageProvider.isArabic
                          ? 'نسعى إلى تحقيق الأفضل من خلال قيمنا والتزامنا بالتصرف بشكل أخلاقي في كل ما نقوم به بدون استثناء. نعتقد أننا نضيف قيمة إلى كل مشروع من خلال سنوات خبرتنا ومشاركتنا في المشاريع المختلفة.'
                          : 'We strive to achieve the best through our values and our commitment to ethical behavior in everything we do without exception. We believe we add value to every project through our years of experience and participation in various projects.',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: isSmallScreen ? 14 : 16,
                        color: Colors.grey[800],
                        height: 1.8,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: isSmallScreen ? 20 : 30),

                    Center(
                      child: Column(
                        children: [
                          Text(
                            languageProvider.isArabic
                                ? 'الرئيس التنفيذي'
                                : 'Chief Executive Officer',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: isSmallScreen ? 16 : 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFF0B81B),
                            ),
                          ),

                          Text(
                            'Power Construction Arabia Contracting Co',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: isSmallScreen ? 14 : 16,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CEO Image/Icon - Desktop/Tablet Layout
                Expanded(
                  flex: 1,
                  child: Container(
                    height: isMediumScreen ? 250 : 300,
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.person,
                      size: isMediumScreen ? 80 : 100,
                      color: const Color(0xFFF0B81B),
                    ),
                  ),
                ),

                SizedBox(width: isMediumScreen ? 30 : 40),

                // CEO Message - Desktop/Tablet Layout
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        languageProvider.isArabic
                            ? 'رسالة الرئيس التنفيذي'
                            : 'CEO Message',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: isMediumScreen ? 28 : 32,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFF0B81B),
                        ),
                      ),

                      SizedBox(height: isMediumScreen ? 15 : 20),

                      Container(
                        width: isMediumScreen ? 80 : 100,
                        height: 4,
                        color: const Color(0xFFF0B81B),
                      ),

                      SizedBox(height: isMediumScreen ? 25 : 30),

                      Text(
                        languageProvider.isArabic
                            ? 'مرحباً بكم في شركة قوة البنية العربية للمقاولات. يسعدني أن أرحب بكم في واحدة من أبرز شركات المقاولات في المملكة العربية السعودية. نحن في شركة قوة البنية ملتزمون بالجودة في موظفينا وخدماتنا. نعمل بجد كل يوم لكسب ثقة وولاء عملائنا.'
                            : 'Welcome to Power Construction Arabia Contracting Company. I am delighted to welcome you to one of the leading contracting companies in Saudi Arabia. At Power Construction, we are committed to quality in our employees and services. We work hard every day to earn the trust and loyalty of our clients.',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: isMediumScreen ? 15 : 16,
                          color: Colors.grey[800],
                          height: 1.8,
                        ),
                        textAlign: TextAlign.start,
                      ),

                      SizedBox(height: isMediumScreen ? 15 : 20),

                      Text(
                        languageProvider.isArabic
                            ? 'نسعى إلى تحقيق الأفضل من خلال قيمنا والتزامنا بالتصرف بشكل أخلاقي في كل ما نقوم به بدون استثناء. نعتقد أننا نضيف قيمة إلى كل مشروع من خلال سنوات خبرتنا ومشاركتنا في المشاريع المختلفة.'
                            : 'We strive to achieve the best through our values and our commitment to ethical behavior in everything we do without exception. We believe we add value to every project through our years of experience and participation in various projects.',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: isMediumScreen ? 15 : 16,
                          color: Colors.grey[800],
                          height: 1.8,
                        ),
                        textAlign: TextAlign.start,
                      ),

                      SizedBox(height: isMediumScreen ? 25 : 30),

                      Text(
                        languageProvider.isArabic
                            ? 'الرئيس التنفيذي'
                            : 'Chief Executive Officer',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: isMediumScreen ? 17 : 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFF0B81B),
                        ),
                      ),

                      Text(
                        'Power Construction Arabia Contracting Co',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: isMediumScreen ? 15 : 16,
                          color: Colors.grey[600],
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
