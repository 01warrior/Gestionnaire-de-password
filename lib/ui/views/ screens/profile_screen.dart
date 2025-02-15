import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../themes/app_theme.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter/cupertino.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';
  bool _isDarkMode = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:  Text(translate('profile')),),
      body:  FadeInUp(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.settings,
                    size: 80,
                    color: Colors.grey[600],
                  ),
                ),
                const  SizedBox(height: 20),
                Center(
                  child: Text(translate('settings'),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(translate('account'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 15),
                      _buildSettingsTile(
                        title: translate('notifications'),
                        leadingIcon: Icons.notifications,
                        trailing: Switch(
                          value: _notificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                          activeColor: AppTheme.primaryColor,
                        ),

                      ),

                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),

                      _buildSettingsTile(
                        title: translate('language'),
                        leadingIcon: Icons.language,
                        trailing: ElevatedButton(onPressed: () {
                          _onActionSheetPress(context);
                        }, child: Text(_selectedLanguage))
                      ),

                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      _buildSettingsTile(
                        title: translate('about'),
                        leadingIcon: Icons.info,
                        onTap: () => _showAboutDialog(context),

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildSettingsTile({
    required String title,
    required IconData leadingIcon,
    Widget? trailing,
    VoidCallback? onTap,

  }){
    return ListTile(
      onTap: onTap,
      leading: Icon(leadingIcon,
          color: Colors.grey[600]
      ),
      title: Text(title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),),
      trailing: trailing,

    );
  }
  void showDemoActionSheet(
      {required BuildContext context, required Widget child}) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) => child).then((String? value) {
      if (value != null) changeLocale(context, value);
    });
  }

  void _onActionSheetPress(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final locale = Localizations.localeOf(context);
        return ZoomIn(
          child: AlertDialog(
            title:  Text(translate('language.selection.title')),
            content:  Directionality(
              textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // <-- Ajout de mainAxisSize
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(translate('language.selection.message'),textAlign: TextAlign.start,),
                    SizedBox(height: 20,),
                    TextButton(
                      child:  Text(translate('language.name.en_US'),textAlign: TextAlign.start,),
                      onPressed: () {
                        setState(() {
                          _selectedLanguage = 'en_US';
                        });
                        Navigator.pop(context, 'en_US');
                      },
                    ),
                    TextButton(
                      child: Text(translate('language.name.fr'),textAlign: TextAlign.start,),
                      onPressed: () {
                        setState(() {
                          _selectedLanguage = 'fr';
                        });
                        Navigator.pop(context, 'fr');
                      },
                    ),
                    TextButton(
                      child:  Text(translate('language.name.es'),textAlign: TextAlign.start,),
                      onPressed: () {
                        setState(() {
                          _selectedLanguage = 'es';
                        });
                        Navigator.pop(context, 'es');
                      },
                    ),
                    TextButton(
                      child:  Text(translate('language.name.ar'),textAlign: TextAlign.start,),
                      onPressed: () {
                        setState(() {
                          _selectedLanguage = 'ar';
                        });
                        Navigator.pop(context, 'ar');
                      },
                    ),


                  ],
                ),
              ),
            ),
            backgroundColor: Colors.grey[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(translate('cancel')),
                onPressed: () => Navigator.pop(context, null),
              ),
            ],
          ),
        );
      },
    ).then((value){
      if(value != null) changeLocale(context, value);
    });
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ZoomIn(
          child: AlertDialog(
            title:  Text(translate('about'),  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.grey[50],
            content:  Text(translate('aboutContent'),style: TextStyle(color: Colors.black54),),
            actions: <Widget>[
              TextButton(
                child:  Text(translate('close'), style: TextStyle(color: Colors.black45)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}