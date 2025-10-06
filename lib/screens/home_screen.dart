import 'package:flutter/material.dart';
import 'package:pca_website/foundation/providers/language_provider.dart';
import 'package:pca_website/foundation/widgets/about_us.dart';
import 'package:pca_website/foundation/widgets/ceo_message.dart';
import 'package:pca_website/foundation/widgets/company_stats.dart';
import 'package:pca_website/foundation/widgets/contact_section.dart';
import 'package:pca_website/foundation/widgets/footer.dart';
import 'package:pca_website/foundation/widgets/header.dart';
import 'package:pca_website/foundation/widgets/hero_section.dart';
import 'package:pca_website/foundation/widgets/projects_section.dart';
import 'package:pca_website/foundation/widgets/services_section.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      body: Directionality(
        textDirection: languageProvider.isArabic
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Header (App Bar)
            SliverAppBar(
              backgroundColor: Colors.black,
              floating: true,
              pinned: true,
              snap: false,
              elevation: 10,
              title: Header(
                onAboutUs: () => _scrollToSection(_aboutKey),
                onServices: () => _scrollToSection(_servicesKey),
                onProjects: () => _scrollToSection(_projectsKey),
                onContact: () => _scrollToSection(_contactKey),
              ),
              expandedHeight: 0,
              toolbarHeight: 80,
            ),

            // Hero Section - UPDATED!
            SliverToBoxAdapter(
              child: HeroSection(
                onExploreServices: () => _scrollToSection(_servicesKey),
                onContactUs: () => _scrollToSection(_contactKey),
              ),
            ),

            // CEO Message Section
            const SliverToBoxAdapter(child: CeoMessageSection()),

            // Company Statistics
            const SliverToBoxAdapter(child: CompanyStatsSection()),

            // About Us Section
            SliverToBoxAdapter(
              child: KeyedSubtree(key: _aboutKey, child: const AboutUs()),
            ),

            // Services Section (خدماتنا)
            SliverToBoxAdapter(
              child: KeyedSubtree(
                key: _servicesKey,
                child: const ServicesSection(),
              ),
            ),

            // Projects Section (اعمالنا)
            SliverToBoxAdapter(
              child: KeyedSubtree(
                key: _projectsKey,
                child: const ProjectsSection(),
              ),
            ),

            // Contact Section
            SliverToBoxAdapter(
              child: KeyedSubtree(
                key: _contactKey,
                child: const ContactSection(),
              ),
            ),

            // Footer
            SliverToBoxAdapter(
              child: Footer(
                onAboutUs: () => _scrollToSection(_aboutKey),
                onServices: () => _scrollToSection(_servicesKey),
                onProjects: () => _scrollToSection(_projectsKey),
                onContact: () => _scrollToSection(_contactKey),
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button for quick contact
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scrollToSection(_contactKey),
        backgroundColor: const Color(0xFFF0B81B),
        foregroundColor: Colors.white,
        child: const Icon(Icons.phone),
      ),
    );
  }
}
