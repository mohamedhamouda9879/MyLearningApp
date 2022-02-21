import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning_app/layout/shop_app/cubit/cubit.dart';
import 'package:my_learning_app/layout/shop_app/cubit/states.dart';
import 'package:my_learning_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );  }
}
