import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import '../../controllers/password_controller.dart';
import '../widgets/password_list_tile.dart';
import 'add_password_screen.dart';
import 'package:animate_do/animate_do.dart';
import '../../themes/app_theme.dart';
import '../../../data/models/password_model.dart';
import 'package:flutter_translate/flutter_translate.dart';
enum SortOption {
  websiteName,
  latestSave,
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SortOption _sortOption = SortOption.latestSave;

  @override
  Widget build(BuildContext context) {
    final passwordController = Provider.of<PasswordController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('homeScreenTitle')),
        actions: [
          PopupMenuButton<SortOption>(
            color: Colors.transparent,
            icon: HugeIcon(icon: HugeIcons.strokeRoundedSorting05, color: Colors.black,size: 28),
            onSelected: (SortOption result) {
              setState(() {
                _sortOption = result;
                passwordController.sortPasswords(_sortOption);
              });
            },

            itemBuilder: (BuildContext context) => <PopupMenuEntry<SortOption>>[
              PopupMenuItem<SortOption>(
                value: SortOption.websiteName,
                child:  Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child:  Text(translate('websiteName'), style: const TextStyle(color: Colors.black87),),
                ),
              ),
              PopupMenuItem<SortOption>(
                value: SortOption.latestSave,
                child:  Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child:  Text(translate('latestSave'), style: const TextStyle(color: Colors.black87)),
                ),
              ),
            ],
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ],
      ),


      body: passwordController.isLoading ? Center(
        child: CircularProgressIndicator(
          color:  AppTheme.primaryColor,
        ),
      ): Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZoomIn(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF2C3E50),
                        Color(0xFF34495E),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20)
                ),

                child: Column(
                  children: [
                    Text(translate('newItem'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
                    SizedBox(height: 5,),
                    Text(translate('saveWithEase'),
                      style:  const TextStyle(color: Colors.white70, fontSize: 16),textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  const AddPasswordScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          padding:  const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                          backgroundColor:  AppTheme.secondaryColor,
                        ),
                        child:  Text(translate('addNew'),style: const TextStyle(color: Colors.black),),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FadeInLeft(
                  child:  Text(translate('homeScreenTitle'),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(translate('latestSave'), style: const TextStyle(color: Colors.grey),),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FadeInUp(
                child: Consumer<PasswordController>(
                    builder: (context, controller, child) {
                      return ListView.builder(
                        itemCount: controller.passwords.length,
                        itemBuilder: (context, index) {
                          final password = controller.passwords[index];
                          return PasswordListTile(password: password);
                        },
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}