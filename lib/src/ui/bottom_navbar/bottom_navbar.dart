import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/ui/theme/app_colors.dart';
import '../../constants/assets.dart';
import '../../controllers/bottom_navbar/bottom_navbar_controller.dart';

class BottomNavBar extends GetView<BottomNavBarController> {
  BottomNavBar({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        shape: const RoundedRectangleBorder(),
        backgroundColor: primaryColor,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: whiteColor.withOpacity(0.5),
                child: Image.asset(
                  Assets.icon_profile,
                  scale: 2.5,
                ),
              ),
            ),
            CustomDrawerTile(
              title: "Home",
              index: 0,
              closeFunction: () {
                scaffoldKey.currentState!.openEndDrawer();
              },
            ),
            CustomDrawerTile(
              title: "Messages",
              index: 1,
              closeFunction: () {
                scaffoldKey.currentState!.openEndDrawer();
              },
            ),
            CustomDrawerTile(
              title: "Bag",
              index: 2,
              closeFunction: () {
                scaffoldKey.currentState!.openEndDrawer();
              },
            ),
            CustomDrawerTile(
              title: "Profile",
              index: 3,
              closeFunction: () {
                scaffoldKey.currentState!.openEndDrawer();
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(
              () => controller.pages[controller.currentIndex.value],
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigationBarElements(),
          )
        ],
      ),
    );
  }
}

class CustomDrawerTile extends GetWidget<BottomNavBarController> {
  const CustomDrawerTile({
    super.key,
    required this.index,
    required this.title,
    required this.closeFunction,
  });

  final int index;
  final String title;
  final Function closeFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Obx(
        () {
          return ListTile(
            dense: true,
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                side: BorderSide(
                  color: controller.currentIndex.value == index
                      ? greyColor
                      : greyColor.withOpacity(0.5),
                  style: BorderStyle.solid,
                  width: 2,
                )),
            title: Text(
              title,
              style: const TextStyle(
                color: whiteColor,
              ),
            ),
            onTap: () {
              closeFunction();
              controller.onTap(1);
            },
          );
        },
      ),
    );
  }
}

class BottomNavigationBarElements extends GetWidget<BottomNavBarController> {
  const BottomNavigationBarElements({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: primaryColor,
        ),
        child: Stack(
          children: [
            Positioned(
              top: Get.width * -0.3,
              child: Image.asset(
                Assets.complex_background,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavBarElement(
                    asset: Assets.icon_home,
                    index: 0,
                  ),
                  NavBarElement(
                    asset: Assets.icon_message,
                    index: 1,
                  ),
                  NavBarElement(
                    asset: Assets.icon_bag,
                    index: 2,
                  ),
                  NavBarElement(
                    asset: Assets.icon_profile,
                    index: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarElement extends GetWidget<BottomNavBarController> {
  const NavBarElement({
    super.key,
    required this.asset,
    required this.index,
  });
  final String asset;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: Get.width * 0.06,
      onTap: () {
        controller.onTap(index);
      },
      child: Obx(
        () {
          return CircleAvatar(
            radius: Get.width * 0.06,
            backgroundColor: controller.currentIndex.value == index
                ? const Color(0xff3F4244).withOpacity(0.6)
                : Colors.transparent,
            child: Image.asset(
              asset,
              color: controller.currentIndex.value == index
                  ? whiteColor.withOpacity(0.80)
                  : null,
              scale: 2.5,
            ),
          );
        },
      ),
    );
  }
}
