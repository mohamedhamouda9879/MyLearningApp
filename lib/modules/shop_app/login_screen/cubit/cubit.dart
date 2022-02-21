import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning_app/models/shop_app/login_model.dart';
import 'package:my_learning_app/modules/shop_app/login_screen/cubit/states.dart';
import 'package:my_learning_app/shared/network/end_points.dart';
import 'package:my_learning_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialStates());

  ShopLoginModel? shopLoginModel;
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void UserLogin({required String email, required String password}) {
    emit(ShopLoginLoadingStates());
    DioHelperShopApp.postData(
      Url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      shopLoginModel=ShopLoginModel.fromJson(value.data);
      print(value.toString());
      emit(ShopLoginSucessStates(shopLoginModel!));
    }).catchError((error) {
      emit(ShopLoginErrorStates(error.toString()));
    });
  }

  IconData sufix = Icons.visibility_outlined;
  bool isPasswordShowen = true;

  void changePasswordVisibility() {
    isPasswordShowen = !isPasswordShowen;
    sufix = isPasswordShowen ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityStates());
  }
}
