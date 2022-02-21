import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning_app/shared/components/components.dart';
import 'package:my_learning_app/shared/components/constants.dart';
import 'package:my_learning_app/shared/cubit/cubit.dart';
import 'package:my_learning_app/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var tasks = AppCubit.get(context).newtasks;

        return tasksBuilder(
          tasks: tasks,
        );
      },
    );
  }
}
