import 'package:my_learning_app/models/shop_app/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialStates extends ShopLoginStates{}

class ShopLoginLoadingStates extends ShopLoginStates{}

class ShopLoginSucessStates extends ShopLoginStates{

  ShopLoginModel shopLoginModel;

  ShopLoginSucessStates(this.shopLoginModel);
}

class ShopLoginErrorStates extends ShopLoginStates{
  final String error;
  ShopLoginErrorStates(this.error);
}

class ShopChangePasswordVisibilityStates extends ShopLoginStates{}