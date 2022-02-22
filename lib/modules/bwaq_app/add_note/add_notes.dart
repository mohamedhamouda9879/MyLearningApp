import 'package:flutter/material.dart';
import 'package:my_learning_app/modules/bwaq_app/cubit/cubit.dart';
import 'package:my_learning_app/shared/components/components.dart';

class AddNotes extends StatelessWidget {

  var addNoteController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(onPressed: (){
            BwaqCubit.get(context).insertNote(addNoteController.text);
          }, icon: Icon(Icons.save),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: defaultFormField(controller: addNoteController, type: TextInputType.text,lines: 5, validate: (String? value){
          if (value!.isEmpty) {
            return 'Note must be not null';
          }
          return null;
        }, label: 'Note', prefix: Icons.note),
      ),
    );
  }
}
