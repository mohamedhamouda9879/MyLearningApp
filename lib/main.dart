import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_learning_app/layout/home_layout.dart';
import 'package:my_learning_app/modules/bmi/bmi_calculator.dart';
import 'package:my_learning_app/modules/bmi/bmi_result_screen.dart';
import 'package:my_learning_app/modules/home/home_screen.dart';
import 'package:my_learning_app/modules/login/login_screen.dart';
import 'package:my_learning_app/modules/messenger/massenger_screen.dart';
import 'package:my_learning_app/modules/news_tasks/new_tasks_screen.dart';
import 'package:my_learning_app/shared/bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeLayout(),
    );
  }
}
