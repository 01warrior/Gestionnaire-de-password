import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../themes/app_theme.dart';
import 'package:clipboard/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';


class GeneratePasswordScreen extends StatefulWidget {
  const GeneratePasswordScreen({super.key});

  @override
  _GeneratePasswordScreenState createState() => _GeneratePasswordScreenState();
}

class _GeneratePasswordScreenState extends State<GeneratePasswordScreen> {
  String _generatedPassword = '';
  double _passwordLength = 12;
  bool _includeUpperCase = true;
  bool _includeLowerCase = true;
  bool _includeNumbers = true;
  bool _includeSymbols = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate password'),
      ),
      body: FadeInUp(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Center(
                child:  HugeIcon(icon: HugeIcons.strokeRoundedKey02, color: AppTheme.primaryColor,size: 80,),
              ),
              const SizedBox(height: 20),
              const  Center(child: Text('Customize your password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
              const  SizedBox(height: 20),

              const Text('Password Length', style: TextStyle(fontSize: 16, color: Colors.grey)),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: AppTheme.primaryColor, // Couleur de la partie active
                  inactiveTrackColor: Colors.grey[300], // Couleur de la partie inactive
                  thumbColor: AppTheme.primaryColor, // Couleur du curseur
                  overlayColor: AppTheme.secondaryColor.withOpacity(0.3), // Couleur de l'effet au toucher
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0), // Forme du curseur
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0), // Forme de l'effet au toucher
                  trackHeight: 5.0,
                  valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: AppTheme.primaryColor,
                  showValueIndicator: ShowValueIndicator.always,


                ),
                child: Slider(
                  value: _passwordLength,
                  min: 6,
                  max: 30,
                  divisions: 24,
                  onChanged: (value) {
                    setState(() {
                      _passwordLength = value;
                    });
                  },
                  label: _passwordLength.round().toString(),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Colors.grey, // Couleur du checkbox désactivé
                    ),
                    child: CheckboxListTile(
                      title: const Text('Include Uppercase',  style: TextStyle(color: Colors.grey)),
                      value: _includeUpperCase,
                      onChanged: (value) {
                        setState(() {
                          _includeUpperCase = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      activeColor: AppTheme.primaryColor,
                    ),
                  ),

                  Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Colors.grey, // Couleur du checkbox désactivé
                    ),
                    child: CheckboxListTile(
                      title: const Text('Include Lowercase',  style: TextStyle(color: Colors.grey)),
                      value: _includeLowerCase,
                      onChanged: (value) {
                        setState(() {
                          _includeLowerCase = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      activeColor: AppTheme.primaryColor,
                    ),
                  ),

                  Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Colors.grey, // Couleur du checkbox désactivé
                    ),
                    child: CheckboxListTile(
                      title: const Text('Include Numbers',  style: TextStyle(color: Colors.grey)),
                      value: _includeNumbers,
                      onChanged: (value) {
                        setState(() {
                          _includeNumbers = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      activeColor: AppTheme.primaryColor,
                    ),
                  ),

                  Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Colors.grey, // Couleur du checkbox désactivé
                    ),
                    child: CheckboxListTile(
                      title: const Text('Include Symbols',  style: TextStyle(color: Colors.grey)),
                      value: _includeSymbols,
                      onChanged: (value) {
                        setState(() {
                          _includeSymbols = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      activeColor: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),


              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _generatePassword,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: const Text('Generate Password'),
                  ),
                ),
              ),
              const  SizedBox(height: 20),

              if (_generatedPassword.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _generatedPassword,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),

                      IconButton(onPressed: (){
                        _copyPasswordToClipboard();
                      }, icon:  Icon(Icons.copy, color:  AppTheme.primaryColor,)),

                    ],
                  ),
                ),

              ],

            ],
          ),
        ),
      ),
    );
  }

  void _generatePassword() {
    const String upperCaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String lowerCaseChars = 'abcdefghijklmnopqrstuvwxyz';
    const String numberChars = '0123456789';
    const String symbolChars = '!@#\$%^&*()_+=-`~[]\\{\\}|;\':",./<>?';


    String allowedChars = '';

    if (_includeUpperCase) allowedChars += upperCaseChars;
    if (_includeLowerCase) allowedChars += lowerCaseChars;
    if (_includeNumbers) allowedChars += numberChars;
    if (_includeSymbols) allowedChars += symbolChars;

    if (allowedChars.isEmpty) {
    Fluttertoast.showToast(msg: 'Please choose at least one criteria');
    setState(() {
    _generatedPassword = "";
    });
    return;
    }

    String password = '';
    for (int i = 0; i < _passwordLength; i++) {
    password += allowedChars[(DateTime.now().microsecondsSinceEpoch + i) % allowedChars.length];

    }
    setState(() {
    _generatedPassword = password;
    });
  }


  void _copyPasswordToClipboard() {
    FlutterClipboard.copy(_generatedPassword).then(( result ) {
      Fluttertoast.showToast(msg: 'Password Copied');
    });
  }
}