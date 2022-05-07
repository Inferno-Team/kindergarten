import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/home_view_mode.dart';
import 'package:kindergarten/ui/home/home_layout.dart';
import 'package:kindergarten/ui/messages/messages_layout.dart';
import 'package:kindergarten/ui/settings/settings_layout.dart';
import 'package:kindergarten/utils/constaince.dart';

class MainLayout extends GetWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          children: [Home(), MessageLayout(), SettingsLayout()],
          index: controller.index,
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: unSelectedItemColor,
          selectedItemColor: selectedItemColor,
          onTap: controller.onTab,
          currentIndex: controller.index,
          items: [
            _createNavigationItem(icon: Icons.home, label: "Home"),
            _createNavigationItem(icon: Icons.message, label: "Messages"),
            _createNavigationItem(icon: Icons.settings, label: "Settings"),
          ],
        ),
      ),
    );
  }

  _createNavigationItem({icon, label}) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }
}
