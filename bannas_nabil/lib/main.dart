import 'package:flutter/material.dart';
import 'package:Holy_Bible/verses_data.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:badges/badges.dart' as badges;
import 'custom_drawer.dart';
import 'bible_page.dart';
import 'notebook_page.dart';
import 'questions_page.dart';
import 'settings_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationService notificationService = NotificationService();
  await notificationService.initialize();
  runApp(MyApp(notificationService: notificationService));
}

class MyApp extends StatefulWidget {
  final NotificationService notificationService;

  const MyApp({super.key,  required this.notificationService});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('ar', '');
  bool _isDarkMode = false;
  double _fontSize = 16.0;

  void _setLocale(String languageCode) {
    setState(() {
      _locale = Locale(languageCode, '');
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _setFontSize(double fontSize) {
    setState(() {
      _fontSize = fontSize;
    });
  }

  ThemeData _buildThemeData() {
    final base = _isDarkMode ? ThemeData.dark() : ThemeData.light();
    return base.copyWith(
      primaryColor: const Color(0xff769590),
      hintColor: const Color(0xff769590),
      textTheme: base.textTheme.apply(
        fontFamily: 'YourFontFamily',
        bodyColor: _isDarkMode ? Colors.white70 : Colors.black87,
        displayColor: _isDarkMode ? Colors.white70 : Colors.black87,
      ),
      scaffoldBackgroundColor:
      _isDarkMode ? const Color(0xFF121212) : Colors.white,
      iconTheme: IconThemeData(
        color: _isDarkMode ? const Color(0xff769590) : const Color(0xff769590),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _showDailyVerseNotification(); // استدعاء دالة عرض إشعار الآية اليومية هنا
  }

  void _showDailyVerseNotification() {
    // فرضًا أن لديك قائمة بآيات الكتاب المقدس في verses_data.dart
    final List<String> verses =
    getVerses(); // افترض أن getVerses() تُعيد قائمة بالآيات
    final String dailyVerse = (verses..shuffle()).first; // اختيار آية عشوائية

    widget.notificationService.showNotification(
      'آية اليوم',
      dailyVerse,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'كنز مقدس',
      theme: _buildThemeData(),
      locale: _locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      home: SplashScreen(
        onLocaleChange: _setLocale,
        toggleDarkMode: _toggleDarkMode,
        isDarkMode: _isDarkMode,
        fontSize: _fontSize,
        onFontSizeChanged: _setFontSize,
        notificationService: widget.notificationService,
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final Function(String) onLocaleChange;
  final Function() toggleDarkMode;
  final bool isDarkMode;
  final double fontSize;
  final ValueChanged<double> onFontSizeChanged;
  final NotificationService notificationService;

  const SplashScreen({
    super.key,
    required this.onLocaleChange,
    required this.toggleDarkMode,
    required this.isDarkMode,
    required this.fontSize,
    required this.onFontSizeChanged,
    required this.notificationService,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            onLocaleChange: widget.onLocaleChange,
            toggleDarkMode: widget.toggleDarkMode,
            isDarkMode: widget.isDarkMode,
            fontSize: widget.fontSize,
            onFontSizeChanged: widget.onFontSizeChanged,
            notificationService: widget.notificationService,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/a-heartwarming-illustration-of-a-young-boy-of-12-o-WVM8a_bjRwCVaZqSvEFqUw-I4huwHSgTy2UqKxWpL2BAQ.jpeg',
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function(String) onLocaleChange;
  final Function() toggleDarkMode;
  final bool isDarkMode;
  final double fontSize;
  final ValueChanged<double> onFontSizeChanged;
  final NotificationService notificationService;

  const MyHomePage({
    super.key,
    required this.onLocaleChange,
    required this.toggleDarkMode,
    required this.isDarkMode,
    required this.fontSize,
    required this.onFontSizeChanged,
    required this.notificationService,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _notificationCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor:  Colors.white,
        elevation: 4,
        title: const Text('كنز مقدس'),
        actions: [
          badges.Badge(
            badgeContent: Text(
              '$_notificationCount',
              style: const TextStyle(color: Colors.white),
            ),
            showBadge: _notificationCount > 0,
            child: IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                setState(() {
                  _notificationCount++;
                });
                widget.notificationService.showNotification(
                  'أشكره معايا',
                  'شكرا يارب علي نعمتك',
                );
              },
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(
                      isDarkMode: widget.isDarkMode,
                      fontSize: widget.fontSize,
                      onDarkModeChanged: (value) {
                        setState(() {
                          widget.toggleDarkMode();
                        });
                      },
                      onFontSizeChanged: (value) {
                        widget.onFontSizeChanged(value);
                      },
                      toggleReadingMode: () {
                        return true;
                      },
                      isVerticalMode: true,
                    ),
                  ),
                );
              } else {
                widget.onLocaleChange(value);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'ar',
                  child: Row(
                    children: [
                      Icon(Icons.language),
                      SizedBox(width: 8),
                      Text('العربية'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'en',
                  child: Row(
                    children: [
                      Icon(Icons.language),
                      SizedBox(width: 8),
                      Text('English'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 8),
                      Text('الإعدادات'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/back.jpg'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3), // اللون الذي تريده
              BlendMode.darken, // وضع المزج لدمج اللون مع الصورة
            ),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconButton(
                context,
                'assets/images/bible-svgrepo-com.svg',
                'الكتاب المقدس',
                const BiblePage(),
              ),
              _buildIconButton(
                context,
                'assets/images/question-mark-circle-svgrepo-com.svg',
                'الأسئلة',
                const QuestionsPage(),
              ),
              _buildIconButton(
                context,
                'assets/images/notebook-svgrepo-com.svg',
                'النوتة',
                const NotebookPage(),
              ),
            ],
          ),
        ),
      ),
      drawer: CustomDrawer(), // استخدام CustomDrawer هنا
    );
  }

  Widget _buildIconButton(
      BuildContext context, String assetPath, String label, Widget page) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tooltip(
          message: label,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => page),
                    );
                  },
                  child: SvgPicture.asset(
                    assetPath,
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
