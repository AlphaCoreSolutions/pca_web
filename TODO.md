# UI Improvements Plan

## Information Gathered
- **Project Structure**: Flutter web app for PCA (Power Construction Arabia) with responsive design, RTL support, and multiple sections (Hero, Services, Projects, About, Contact).
- **Current UI Components**: Header with navigation, Hero section with CTA buttons, Services section with cards, Projects section, About Us, Contact, Footer.
- **Existing Features**: Language toggle, scroll-to-section navigation, floating particles animation, theme provider (not implemented), animated progress indicator, elaborate splash screen.
- **Responsive Design**: Uses breakpoints for small (≤600px), medium (≤1024px), large (>1024px) screens.
- **State Management**: Provider for language and theme.
- **Styling**: Uses Cairo font, yellow accent color (#F0B81B), black/white themes.

## Plan
1. **Remove Splash Screen**: Replace elaborate splash screen with direct home screen loading and add progress indicators to home screen.
2. **Add Theme Toggle**: Implement dark/light theme toggle in header using existing ThemeProvider.
3. **Add Fade-in Animations**: Implement scroll-triggered fade-in animations for sections using VisibilityDetector.
4. **Enhance Button Interactions**: Add hover effects and press animations to CTA buttons and navigation items.
5. **Improve Hero Section**: Add parallax scrolling effect and enhance visual effects.
6. **Add Micro-interactions**: Implement pulse animation for FAB and loading states.
7. **Enhance Accessibility**: Add semantic labels, tooltips, and better focus management.
8. **Optimize Cards**: Add hover effects and improved shadows to service/project cards.

## Dependent Files to Edit
- `lib/main.dart`: Change home from SplashScreen to HomeScreen.
- `lib/screens/home_screen.dart`: Add loading progress overlay and integrate theme provider.
- `lib/foundation/widgets/header.dart`: Add theme toggle button.
- `lib/foundation/widgets/hero_section.dart`: Add parallax and enhanced effects.
- `lib/foundation/widgets/services_section.dart`: Add hover effects to cards.
- New file: `lib/foundation/widgets/fade_in_animation.dart`: Create reusable fade-in widget.

## Followup Steps
- Install `visibility_detector` package for scroll animations.
- Test responsiveness and animations on different screen sizes.
- Verify accessibility with screen readers.
- Performance testing for animations.
- Remove unused splash_screen.dart if no longer needed.
