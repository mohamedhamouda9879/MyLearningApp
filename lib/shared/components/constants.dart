
/*
* https://newsapi.org/
* v2/top-headlines
* ?country=us&category=business&apiKey=dc3d106e730c4256b8c275d9da58d090
* */
/*
* http://192.236.155.173:55886/
* notes/getall
* */
/*
* https://newsapi.org/
* v2/everything
* ?q=tesla&apiKey=dc3d106e730c4256b8c275d9da58d090
* */


import 'package:my_learning_app/shared/components/components.dart';
import 'package:my_learning_app/shared/network/local/cache_helper.dart';

import '../../modules/shop_app/login_screen/shop_login_screen.dart';

void SignOut(context){

  CacheHelper.RemoveData(key: 'token').then((value) {
    if (value) {
      NavigateAndFinish(context, ShopLoginScreen());
    }
  });

}

void printFullText(String text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element)=>print(element.group(0)));
}

String TOKEN='';