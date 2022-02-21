import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning_app/layout/news_app/cubit/cubit.dart';
import 'package:my_learning_app/layout/news_app/cubit/states.dart';
import 'package:my_learning_app/modules/news_app/search/search_screen.dart';
import 'package:my_learning_app/shared/components/components.dart';
import 'package:my_learning_app/shared/cubit/cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(onPressed: (){
                  NavigateTo(context, SearchScreen(),);
                }, icon: Icon(Icons.search)),
                IconButton(onPressed: (){
                  AppCubit.get(context).ChangeAppMode();
                }, icon: Icon(Icons.brightness_4_outlined))
              ],
              title: Text(
                'News App',
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){

                cubit.ChangeBottomNavBar(index);
              },
              items: cubit.bottomItems,
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      );
  }
}
