import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../screens/screens.dart';
import 'app_state.dart';
import 'r_pages.dart';


class ShoppingRouterDelegate extends RouterDelegate<ScreenConfiguration> with ChangeNotifier, PopNavigatorRouterDelegateMixin<ScreenConfiguration> {
  
  final List<Page> _pages = [];

  
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  
  final AppState? appState;

  
  ShoppingRouterDelegate({this.appState}) : navigatorKey = GlobalKey() {
    appState!.addListener(() {
      notifyListeners();
    });
  }

  // 7
  /// Getter for a list that cannot be changed
  List<MaterialPage> get pages => List.unmodifiable(_pages);
  /// Number of pages function
  int numPages() => _pages.length;

// 8
  @override
  ScreenConfiguration get currentConfiguration =>
      _pages.last.arguments as ScreenConfiguration;
      
 @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: buildPages(),
    );
  }

  bool _onPopPage(Route<dynamic> route, result) {
    // 1
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    // 2
    if (canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }

 void _removePage(Page? screen) {
    if (screen! != null) {
      _pages.remove(screen);
    }
  }
  
  void pop() {
    if (canPop()) {
      _removePage(_pages.last);
    }
  }

  bool canPop() {
    return _pages.length > 1;
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      _removePage(_pages.last);
      return Future.value(true);
    }
    return Future.value(false);
  }

  /*	------------------------------------- */ 
  MaterialPage _createPage(Widget child, ScreenConfiguration screenConfig) {
      return MaterialPage(
          child: child,
          key: ValueKey(screenConfig.key),
          name: screenConfig.path,
          arguments: screenConfig);
    }
    
  /*	------------------------------------- */ 
  void _addScreenData(Widget? child, ScreenConfiguration screenConfig) {
    _pages.add(
      _createPage(child!, screenConfig),
    );
  }
  /*	------------------------------------- */ 
  void addScreen(ScreenConfiguration screenConfig) {
    // 1
    final shouldAddScreen = _pages.isEmpty ||
        (_pages.last.arguments as ScreenConfiguration).uiPage !=
            screenConfig.uiPage;

    if (shouldAddScreen) {
      // 2
      switch (screenConfig.uiPage) {
        case Screens.splash:
          // 3
          _addScreenData( const SplashScreen(), splashPageConfig);
          break;
        case Screens.login:
          _addScreenData( const LoginScreen(), loginPageConfig);
          break;
        case Screens.createAccount:
          _addScreenData(const AccountScreen(), createAccountPageConfig);
          break;
        case Screens.list:
          _addScreenData(const ShoppingListScreen(), listItemsPageConfig);
          break;
        case Screens.cart:
          _addScreenData(const CartScreen(), cartPageConfig);
          break;
        case Screens.checkout:
          _addScreenData(const CheckoutScreen(), checkoutPageConfig);
          break;
        case Screens.settings:
          _addScreenData(const SettingsScreen(), settingsPageConfig);
          break;
        case Screens.details:
          if (screenConfig.currentPageAction != null) {
            _addScreenData(screenConfig.currentPageAction?.widget, screenConfig);
          }
          break;
        default:
          break;
      }
    }
  }
  
  //methods pages
  // 1
  void replace(ScreenConfiguration newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addScreen(newRoute);
  }

// 2
  void setPath(List<Page> path) {
    _pages.clear();
    _pages.addAll(path);
  }

// 3
  void replaceAll(ScreenConfiguration newRoute) {
    setNewRoutePath(newRoute);
  }

// 4
  void push(ScreenConfiguration newRoute) {
    addScreen(newRoute);
  }

// 5
  void pushWidget(Widget child, ScreenConfiguration newRoute) {
    _addScreenData(child, newRoute);
  }

// 6
  void addAll(List<ScreenConfiguration> routes) {
    _pages.clear();
    for (var route in routes) {
      addScreen(route);
    }
  }


  @override
  Future<void> setNewRoutePath(ScreenConfiguration configuration) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as ScreenConfiguration).uiPage !=
            configuration.uiPage;
    if (shouldAddPage) {
      _pages.clear();
      addScreen(configuration);
    }
    return SynchronousFuture(null);
  }
  
  void _setScreenAction(ScreenAction action) {
    switch (action.screen?.uiPage) {
      case Screens.splash:
        splashPageConfig.currentPageAction = action;
        break;
      case Screens.login:
        loginPageConfig.currentPageAction = action;
        break;
      case Screens.createAccount:
        createAccountPageConfig.currentPageAction = action;
        break;
      case Screens.list:
        listItemsPageConfig.currentPageAction = action;
        break;
      case Screens.cart:
        cartPageConfig.currentPageAction = action;
        break;
      case Screens.checkout:
        checkoutPageConfig.currentPageAction = action;
        break;
      case Screens.settings:
        settingsPageConfig.currentPageAction = action;
        break;
      case Screens.details:
        detailsPageConfig.currentPageAction = action;
        break;
      default:
        break;
    }
  }
  
  List<Page> buildPages() {
    // 1
    if (!appState!.splashFinished) {
      replaceAll(splashPageConfig);
    } else {
      // 2
      switch (appState!.currentAction.state) {
        // 3
        case ScreenState.none:
          break;
        case ScreenState.addPage:
          // 4
          _setScreenAction(appState!.currentAction);
          addScreen(appState!.currentAction.screen!);
          break;
        case ScreenState.pop:
          // 5
          pop();
          break;
        case ScreenState.replace:
          // 6
          _setScreenAction(appState!.currentAction);
          replace(appState!.currentAction.screen!);
          break;
        case ScreenState.replaceAll:
          // 7
          _setScreenAction(appState!.currentAction);
          replaceAll(appState!.currentAction.screen!);
          break;
        case ScreenState.addWidget:
          // 8
          _setScreenAction(appState!.currentAction);
          pushWidget(
              appState!.currentAction.widget!, appState!.currentAction.screen!);
          break;
        case ScreenState.addAll:
          // 9
          addAll(appState!.currentAction.screens!);
          break;
      }
    }
    // 10
    appState!.resetCurrentAction();
    return List.of(_pages);
  }



}
