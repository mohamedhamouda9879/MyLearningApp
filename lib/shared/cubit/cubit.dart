import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning_app/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:my_learning_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:my_learning_app/modules/news_tasks/new_tasks_screen.dart';
import 'package:my_learning_app/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  late Database database;
  IconData fabIcon = Icons.edit;
  bool isBottomSheetShowen = false;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarStates());
  }

  void CreateDataBase() {
    openDatabase('todo.db', version: 1, onCreate: (databse, version) {
      print('database created');
      databse
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT,date TEXT,time TEXT,status TEXT)')
          .then((value) {
        print('table Created');
      }).catchError((error) {
        print('Error when creating table ${error}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('database opend');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseStates());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        emit(AppInsertDatabaseStates());
        getDataFromDatabase(database);
        print('$value inserted successfully');
      }).catchError((error) {
        print('Error when new record inserted ${error.toString()} ');
      });
    });
  }

  void getDataFromDatabase(database)  {
    newtasks=[];
    donetasks=[];
    archivedtasks=[];
    emit(getDatabaseLoadingState());
     database.rawQuery('SELECT * FROM tasks').then((value) {
       value.forEach((element) {
        if(element['status']=='new'){
          newtasks.add(element);
        }else if(element['status']=='done'){
          donetasks.add(element);
        }else{
          archivedtasks.add(element);
        }
       });
       emit(AppGetDatabaseStates());
     });
  }

  void updateData(
      @required String status,
      @required int id,
      )async{
     database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status',id],).then((value) {
          getDataFromDatabase(database);
          emit(AppUpdateDatabaseStates());
     });
  }
  void DeleteData(
      @required int id,
      )async{
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?',[id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseStates());
    });
  }
  void changeBottomSheetState(
    bool isShow,
    IconData icon,
  ) {
    isBottomSheetShowen = isShow;
    fabIcon = icon;
    emit(AppChangeBottonSheetStates());
  }
}
