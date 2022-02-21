import 'package:my_learning_app/models/shop_app/change_favorites_model.dart';
import 'package:my_learning_app/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{
  String error;

  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{
  String error;

  ShopErrorCategoriesState(this.error);
}

class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel changeFavoritesModel;

  ShopSuccessChangeFavoritesState(this.changeFavoritesModel);
}

class ShopChangeFavoritesState extends ShopStates{}

class ShopErrorChangeFavoritesState extends ShopStates{
  String error;

  ShopErrorChangeFavoritesState(this.error);
}

class ShopSuccessGetFavState extends ShopStates{}

class ShopErrorGetFavState extends ShopStates{
  String error;

  ShopErrorGetFavState(this.error);
}

class ShopLoadingGetFavState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates {}
