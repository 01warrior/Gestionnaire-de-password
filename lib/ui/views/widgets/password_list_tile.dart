import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../ screens/password_detail_screen.dart';
import '../../../data/models/password_model.dart';

class PasswordListTile extends StatelessWidget {
  final Password password;

  const PasswordListTile({Key? key, required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordDetailScreen(passwordId: password.id!)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2C3E50),
              Color(0xFF34495E),
            ],
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8)

              ),
              child: HugeIcon(icon: HugeIcons.strokeRoundedLockKey, color: Colors.white,size: 24,)
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    password.websiteName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white
                    ),
                  ),
                  Text(
                    password.username,
                    style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            HugeIcon( color: Colors.white, icon:HugeIcons.strokeRoundedArrowRight02)
          ],
        ),
      ),
    );
  }
}