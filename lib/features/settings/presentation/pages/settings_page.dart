import 'package:flutter/material.dart';
import 'package:tornet_task/core/theme/theme_exports.dart';
import 'package:tornet_task/core/constants/navbar_style_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Future<BottomNavStyle> _navStyle;
  late Future<ElegantNavBarStyle> _elegantStyle;
  late Future<StylishNavBarStyle> _stylishStyle;

  @override
  void initState() {
    super.initState();
    _navStyle = NavBarStyleProvider.getNavStyle();
    _elegantStyle = NavBarStyleProvider.getElegantStyle();
    _stylishStyle = NavBarStyleProvider.getStylishStyle();
  }

  void _updateNavBar() {
    setState(() {
      _navStyle = NavBarStyleProvider.getNavStyle();
      _elegantStyle = NavBarStyleProvider.getElegantStyle();
      _stylishStyle = NavBarStyleProvider.getStylishStyle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Appearance Section
          SizedBox(
            height: 24,
            child: Text(
              'Appearance',
              style: AppTextStyles.headlineSmall,
            ),
          ),
          const SizedBox(height: 12),

          // Bottom Navigation Bar Style
          FutureBuilder<BottomNavStyle>(
            future: _navStyle,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final style = snapshot.data ?? BottomNavStyle.elegant;

              return Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bottom Navigation Style',
                        style: AppTextStyles.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: BottomNavStyle.values.map((s) {
                          return ChoiceChip(
                            label: Text(s == BottomNavStyle.elegant
                                ? 'Elegant NavBar'
                                : 'Stylish NavBar'),
                            selected: style == s,
                            onSelected: (selected) async {
                              if (selected) {
                                await NavBarStyleProvider.setNavStyle(s);
                                _updateNavBar();
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Elegant NavBar Styles
          FutureBuilder<BottomNavStyle>(
            future: _navStyle,
            builder: (context, snapshot) {
              if (snapshot.data != BottomNavStyle.elegant) {
                return const SizedBox.shrink();
              }

              return FutureBuilder<ElegantNavBarStyle>(
                future: _elegantStyle,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final style = snapshot.data ?? ElegantNavBarStyle.floating;

                  return Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ElegantNavBar Style',
                            style: AppTextStyles.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            children:
                                ElegantNavBarStyle.values.map((s) {
                              return ChoiceChip(
                                label: Text(
                                  s == ElegantNavBarStyle.simple
                                      ? 'Simple'
                                      : s == ElegantNavBarStyle.floating
                                          ? 'Floating'
                                          : 'Image',
                                ),
                                selected: style == s,
                                onSelected: (selected) async {
                                  if (selected) {
                                    await NavBarStyleProvider
                                        .setElegantStyle(s);
                                    _updateNavBar();
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 16),

          // Stylish NavBar Styles
          FutureBuilder<BottomNavStyle>(
            future: _navStyle,
            builder: (context, snapshot) {
              if (snapshot.data != BottomNavStyle.stylish) {
                return const SizedBox.shrink();
              }

              return FutureBuilder<StylishNavBarStyle>(
                future: _stylishStyle,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final style =
                      snapshot.data ?? StylishNavBarStyle.style1;

                  return Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'StylishBottomBar Style',
                            style: AppTextStyles.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            children: StylishNavBarStyle.values
                                .map(
                                  (s) =>
                                      ChoiceChip(
                                        label: Text(
                                            'Style ${s.index + 1}'),
                                        selected: style == s,
                                        onSelected:
                                            (selected) async {
                                          if (selected) {
                                            await NavBarStyleProvider
                                                .setStylishStyle(
                                                    s);
                                            _updateNavBar();
                                          }
                                        },
                                      ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 32),

          // API Information Section
          SizedBox(
            height: 24,
            child: Text(
              'API Information',
              style: AppTextStyles.headlineSmall,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Staging API',
                    style: AppTextStyles.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'https://staging.torliga.com/api/v1',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Production API',
                    style: AppTextStyles.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'https://torliga.com/api/v1',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Info Section
          Card(
            margin: EdgeInsets.zero,
            color: AppColors.surface.withValues(alpha: 0.5),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: AppTextStyles.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '📱 Football Matches App v1.0.1\n'
                    '⚽ Real-time match data and predictions\n'
                    '🎯 Get the latest fixtures and results',
                    style: AppTextStyles.bodySmall,
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
