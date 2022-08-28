//names of routes 
import 'app_state.dart';

const String splashPath = '/splash';
const String loginPath = '/login';
const String createAccountPath = '/createAccount';
const String listItemsPath = '/listItems';
const String detailsPath = '/details';
const String cartPath = '/cart';
const String checkoutPath = '/checkout';
const String settingsPath = '/settings';


enum Screens {
  splash,
  login,
  createAccount,
  list,
  details,
  cart,
  checkout,
  settings
}

class ScreenConfiguration {
  final String key;
  final String path;
  final Screens uiPage;
  ScreenAction? currentPageAction;

  ScreenConfiguration(
      { 
        required this.key,
        required this.path,
        required this.uiPage,
        this.currentPageAction
        });
}

//Objects
ScreenConfiguration splashPageConfig = ScreenConfiguration(
    key: 'Splash',
    path: splashPath,
    uiPage: Screens.splash,
    currentPageAction: null
  );
ScreenConfiguration loginPageConfig = ScreenConfiguration(
    key: 'Login',
    path: loginPath,
    uiPage: Screens.login,
    currentPageAction: null
  );
ScreenConfiguration createAccountPageConfig = ScreenConfiguration(
    key: 'CreateAccount',
    path: createAccountPath,
    uiPage: Screens.createAccount,
    currentPageAction: null
  );
ScreenConfiguration listItemsPageConfig = ScreenConfiguration(
    key: 'ListItems', 
    path: listItemsPath, 
    uiPage: Screens.list,
    currentPageAction: null
  );
    
ScreenConfiguration detailsPageConfig = ScreenConfiguration(
    key: 'Details',
    path: detailsPath,
    uiPage: Screens.details,
    currentPageAction: null
  );
ScreenConfiguration cartPageConfig = ScreenConfiguration(
    key: 'Cart', 
    path: cartPath, 
    uiPage: Screens.cart, 
    currentPageAction: null
  );
ScreenConfiguration checkoutPageConfig = ScreenConfiguration(
    key: 'Checkout',
    path: checkoutPath,
    uiPage: Screens.checkout,
    currentPageAction: null
  );
ScreenConfiguration settingsPageConfig = ScreenConfiguration(
    key: 'Settings',
    path: settingsPath,
    uiPage: Screens.settings,
    currentPageAction: null
  );
