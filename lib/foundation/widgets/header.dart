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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <= 600;
    final isMediumScreen = screenWidth <= 1024;
    final isLargeScreen = screenWidth > 1024;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen
            ? 15
            : isMediumScreen
            ? 20
            : 30,
        vertical: isSmallScreen ? 12 : 15,
      ),
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
            width: isSmallScreen
                ? 45
                : isMediumScreen
                ? 55
                : 60,
            height: isSmallScreen
                ? 40
                : isMediumScreen
                ? 50
                : 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF0B81B).withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/logor6.png',
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),

          SizedBox(
            width: isSmallScreen
                ? 8
                : isMediumScreen
                ? 12
                : 15,
          ),

          // Company Name - Responsive
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isSmallScreen ||
                    screenWidth > 480) // Hide on very small screens
                  Text(
                    'Power Construction Arabia Contracting Co',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: const Color(0xFFF0B81B),
                      fontSize: isSmallScreen
                          ? 10
                          : isMediumScreen
                          ? 11
                          : 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(
                  isSmallScreen ? '' : languageProvider.companyName,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.white,
                    fontSize: isSmallScreen
                        ? 11
                        : isMediumScreen
                        ? 11
                        : 12,
                    fontWeight: isSmallScreen
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Navigation menu - tablet and desktop
          if (isMediumScreen && !isSmallScreen)
            Row(
              children: [
                _buildNavItem(
                  context,
                  languageProvider.aboutUs,
                  onAboutUs,
                  isSmallScreen,
                  isMediumScreen,
                ),
                SizedBox(width: isMediumScreen ? 20 : 30),
                _buildNavItem(
                  context,
                  languageProvider.services,
                  onServices,
                  isSmallScreen,
                  isMediumScreen,
                ),
                SizedBox(width: isMediumScreen ? 20 : 30),
                _buildNavItem(
                  context,
                  languageProvider.projects,
                  onProjects,
                  isSmallScreen,
                  isMediumScreen,
                ),
                SizedBox(width: isMediumScreen ? 20 : 30),
                _buildNavItem(
                  context,
                  languageProvider.contact,
                  onContact,
                  isSmallScreen,
                  isMediumScreen,
                ),
              ],
            ),

          // Desktop navigation
          if (isLargeScreen)
            Row(
              children: [
                _buildNavItem(
                  context,
                  languageProvider.aboutUs,
                  onAboutUs,
                  isSmallScreen,
                  isMediumScreen,
                ),
                const SizedBox(width: 30),
                _buildNavItem(
                  context,
                  languageProvider.services,
                  onServices,
                  isSmallScreen,
                  isMediumScreen,
                ),
                const SizedBox(width: 30),
                _buildNavItem(
                  context,
                  languageProvider.projects,
                  onProjects,
                  isSmallScreen,
                  isMediumScreen,
                ),
                const SizedBox(width: 30),
                _buildNavItem(
                  context,
                  languageProvider.contact,
                  onContact,
                  isSmallScreen,
                  isMediumScreen,
                ),
              ],
            ),

          // Language Switch
          IconButton(
            onPressed: () {
              languageProvider.toggleLanguage();
            },
            icon: Icon(
              Icons.language,
              color: const Color(0xFFF0B81B),
              size: isSmallScreen ? 20 : 24,
            ),
            tooltip: languageProvider.isArabic
                ? 'Switch to English'
                : 'التغيير إلى العربية',
            padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
          ),

          // Mobile menu button
          if (isSmallScreen)
            IconButton(
              onPressed: () {
                _showMobileMenu(context, languageProvider);
              },
              icon: Icon(
                Icons.menu,
                color: const Color(0xFFF0B81B),
                size: isSmallScreen ? 22 : 24,
              ),
              padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String text,
    VoidCallback? onTap,
    bool isSmallScreen,
    bool isMediumScreen,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMediumScreen ? 12 : 15,
            vertical: isMediumScreen ? 6 : 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.transparent,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Cairo',
              color: const Color(0xFFF0B81B),
              fontSize: isMediumScreen ? 14 : 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(
    BuildContext context,
    LanguageProvider languageProvider,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth <= 600;
    final isVerySmallScreen = screenHeight <= 600; // For very small screens

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: isVerySmallScreen
            ? screenHeight *
                  0.5 // 50% for very small screens
            : screenHeight * 0.6, // 60% for normal screens
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.only(
          left: isSmallScreen ? 12 : 20,
          right: isSmallScreen ? 12 : 20,
          top: 8,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Navigation items in a compact grid layout for very small screens
            if (isVerySmallScreen)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  _buildCompactNavButton(
                    context,
                    languageProvider.aboutUs,
                    Icons.info,
                    onAboutUs,
                  ),
                  _buildCompactNavButton(
                    context,
                    languageProvider.services,
                    Icons.construction,
                    onServices,
                  ),
                  _buildCompactNavButton(
                    context,
                    languageProvider.projects,
                    Icons.work,
                    onProjects,
                  ),
                  _buildCompactNavButton(
                    context,
                    languageProvider.contact,
                    Icons.contact_page,
                    onContact,
                  ),
                ],
              )
            else
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMobileMenuItem(
                    context,
                    languageProvider.aboutUs,
                    Icons.info,
                    onAboutUs,
                    isSmallScreen,
                  ),
                  _buildMobileMenuItem(
                    context,
                    languageProvider.services,
                    Icons.construction,
                    onServices,
                    isSmallScreen,
                  ),
                  _buildMobileMenuItem(
                    context,
                    languageProvider.projects,
                    Icons.work,
                    onProjects,
                    isSmallScreen,
                  ),
                  _buildMobileMenuItem(
                    context,
                    languageProvider.contact,
                    Icons.contact_page,
                    onContact,
                    isSmallScreen,
                  ),
                ],
              ),

            SizedBox(height: isVerySmallScreen ? 8 : 10),
            Divider(color: Colors.grey[700], thickness: 1),
            SizedBox(height: isVerySmallScreen ? 6 : 8),

            // Language switch as compact button
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                languageProvider.toggleLanguage();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: isVerySmallScreen ? 8 : 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.language,
                      color: const Color(0xFFF0B81B),
                      size: isVerySmallScreen ? 18 : 20,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        languageProvider.isArabic ? 'English' : 'العربية',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.white,
                          fontSize: isVerySmallScreen ? 13 : 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMenuItem(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback? onTap,
    bool isSmallScreen,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 4 : 6),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFFF0B81B),
          size: isSmallScreen ? 20 : 22,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontFamily: 'Cairo',
            color: Colors.white,
            fontSize: isSmallScreen ? 14 : 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 8 : 12,
          vertical: isSmallScreen ? 2 : 4,
        ),
        dense: true,
        visualDensity: VisualDensity.compact,
        onTap: () {
          Navigator.pop(context);
          onTap?.call();
        },
      ),
    );
  }

  Widget _buildCompactNavButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback? onTap,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap?.call();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4, // 40% of screen width
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFF0B81B).withOpacity(0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFFF0B81B), size: 18),
            const SizedBox(height: 4),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Cairo',
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
