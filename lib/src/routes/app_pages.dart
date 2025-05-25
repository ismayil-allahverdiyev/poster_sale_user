import 'package:get/get.dart';
import 'package:poster_sale_user/src/bindings/login/login_bindings.dart';
import 'package:poster_sale_user/src/bindings/settings/settings_bindings.dart';
import 'package:poster_sale_user/src/bindings/message_overview/message_overview_bindings.dart';
import 'package:poster_sale_user/src/bindings/product/product_bindings.dart';
import 'package:poster_sale_user/src/bindings/profile/profile_bindings.dart';
import 'package:poster_sale_user/src/ui/login/sign_up_overview_page.dart';
import 'package:poster_sale_user/src/ui/settings/settings_page.dart';
import 'package:poster_sale_user/src/ui/message_overview/message_overview_page.dart';
import 'package:poster_sale_user/src/ui/messages_detailed/messages_detailed_page.dart';
import 'package:poster_sale_user/src/ui/product/product_page.dart';
import 'package:poster_sale_user/src/ui/profile/profile_page.dart';

import '../bindings/app/app_bindings.dart';
import '../bindings/basket_overview/basket_overview_bindings.dart';
import '../bindings/bottom_navbar/bottom_navbar_bindings.dart';
import '../bindings/home/home_bindings.dart';
import '../bindings/messages_detailed/messages_detailed_bindings.dart';
import '../ui/app.dart';
import '../ui/basket_overview/basket_overview_page.dart';
import '../ui/bottom_navbar/bottom_navbar.dart';
import '../ui/home/home_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.BOTTOM,
        page: () => BottomNavBar(),
        binding: BottomNavBarBinding()),
    GetPage(
      name: Routes.INITIAL,
      page: () => const AppPage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT,
      page: () => const ProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.MESSAGEOVERVIEW,
      page: () => const MessageOverviewPage(),
      binding: MessageOverviewBindings(),
    ),
    GetPage(
      name: Routes.MESSAGESDETAILED,
      page: () => const MessagesDetailedPage(),
      binding: MessagesDetailedBindings(),
    ),
    GetPage(
      name: Routes.BASKETOVERVIEW,
      page: () => const BasketOverviewPage(),
      binding: BasketOverviewBindings(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfilePage(),
      binding: ProfileBindings(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsPage(),
      binding: SettingsBindings(),
    ),
    GetPage(
      name: Routes.SIGNUPOVERVIEW,
      page: () => const SignUpOverviewPage(),
      binding: LoginBinding(),
    )
  ];
}
