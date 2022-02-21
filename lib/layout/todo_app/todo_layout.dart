import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_learning_app/shared/components/components.dart';
import 'package:my_learning_app/shared/components/constants.dart';
import 'package:my_learning_app/shared/cubit/cubit.dart';
import 'package:my_learning_app/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:my_learning_app/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:my_learning_app/modules/todo_app/news_tasks/new_tasks_screen.dart';

class HomeLayout extends StatelessWidget {
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  var scffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..CreateDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseStates) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scffoldKey,
            appBar: AppBar(
              title: Text(
                '${cubit.titles[cubit.currentIndex]}',
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShowen) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        date: dateController.text,
                        time: timeController.text,
                        title: titleController.text);
                    // insertToDatabase(
                    //         date: dateController.text,
                    //         title: titleController.text,
                    //         time: timeController.text)
                    //     .then((value) {
                    //   getDataFromDatabase(database).then((value) {
                    //     Navigator.pop(context);
                    //     // setState(() {
                    //     //   isBottomSheetShowen = false;
                    //     //   fabIcon = Icons.edit;
                    //     //   tasks = value;
                    //     // });
                    //   });
                    // });
                  }
                } else {
                  scffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                    controller: titleController,
                                    type: TextInputType.text,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return ' this title must be not null';
                                      }
                                      return null;
                                    },
                                    label: 'Task Title',
                                    prefix: Icons.title),
                                SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                    controller: timeController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                      });
                                    },
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return ' this time must be not null';
                                      }
                                      return null;
                                    },
                                    label: 'Task Time',
                                    prefix: Icons.watch_later_outlined),
                                SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                    controller: dateController,
                                    type: TextInputType.datetime,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2030-01-01'),
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return ' this date must be not null';
                                      }
                                      return null;
                                    },
                                    label: 'Task Date',
                                    prefix: Icons.calendar_today),
                              ],
                            ),
                          ),
                        ),
                        elevation: 15.0,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                      false,
                      Icons.edit,
                    );
                  });
                  cubit.changeBottomSheetState(
                    true,
                    Icons.add,
                  );
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
