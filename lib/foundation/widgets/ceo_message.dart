import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class CeoMessageSection extends StatelessWidget {
  const CeoMessageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white,
          ],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CEO Image/Icon
          Expanded(
            flex: 1,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.person,
                size: 100,
                color:Color(0xFFF0B81B),
              ),
            ),
          ),
          
          const SizedBox(width: 40),
          
          // CEO Message
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageProvider.isArabic ? 'رسالة الرئيس التنفيذي' : 'CEO Message',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFF0B81B),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                Container(
                  width: 100,
                  height: 4,
                  color: const Color(0xFFF0B81B),
                ),
                
                const SizedBox(height: 30),
                
                Text(
                  languageProvider.isArabic
                      ? 'مرحباً بكم في شركة قوة البنية العربية للمقاولات. يسعدني أن أرحب بكم في واحدة من أبرز شركات المقاولات في المملكة العربية السعودية. نحن في شركة قوة البنية ملتزمون بالجودة في موظفينا وخدماتنا. نعمل بجد كل يوم لكسب ثقة وولاء عملائنا.'
                      : 'Welcome to Power Construction Arabia Contracting Company. I am delighted to welcome you to one of the leading contracting companies in Saudi Arabia. At Power Construction, we are committed to quality in our employees and services. We work hard every day to earn the trust and loyalty of our clients.',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    color: Colors.grey[800],
                    height: 1.8,
                  ),
                  textAlign: TextAlign.start,
                ),
                
                const SizedBox(height: 20),
                
                Text(
                  languageProvider.isArabic
                      ? 'نسعى إلى تحقيق الأفضل من خلال قيمنا والتزامنا بالتصرف بشكل أخلاقي في كل ما نقوم به بدون استثناء. نعتقد أننا نضيف قيمة إلى كل مشروع من خلال سنوات خبرتنا ومشاركتنا في المشاريع المختلفة.'
                      : 'We strive to achieve the best through our values and our commitment to ethical behavior in everything we do without exception. We believe we add value to every project through our years of experience and participation in various projects.',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    color: Colors.grey[800],
                    height: 1.8,
                  ),
                  textAlign: TextAlign.start,
                ),
                
                const SizedBox(height: 30),
                
                Text(
                  languageProvider.isArabic ? 'الرئيس التنفيذي' : 'Chief Executive Officer',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF0B81B),
                  ),
                ),
                
                Text(
                  'Power Construction Arabia Contracting Co',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
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