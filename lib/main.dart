import 'package:bypass/ui/views/%20screens/generate_password.dart';
import 'package:bypass/ui/views/%20screens/home_screen.dart';
import 'package:bypass/ui/views/%20screens/items_screen.dart';
import 'package:bypass/ui/views/%20screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'ui/controllers/password_controller.dart';
import 'ui/views/widgets/bottom_navigation_bar.dart';
import 'ui/themes/app_theme.dart';


void main()async {

  WidgetsFlutterBinding.ensureInitialized();

  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US',
      supportedLocales: ['en_US', 'fr','es','ar','ru']);

  runApp(LocalizedApp(delegate,   ChangeNotifierProvider(
    create: (context) => PasswordController(),
    child: const MyApp(),
  ) ,),);

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    var localizationDelegate = LocalizedApp.of(context).delegate;

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Password Manager',
      theme: AppTheme.lightTheme,

      localizationsDelegates: [
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        localizationDelegate
      ],
      supportedLocales: localizationDelegate.supportedLocales,
      locale: localizationDelegate.currentLocale,

      home: const MainScreen(),
    );
  }
}
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const ItemsScreen(),
    const GeneratePasswordScreen(),
    const ProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          }
      ),

    );
  }
}