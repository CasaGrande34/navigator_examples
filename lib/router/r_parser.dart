import 'package:flutter/material.dart';

import 'r_pages.dart';

class ShoppingParser extends RouteInformationParser<ScreenConfiguration> {
  @override
  Future<ScreenConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    // 1
    final uri = Uri.parse(routeInformation.location!);
    // 2
    if (uri.pathSegments.isEmpty) {
      return splashPageConfig;
    }

    // 3
    final path = uri.pathSegments[0];
    // 4
    switch (path) {
      case splashPath:
        return splashPageConfig;
      case loginPath:
        return loginPageConfig;
      case createAccountPath:
        return createAccountPageConfig;
      case listItemsPath:
        return listItemsPageConfig;
      case detailsPath:
        return detailsPageConfig;
      case cartPath:
        return cartPageConfig;
      case checkoutPath:
        return checkoutPageConfig;
      case settingsPath:
        return settingsPageConfig;
      default:
        return splashPageConfig;
    }
  }
  
  @override
  RouteInformation restoreRouteInformation(ScreenConfiguration configuration) {
    switch (configuration.uiPage) {
      case Screens.splash:
        return const RouteInformation(location: splashPath);
      case Screens.login:
        return const RouteInformation(location: loginPath);
      case Screens.createAccount:
        return const RouteInformation(location: createAccountPath);
      case Screens.list:
        return const RouteInformation(location: listItemsPath);
      case Screens.details:
        return const RouteInformation(location: detailsPath);
      case Screens.cart:
        return const RouteInformation(location: cartPath);
      case Screens.checkout:
        return const RouteInformation(location: checkoutPath);
      case Screens.settings:
        return const RouteInformation(location: settingsPath);
      default:
        return const RouteInformation(location: splashPath);
    }
  }


}
