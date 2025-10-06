import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class Header extends StatelessWidget {
  final VoidCallback? onAboutUs;
  final VoidCallback? onServices;
  final VoidCallback? onProjects;
  final VoidCallback? onContact;

  const Header({
    super.key,
    this.onAboutUs,
    this.onServices,
    this.onProjects,
    this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          Container(
            width: 54,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Image.asset(
                'assets/images/pca_logo.jpg', // ضع مسار الصورة الصحيح هنا
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 15),

          // Company Name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Power Construction Arabia Contracting Co',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: Color(0xFFF0B81B),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                languageProvider.companyName,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  color: Colors.white,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          const Spacer(),

          // Navigation menu - desktop
          if (MediaQuery.of(context).size.width > 768)
            Row(
              children: [
                _buildNavItem(context, languageProvider.aboutUs, onAboutUs),
                const SizedBox(width: 30),
                _buildNavItem(context, languageProvider.services, onServices),
                const SizedBox(width: 30),
                _buildNavItem(context, languageProvider.projects, onProjects),
                const SizedBox(width: 30),
                _buildNavItem(context, languageProvider.contact, onContact),
              ],
            ),

          // Language Switch
          IconButton(
            onPressed: () {
              languageProvider.toggleLanguage();
            },
            icon: const Icon(
              Icons.language,
              color: Color(0xFFF0B81B),
            ),
            tooltip: languageProvider.isArabic
                ? 'Switch to English'
                : 'التغيير إلى العربية',
          ),

          // Mobile menu button
          if (MediaQuery.of(context).size.width <= 768)
            IconButton(
              onPressed: () {
                _showMobileMenu(context, languageProvider);
              },
              icon: const Icon(
                Icons.menu,
                color: Color(0xFFF0B81B),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String text, VoidCallback? onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.transparent,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Cairo',
              color: Color(0xFFF0B81B),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context, LanguageProvider languageProvider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMobileMenuItem(
              context,
              languageProvider.aboutUs,
              Icons.info,
              onAboutUs,
            ),
            _buildMobileMenuItem(
              context,
              languageProvider.services,
              Icons.construction,
              onServices,
            ),
            _buildMobileMenuItem(
              context,
              languageProvider.projects,
              Icons.work,
              onProjects,
            ),
            _buildMobileMenuItem(
              context,
              languageProvider.contact,
              Icons.contact_page,
              onContact,
            ),
            const SizedBox(height: 20),
            Divider(color: Colors.grey[700]),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.language, color: Color(0xFFF0B81B)),
              title: Text(
                languageProvider.isArabic
                    ? 'Switch to English'
                    : 'التغيير إلى العربية',
                style: const TextStyle(
                  fontFamily: 'Cairo', 
                  color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                languageProvider.toggleLanguage();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMenuItem(
      BuildContext context, String text, IconData icon, VoidCallback? onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFF0B81B)),
      title: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Cairo', 
          color: Colors.white),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap?.call();
      },
    );
  }
}
