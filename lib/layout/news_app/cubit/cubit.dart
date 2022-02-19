import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning_app/layout/news_app/cubit/states.dart';
import 'package:my_learning_app/modules/business/business_screen.dart';
import 'package:my_learning_app/modules/science/science_screen.dart';
import 'package:my_learning_app/modules/settings_screen/setting_screen.dart';
import 'package:my_learning_app/modules/sports/sports_screen.dart';
import 'package:my_learning_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Science'),

  ];

  void ChangeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<dynamic> business = [];
  void getBusinessData() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      'v2/top-headlines',
      {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'dc3d106e730c4256b8c275d9da58d090',
      },
    ).then((value){
      business=value.data['articles'];
      print(business.length);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSportsData() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      'v2/top-headlines',
      {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'dc3d106e730c4256b8c275d9da58d090',
      },
    ).then((value){
      sports=value.data['articles'];
      print(sports.length);
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];
  void getScienceData() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      'v2/top-headlines',
      {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'dc3d106e730c4256b8c275d9da58d090',
      },
    ).then((value){
      science=value.data['articles'];
      print(science.length);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  List<dynamic> search = [];
  void getSearchData(String value) {

    emit(NewsSearchLoadingState());
    search=[];

    DioHelper.getData(
      'v2/everything',
      {
        'q': '$value',
        'apiKey': 'dc3d106e730c4256b8c275d9da58d090',
      },
    ).then((value){
      search=value.data['articles'];
      print(search.length);
      emit(NewsSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsSearchErrorState(error.toString()));
    });
  }
}
