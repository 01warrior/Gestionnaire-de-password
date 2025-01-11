import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import '../../../data/models/password_model.dart';
import '../../controllers/password_controller.dart';
import '../widgets/text_field_input.dart';
import '../../utils/constants.dart';
import '../../themes/app_theme.dart';
import 'package:flutter_translate/flutter_translate.dart';

class AddPasswordScreen extends StatefulWidget {
  final Password? password;

  const AddPasswordScreen({Key? key, this.password}) : super(key: key);

  @override
  _AddPasswordScreenState createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _websiteNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _websiteAddressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String? _category;
  String? _connectedAccount;

  @override
  void initState() {
    super.initState();
    if (widget.password != null) {
      _websiteNameController.text = widget.password!.websiteName;
      _usernameController.text = widget.password!.username;
      _passwordController.text = widget.password!.password;
      _websiteAddressController.text = widget.password!.websiteAddress ?? '';
      _notesController.text = widget.password!.notes ?? '';
      _category = widget.password!.category;
      _connectedAccount = widget.password!.connectedAccount;
    }
  }

  @override
  void dispose() {
    _websiteNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _websiteAddressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordController = Provider.of<PasswordController>(context);

    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.password == null ? translate('newItem') : translate('edit'),),
        actions: [
          if(widget.password != null)
            IconButton(onPressed: (){
              _showDeleteConfirmationDialog(context, passwordController);
            }, icon:  HugeIcon(icon: HugeIcons.strokeRoundedDelete02, color: Colors.red,size: 28,),),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                TextFieldInput(
                    controller: _websiteNameController,
                    hintText: translate('websiteName'),
                    labelText: translate('websiteName'),
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return translate('pleaseEnterWebsiteName');
                      }
                      return null;
                    }
                ),
                SizedBox(height: 20),
                TextFieldInput(
                    controller: _usernameController,
                    hintText: translate('username'),
                    labelText: translate('username'),
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return translate('pleaseEnterUsername');
                      }
                      return null;
                    }
                ),

                SizedBox(height: 20),
                TextFieldInput(
                    controller: _passwordController,
                    hintText: translate('password'),
                    labelText: translate('password'),
                    obscureText: true,
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return translate('pleaseEnterPassword');
                      }
                      return null;
                    }
                ),
                SizedBox(height: 20),
                TextFieldInput(
                  controller: _websiteAddressController,
                  hintText: translate('websiteAddress'),
                  labelText: translate('websiteAddress'),
                ),
                SizedBox(height: 20),

                TextFieldInput(
                  controller: _notesController,
                  hintText: translate('notes'),
                  labelText: translate('notes'),
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                Text(translate('category'), style: const TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: Constants.categories.map((category) {
                    return ChoiceChip(
                      label: Text(category,  style: TextStyle(
                        color: _category == category ? Colors.white : Colors.black,
                      ),),
                      checkmarkColor: Colors.white,
                      selected: _category == category,
                      selectedColor: AppTheme.primaryColor,
                      backgroundColor: Colors.grey[200],
                      onSelected: (isSelected) {
                        setState(() {
                          _category = isSelected ? category : null;
                        });
                      },
                    );
                  }).toList(),
                ),

                SizedBox(height: 20),
                Text(translate('connectedAccount'), style: const TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: Constants.connectedAccounts.map((account) {
                    return ChoiceChip(
                      label: Text(account,  style: TextStyle(
                        color: _connectedAccount == account ? Colors.white : Colors.black,
                      ),),
                      checkmarkColor: Colors.white,
                      selected: _connectedAccount == account,
                      selectedColor: AppTheme.primaryColor,
                      backgroundColor: Colors.grey[200],
                      onSelected: (isSelected) {
                        setState(() {
                          _connectedAccount = isSelected ? account : null;
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:  const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    ),
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                        final newPassword = Password(
                          id: widget.password?.id,
                          websiteName: _websiteNameController.text,
                          username: _usernameController.text,
                          password: _passwordController.text,
                          websiteAddress: _websiteAddressController.text.isNotEmpty ? _websiteAddressController.text : null,
                          notes: _notesController.text.isNotEmpty ? _notesController.text : null,
                          category: _category,
                          connectedAccount: _connectedAccount,
                        );

                        if(widget.password != null){
                          await passwordController.updatePassword(newPassword);
                        }else {
                          await passwordController.addPassword(newPassword);
                        }
                        Navigator.pop(context);

                      }
                    },
                    child:  Text(widget.password == null ? translate('add') : translate('edit'),
                        style: const TextStyle(fontSize: 16)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _showDeleteConfirmationDialog(BuildContext context, PasswordController passwordController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translate('deletePassword')),
          content: Text(translate('confirmation')),
          actions: <Widget>[
            TextButton(
              child: Text(translate('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:  Text(translate('delete'), style: const TextStyle(color: Colors.red)),
              onPressed: () async {
                if(widget.password != null){
                  await passwordController.deletePassword(widget.password!.id!);
                }

                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

}