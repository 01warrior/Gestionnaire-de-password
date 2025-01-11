import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/password_model.dart';
import '../../controllers/password_controller.dart';
import '../widgets/password_list_tile.dart';
import 'package:animate_do/animate_do.dart';
import '../../themes/app_theme.dart';
import '../../utils/constants.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  String _searchQuery = '';
  String? _selectedCategory;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final passwordController = Provider.of<PasswordController>(context);
    List<Password> filteredPasswords = passwordController.passwords.where((password) {
      final query = _searchQuery.toLowerCase();
      final websiteNameMatch = password.websiteName.toLowerCase().contains(query);
      final usernameMatch = password.username.toLowerCase().contains(query);
      final categoryMatch = _selectedCategory == null || password.category == _selectedCategory;

      return (websiteNameMatch || usernameMatch) && categoryMatch;
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search passwords...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:   BorderSide(color:  Colors.grey[300]!),

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:   BorderSide(color:  Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:   BorderSide(color:  Colors.grey[300]!),
                  ),

                ),
              ),
            ),
            const SizedBox(height: 10),
            if(Constants.categories.isNotEmpty) ... [
              const Text('Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 8,
                  children: Constants.categories.map((category) {
                    return ChoiceChip(

                      label: Text(category, style: TextStyle(
                        color: _selectedCategory == category ? Colors.white : Colors.black,
                      ),
                      ),
                      selected: _selectedCategory == category,
                      backgroundColor: Colors.grey[200],
                      selectedColor: AppTheme.primaryColor,
                      checkmarkColor: Colors.white,
                      onSelected: (isSelected) {
                        setState(() {
                          _selectedCategory = isSelected ? category : null;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ],



            const SizedBox(height: 20),
            Expanded(
              child: FadeInUp(
                child: ListView.builder(
                  itemCount: filteredPasswords.length,
                  itemBuilder: (context, index) {
                    final password = filteredPasswords[index];
                    return PasswordListTile(password: password);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}