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
    controller.onTab(0);
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          children: [Home(), MessageLayout(), LogoutLayout()],
          index: controller.index,
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: unSelectedItemColor,
          selectedItemColor: selectedItemColor,
          onTap: controller.onTab,
          currentIndex: controller.index,
          items: [
            _createNavigationItem(icon: Icons.home, label: "الرئسية"),
            _createNavigationItem(icon: Icons.message, label: "رسائل"),
            _createNavigationItem(icon: Icons.logout, label: "تسجيل خروج"),
          ],
        ),
      ),
    );
  }

  _createNavigationItem({icon, label}) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }
}
