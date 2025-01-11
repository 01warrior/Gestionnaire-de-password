import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import '../../controllers/password_controller.dart';
import 'add_password_screen.dart';
import '../../themes/app_theme.dart';
import 'package:animate_do/animate_do.dart';

class PasswordDetailScreen extends StatelessWidget {
  final int passwordId;

  const PasswordDetailScreen({Key? key, required this.passwordId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordController>(
      builder: (context, passwordController, child) {
        return FutureBuilder(
          future: passwordController.getPasswordById(passwordId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(color: AppTheme.primaryColor));
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading password'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('Password not found'));
            } else {
              final password = snapshot.data!;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Password detail'),
                  actions: [
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddPasswordScreen(password: password)));

                    }, icon:  HugeIcon(icon: HugeIcons.strokeRoundedEdit02, color: Colors.black,size: 28,),),
                    IconButton(
                      icon: HugeIcon(icon: HugeIcons.strokeRoundedDelete02, color: Colors.red,size: 28,),
                      onPressed: () => _showDeleteConfirmationDialog(
                          context, passwordController, password.id!),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FadeInUp(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Icon(
                            Icons.key,
                            size: 80,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text(password.websiteName,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[100],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Username/email address',
                                  style: TextStyle(color: Colors.grey[600])),
                              const SizedBox(height: 5),
                              Text(password.username,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 15),
                              Text('Password',
                                  style: TextStyle(color: Colors.grey[600])),
                              const SizedBox(height: 5),
                              Text(password.password,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 15),
                              if (password.connectedAccount != null) ...[
                                Text('Connected Account',
                                    style: TextStyle(color: Colors.grey[600])),
                                const SizedBox(height: 5),
                                Text(password.connectedAccount!,
                                    style: const TextStyle(fontSize: 16)),
                                const SizedBox(height: 15),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (password.websiteAddress != null ||
                            password.notes != null) ...[
                          Text('Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 15),
                          if (password.websiteAddress != null) ...[
                            Text('Website address',
                                style: TextStyle(color: Colors.grey[600])),
                            const SizedBox(height: 5),
                            Text(password.websiteAddress!,
                                style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 15),
                          ],
                          if (password.notes != null) ...[
                            Text('Notes',
                                style: TextStyle(color: Colors.grey[600])),
                            const SizedBox(height: 5),
                            Text(password.notes!,
                                style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 15),
                          ],
                          if (password.category != null) ...[
                            Text('Category',
                                style: TextStyle(color: Colors.grey[600])),
                            const SizedBox(height: 5),
                            Text(password.category!,
                                style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 15),
                          ],
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
  void _showDeleteConfirmationDialog(BuildContext context,
      PasswordController passwordController, int passwordId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ZoomIn(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.grey[50],
            title: const Text('Delete Password',  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
            content: const Text('Are you sure you want to delete this password?', style: TextStyle(color: Colors.black54),),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel',style: TextStyle(color: Colors.black45)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Delete', style: TextStyle(color: Colors.red)),
                onPressed: () async {
                  await passwordController.deletePassword(passwordId);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Retourne à l'écran précédent après la suppression
                },
              ),
            ],
          ),
        );
      },
    );
  }
}