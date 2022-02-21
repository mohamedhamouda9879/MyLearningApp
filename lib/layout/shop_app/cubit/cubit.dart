import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning_app/layout/shop_app/cubit/states.dart';
import 'package:my_learning_app/models/shop_app/categories_model.dart';
import 'package:my_learning_app/models/shop_app/change_favorites_model.dart';
import 'package:my_learning_app/models/shop_app/favorites_model.dart';
import 'package:my_learning_app/models/shop_app/home_model.dart';
import 'package:my_learning_app/models/shop_app/login_model.dart';
import 'package:my_learning_app/modules/shop_app/categories/categories_screen.dart';
import 'package:my_learning_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:my_learning_app/modules/shop_app/products/products_screen.dart';
import 'package:my_learning_app/modules/shop_app/seetings/settings_screen.dart';
import 'package:my_learning_app/shared/components/constants.dart';
import 'package:my_learning_app/shared/network/end_points.dart';
import 'package:my_learning_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void ChangeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool>? favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelperShopApp.getData(Url: HOME, auth: TOKEN).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //printFullText(homeModel.toString());
      homeModel!.data.products.forEach((element) {
        favorites!.addAll({
          element.id: element.inFavorites,
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error));
    });
  }



  ChangeFavoritesModel? changeFavoritesModel;
  void ChangeFavorites(int ProductId) {

    favorites![ProductId] = !favorites![ProductId]!;
    emit(ShopChangeFavoritesState());

    DioHelperShopApp.postData(
      Url: FAVORITES,
      data: {'product_id': ProductId},
      auth: TOKEN,
    ).then((value) {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel!.status){
        favorites![ProductId] = !favorites![ProductId]!;
      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites![ProductId] = !favorites![ProductId]!;
      emit(ShopErrorChangeFavoritesState(error));
    });
  }



  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelperShopApp.getData(
      Url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // printFullText(categoriesModel.data.data.length.toString());
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState(error));
    });
  }


  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavState());
    DioHelperShopApp.getData(
      Url: FAVORITES,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // printFullText(categoriesModel.data.data.length.toString());
      emit(ShopSuccessGetFavState());
    }).catchError((error) {
      print(error);
      emit(ShopErrorGetFavState(error));
    });
  }


  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelperShopApp.getData(
      Url: PROFILE,
      auth: TOKEN,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data.name);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }




  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelperShopApp.postData(
      Url: UPDATE_PROFILE,
      auth: TOKEN,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data.name);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print('hamouda'+error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}
