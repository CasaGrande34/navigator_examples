import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'r_pages.dart';

enum ScreenState { none, addPage, addAll, addWidget, pop, replace, replaceAll }

class ScreenAction {
  
  ScreenState state;
  ScreenConfiguration? screen;
  List<ScreenConfiguration>? screens;
  Widget? widget;

  ScreenAction({
    this.state = ScreenState.none,
    this.screen,
    this.screens,
    this.widget
    
  });
  
}

class AppState extends ChangeNotifier {
  
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  bool _splashFinished = false;
  bool get splashFinished => _splashFinished;

  final cartItems = [];

  String emailAddress = '';
  String password = '';

  ScreenAction _currentAction = ScreenAction();
  ScreenAction get currentAction => _currentAction;
  set currentAction(ScreenAction action) {
    _currentAction = action;
    notifyListeners();
  }

  /*	------------------------------------- */
  //builder
  AppState() {
    getLoggedInState();
  }
  /*	------------------------------------- */
  void resetCurrentAction() {
    _currentAction = ScreenAction();
  }

  /*	------------------------------------- */
  void addToCart(String item) {
    cartItems.add(item);
    notifyListeners();
  }

  /*	------------------------------------- */
  void removeFromCart(String item) {
    cartItems.add(item);
    notifyListeners();
  }

  /*	------------------------------------- */
  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }
  /*	------------------------------------- */
  void setSplashFinished() {
    _splashFinished = true;
    if (_loggedIn) {
      _currentAction = ScreenAction(
          state: ScreenState.replaceAll, screen: listItemsPageConfig);
    } else {
      _currentAction =
          ScreenAction(state: ScreenState.replaceAll, screen: loginPageConfig);
    }
    notifyListeners();
  }
  /*	------------------------------------- */
  void login() {
    _loggedIn = true;
    saveLoginState(loggedIn);
    _currentAction =
        ScreenAction(state: ScreenState.replaceAll, screen: listItemsPageConfig);
    notifyListeners();
  }
  /*	------------------------------------- */
  void logout() {
    _loggedIn = false;
    saveLoginState(loggedIn);
    _currentAction =
        ScreenAction(state: ScreenState.replaceAll, screen: loginPageConfig);
    notifyListeners();
  }
  /*	------------------------------------- */
  void saveLoginState(bool loggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('LoggedInKey', loggedIn);
  }
  /*	------------------------------------- */
  void getLoggedInState() async {
    final prefs = await SharedPreferences.getInstance();
    _loggedIn = prefs.getBool('LoggedInKey')!;
  }
  /*	------------------------------------- */
}
