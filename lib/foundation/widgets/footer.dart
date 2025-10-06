import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/language_provider.dart';

class Footer extends StatelessWidget {
  final VoidCallback? onAboutUs;
  final VoidCallback? onServices;
  final VoidCallback? onProjects;
  final VoidCallback? onContact;

  const Footer({
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

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 30 : 40,
        horizontal: isSmallScreen
            ? 20
            : isMediumScreen
            ? 30
            : 40,
      ),
      color: Colors.black,
      child: Column(
        children: [
          isSmallScreen
              ? Column(
                  children: [
                    // Company Info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'PCA',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF0B81B),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          languageProvider.companyName,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          languageProvider.companyFounded,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          languageProvider.companyCR,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Quick Links
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          languageProvider.isArabic
                              ? 'روابط سريعة'
                              : 'Quick Links',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Wrap(
                          spacing: 20,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: [
                            _buildFooterLink(
                              languageProvider.aboutUs,
                              isSmallScreen,
                              onAboutUs,
                            ),
                            _buildFooterLink(
                              languageProvider.services,
                              isSmallScreen,
                              onServices,
                            ),
                            _buildFooterLink(
                              languageProvider.projects,
                              isSmallScreen,
                              onProjects,
                            ),
                            _buildFooterLink(
                              languageProvider.contact,
                              isSmallScreen,
                              onContact,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Contact Info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          languageProvider.isArabic
                              ? 'معلومات الاتصال'
                              : 'Contact Info',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildFooterContact(
                          Icons.phone,
                          '+966 53 239 2878',
                          isSmallScreen,
                        ),
                        _buildFooterContact(
                          Icons.email,
                          'info@powercac.com',
                          isSmallScreen,
                        ),
                        _buildFooterContact(
                          Icons.location_on,
                          languageProvider.isArabic
                              ? 'الرياض، السعودية'
                              : 'Riyadh, KSA',
                          isSmallScreen,
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company Info
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'PCA',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF0B81B),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            languageProvider.companyName,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            languageProvider.companyFounded,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            languageProvider.companyCR,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Quick Links
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            languageProvider.isArabic
                                ? 'روابط سريعة'
                                : 'Quick Links',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildFooterLink(
                            languageProvider.aboutUs,
                            isSmallScreen,
                            onAboutUs,
                          ),
                          _buildFooterLink(
                            languageProvider.services,
                            isSmallScreen,
                            onServices,
                          ),
                          _buildFooterLink(
                            languageProvider.projects,
                            isSmallScreen,
                            onProjects,
                          ),
                          _buildFooterLink(
                            languageProvider.contact,
                            isSmallScreen,
                            onContact,
                          ),
                        ],
                      ),
                    ),

                    // Contact Info
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            languageProvider.isArabic
                                ? 'معلومات الاتصال'
                                : 'Contact Info',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildFooterContact(
                            Icons.phone,
                            '+966 53 239 2878',
                            isSmallScreen,
                          ),
                          _buildFooterContact(
                            Icons.email,
                            'info@powercac.com',
                            isSmallScreen,
                          ),
                          _buildFooterContact(
                            Icons.location_on,
                            languageProvider.isArabic
                                ? 'الرياض، السعودية'
                                : 'Riyadh, KSA',
                            isSmallScreen,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

          SizedBox(height: isSmallScreen ? 20 : 30),

          const Divider(color: Colors.white24),
          SizedBox(height: isSmallScreen ? 15 : 20),

          Text(
            languageProvider.isArabic
                ? '© ٢٠٢٤ شركة قوة البنية العربية للمقاولات. جميع الحقوق محفوظة.'
                : '© 2024 Power Construction Arabia Contracting Company. All rights reserved.',
            style: TextStyle(
              color: Colors.white54,
              fontSize: isSmallScreen ? 11 : 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Helper method to launch phone call
  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  // Helper method to launch email
  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Widget _buildFooterLink(
    String text,
    bool isSmallScreen,
    VoidCallback? onTap,
  ) {
    return _FooterLink(text: text, isSmallScreen: isSmallScreen, onTap: onTap);
  }

  Widget _buildFooterContact(IconData icon, String text, bool isSmallScreen) {
    // Determine if this is a clickable contact item
    bool isPhone = icon == Icons.phone;
    bool isEmail = icon == Icons.email;
    bool isClickable = isPhone || isEmail;

    Widget contactWidget = Row(
      mainAxisAlignment: isSmallScreen
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: isSmallScreen ? 14 : 16,
          color: const Color(0xFFF0B81B),
        ),
        SizedBox(width: isSmallScreen ? 6 : 8),
        Text(
          text,
          style: TextStyle(
            color: Colors.white70,
            fontSize: isSmallScreen ? 13 : 14,
            decoration: isClickable ? TextDecoration.underline : null,
            decorationColor: isClickable ? Colors.white70 : null,
          ),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.only(bottom: isSmallScreen ? 6 : 8),
      child: isClickable
          ? MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  if (isPhone) {
                    _launchPhone(text);
                  } else if (isEmail) {
                    _launchEmail(text);
                  }
                },
                child: contactWidget,
              ),
            )
          : contactWidget,
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String text;
  final bool isSmallScreen;
  final VoidCallback? onTap;

  const _FooterLink({
    required this.text,
    required this.isSmallScreen,
    this.onTap,
  });

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.isSmallScreen ? 3 : 5),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: Text(
              widget.text,
              style: TextStyle(
                color: _isHovered ? const Color(0xFFF0B81B) : Colors.white70,
                fontSize: widget.isSmallScreen ? 13 : 14,
                fontWeight: _isHovered ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
