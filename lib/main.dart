import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_learning_app/layout/news_app/news_layout.dart';
import 'package:my_learning_app/layout/shop_app/cubit/cubit.dart';
import 'package:my_learning_app/layout/shop_app/shop_app_layout.dart';
import 'package:my_learning_app/modules/shop_app/login_screen/shop_login_screen.dart';

import 'package:my_learning_app/shared/bloc_observer.dart';
import 'package:my_learning_app/shared/components/constants.dart';
import 'package:my_learning_app/shared/cubit/cubit.dart';
import 'package:my_learning_app/shared/cubit/states.dart';
import 'package:my_learning_app/shared/network/local/cache_helper.dart';
import 'package:my_learning_app/shared/network/remote/dio_helper.dart';
import 'package:my_learning_app/shared/styles/themes.dart';

import 'layout/news_app/cubit/cubit.dart';
import 'layout/todo_app/todo_layout.dart';
import 'modules/shop_app/on_boarding/on_boarding.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );
  //DioHelper.init();
   await DioHelperShopApp.init();
  await CacheHelper.init();

  bool? isDark=CacheHelper.getBool(key: 'isDark');

  Widget widget;
  bool onBoarding=CacheHelper.getData( key: 'onBoarding');
  TOKEN=CacheHelper.getData(key: 'token');

  if(onBoarding!=null){
    if(TOKEN!=null){
      widget=ShopLayout();
    }else{
      widget=ShopLoginScreen();
    }
  }else{
    widget=OnBoardingScreen();
  }
  runApp( MyApp(widget));
  //isDark!
}

class MyApp extends StatelessWidget {

  bool isDark=false;
  //final bool isDark;
  final Widget startWidget;
  MyApp(this.startWidget);
  // MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getBusinessData()..getSportsData()..getScienceData(),),
        BlocProvider(create: (BuildContext context)=>AppCubit()..ChangeAppMode(fromShared: isDark),),
        BlocProvider(create:(BuildContext context)=>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()),

      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){} ,
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
