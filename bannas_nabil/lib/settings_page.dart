import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatelessWidget {
  final bool isDarkMode;
  final double fontSize;
  final ValueChanged<bool> onDarkModeChanged;
  final ValueChanged<double> onFontSizeChanged;

  const SettingsPage({
    super.key,
    required this.isDarkMode,
    required this.fontSize,
    required this.onDarkModeChanged,
    required this.onFontSizeChanged,
    required Function() toggleReadingMode,
    required bool isVerticalMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('الوضع الليلي'),
              value: isDarkMode,
              onChanged: onDarkModeChanged,
            ),
            ListTile(
              title: const Text('حجم الخط'),
              subtitle: Slider(
                value: fontSize,
                min: 10,
                max: 30,
                divisions: 20,
                label: fontSize.toString(),
                onChanged: onFontSizeChanged,
              ),
            ),
            ListTile(
              title: const Text('مشاركة التطبيق'),
              leading: const Icon(Icons.share),
              onTap: () {
                Share.share('جرب تطبيق كتابي المقدس: [رابط التطبيق هنا]');
              },
            ),
          ],
        ),
      ),
    );
  }
}
