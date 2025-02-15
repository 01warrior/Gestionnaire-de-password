import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(covariant CustomBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.currentIndex != _selectedIndex){
      setState(() {
        _selectedIndex = widget.currentIndex;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return FlashyTabBar(
      iconSize: 30,
      selectedIndex: _selectedIndex,
      showElevation: true,
      onItemSelected: (index) {
        setState(() {
          _selectedIndex = index;
          widget.onTap(index);

        });
      },
      items: [
        FlashyTabBarItem(
          icon: const Icon(HugeIcons.strokeRoundedGoogleHome),
          title:  Text(translate('accueil')),
        ),
        FlashyTabBarItem(
          icon: const Icon(HugeIcons.strokeRoundedCheckList),
          title: Text(translate('items')),
        ),
        FlashyTabBarItem(
          icon: const Icon(HugeIcons.strokeRoundedListSetting),
          title: Text(translate('cle')),
        ),
        FlashyTabBarItem(
          icon: const Icon(HugeIcons.strokeRoundedAccountSetting01),
          title: Text(translate('setting')),
        ),
      ],
    );
  }
}