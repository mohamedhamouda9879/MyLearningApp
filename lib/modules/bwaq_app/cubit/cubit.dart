import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning_app/models/bwaq/notes_model.dart';
import 'package:my_learning_app/modules/bwaq_app/cubit/states.dart';
import 'package:my_learning_app/shared/network/remote/dio_helper_bwaq.dart';

class BwaqCubit extends Cubit<BwaqState> {
  BwaqCubit() : super(BwaqInitialState());

  static BwaqCubit get(context) => BlocProvider.of(context);
  IconData sufix = Icons.visibility_outlined;
  bool isPasswordShowen = true;

  void changePasswordVisibility() {
    isPasswordShowen = !isPasswordShowen;
    sufix = isPasswordShowen ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(UserChangePasswordVisibilityStates());
  }

  List<NotesModel>? notes;


  void getNotesData() {
    emit(BwaqGetNotesLoadingState());
    DioHelperBwaq.getNotesData(Url: 'notes/getall').then((value) {
      notes = NotesModel.fromJson(value.data) as List<NotesModel>?;

      print('bwaq ${notes![0].text}');
      emit(BwaqGetNotesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(BwaqGetNotesErrorState(error.toString()));
    });
  }

  void insertNote(String note) {
    DioHelperBwaq.postNote(Url: 'notes/insert', data: {'text': note})
        .then((value) {
      print(value);
    })
        .catchError((error) {
      print(error);
    });
  }

  void insertUser(String username,String password,String email) {
    DioHelperBwaq.postNote(Url: 'notes/insert', data: {'Username': username,'Password':password,'Email':email})
        .then((value) {
      print(value);
    })
        .catchError((error) {
      print(error);
    });
  }
}
