import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning_app/layout/shop_app/cubit/cubit.dart';
import 'package:my_learning_app/layout/shop_app/cubit/states.dart';
import 'package:my_learning_app/modules/news_app/search/search_screen.dart';
import 'package:my_learning_app/modules/shop_app/login_screen/shop_login_screen.dart';
import 'package:my_learning_app/modules/shop_app/search/search_screen.dart';
import 'package:my_learning_app/shared/components/components.dart';
import 'package:my_learning_app/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: (){
                NavigateTo(context, ShopSearchScreen());
              }, icon: Icon(Icons.search))
            ],
            title: Text(
              'Hayper',
            ),
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.ChangeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favourites'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'
              ),
            ],
          ),
        );
      },
    );
  }
}
