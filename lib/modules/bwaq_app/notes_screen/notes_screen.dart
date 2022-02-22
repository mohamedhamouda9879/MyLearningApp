import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning_app/modules/bwaq_app/add_note/add_notes.dart';
import 'package:my_learning_app/modules/bwaq_app/add_user/add_user.dart';
import 'package:my_learning_app/modules/bwaq_app/cubit/cubit.dart';
import 'package:my_learning_app/modules/bwaq_app/cubit/states.dart';
import 'package:my_learning_app/shared/components/components.dart';

class NotesScreen extends StatelessWidget {
  var searchtextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BwaqCubit, BwaqState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  NavigateTo(context, AddUser());
                },
                icon: Icon(Icons.group_add),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.list),
              ),
            ],
            title: Text('Notes'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                //Icon(Icons.search),
                defaultFormField(
                  controller: searchtextController,
                  type: TextInputType.text,
                  validate: (String? value) {

                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
               /*ConditionalBuilder(
                  condition: BwaqCubit
                      .get(context)
                      .notes != null,
                  builder:(context) => Container(child: Text(BwaqCubit.get(context).notes.,),),
                  fallback:(context) => Center(child: CircularProgressIndicator()),),*/
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {

              NavigateTo(context, AddNotes());
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },

    );
  }
}
