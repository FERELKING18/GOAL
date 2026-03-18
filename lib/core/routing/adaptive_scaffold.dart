import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:elegant_nav_bar/elegant_nav_bar.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'app_router.dart';
import '../../core/constants/navbar_style_provider.dart';

class AdaptiveScaffold extends StatefulWidget {
  final Widget child;
  final String currentPath;

  const AdaptiveScaffold({
    super.key,
    required this.child,
    required this.currentPath,
  });

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  int _selectedIndex = 0;
  late Future<BottomNavStyle> _navStyleFuture;
  late Future<ElegantNavBarStyle> _elegantStyleFuture;
  late Future<StylishNavBarStyle> _stylishStyleFuture;

  @override
  void initState() {
    super.initState();
    _updateSelectedIndex();
    _navStyleFuture = NavBarStyleProvider.getNavStyle();
    _elegantStyleFuture = NavBarStyleProvider.getElegantStyle();
    _stylishStyleFuture = NavBarStyleProvider.getStylishStyle();
  }

  void _updateSelectedIndex() {
    if (widget.currentPath.contains('settings')) {
      _selectedIndex = 2;
    } else if (widget.currentPath.contains('matches')) {
      _selectedIndex = 0;
    }
  }

  void _updateNavBar() {
    setState(() {
      _navStyleFuture = NavBarStyleProvider.getNavStyle();
      _elegantStyleFuture = NavBarStyleProvider.getElegantStyle();
      _stylishStyleFuture = NavBarStyleProvider.getStylishStyle();
    });
  }

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        AppRouter.goToMatches();
        break;
      case 1:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Favorites coming soon')),
        );
        break;
      case 2:
        AppRouter.goToSettings();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child
          .animate()
          .fadeIn(duration: 300.ms)
          .slideY(begin: 0.1, duration: 300.ms, curve: Curves.easeOut),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return FutureBuilder<BottomNavStyle>(
      future: _navStyleFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        final navStyle = snapshot.data ?? BottomNavStyle.elegant;

        if (navStyle == BottomNavStyle.elegant) {
          return _buildElegantNavBar();
        } else {
          return _buildStylishNavBar();
        }
      },
    );
  }

  Widget _buildElegantNavBar() {
    return FutureBuilder<ElegantNavBarStyle>(
      future: _elegantStyleFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        final style = snapshot.data ?? ElegantNavBarStyle.floating;

        final items = [
          ElegantNavBarItem(icon: Icons.sports_soccer, title: 'Matches'),
          ElegantNavBarItem(icon: Icons.favorite, title: 'Favorites'),
          ElegantNavBarItem(icon: Icons.settings, title: 'Settings'),
        ];

        // Floating style (default)
        if (style == ElegantNavBarStyle.floating) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: ElegantNavBar(
              onChanged: _onNavTap,
              currentIndex: _selectedIndex,
              items: items,
              navBarStyle: NavBarStyle.floating,
              curve: Curves.easeInOut,
            ),
          );
        }
        // Simple style
        else if (style == ElegantNavBarStyle.simple) {
          return ElegantNavBar(
            onChanged: _onNavTap,
            currentIndex: _selectedIndex,
            items: items,
            navBarStyle: NavBarStyle.simple,
            curve: Curves.easeInOut,
          );
        }
        // Image style
        else {
          return ElegantNavBar(
            onChanged: _onNavTap,
            currentIndex: _selectedIndex,
            items: items,
            navBarStyle: NavBarStyle.image,
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  Widget _buildStylishNavBar() {
    return FutureBuilder<StylishNavBarStyle>(
      future: _stylishStyleFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        final style = snapshot.data ?? StylishNavBarStyle.style1;

        final items = [
          BottomBarItem(icon: Icons.sports_soccer, title: 'Matches'),
          BottomBarItem(icon: Icons.favorite, title: 'Favorites'),
          BottomBarItem(icon: Icons.settings, title: 'Settings'),
        ];

        return StylishBottomBar(
          items: items,
          iconSize: 32,
          barAnimationStyle: BarAnimationStyle.vertical,
          fabLocation: StylishBarFabLocation.end,
          hasNotch: false,
          currentIndex: _selectedIndex,
          onTap: _onNavTap,
          option: _getStylishOption(style),
        );
      },
    );
  }

  Option _getStylishOption(StylishNavBarStyle style) {
    switch (style) {
      case StylishNavBarStyle.style1:
        return Option(
          backgroundColor: Colors.white,
        );
      case StylishNavBarStyle.style2:
        return Option(
          backgroundColor: Colors.black87,
        );
      case StylishNavBarStyle.style3:
        return Option(
          backgroundColor: const Color(0xFF2E3236),
        );
      case StylishNavBarStyle.style4:
        return Option(
          backgroundColor: Colors.deepPurple.shade800,
        );
      case StylishNavBarStyle.style5:
        return Option(
          backgroundColor: Colors.blue.shade900,
        );
      case StylishNavBarStyle.style6:
        return Option(
          backgroundColor: Colors.teal.shade700,
        );
    }
  }
}

// Extension pour mettre à jour depuis SettingsPage
extension AdaptiveScaffoldState on State<AdaptiveScaffold> {
  void updateNavBarStyle() {
    if (mounted && this is _AdaptiveScaffoldState) {
      (this as _AdaptiveScaffoldState)._updateNavBar();
    }
  }
}
