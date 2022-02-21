import 'package:flutter/material.dart';
import 'package:my_learning_app/models/user/user_model.dart';

class UsersScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(id: 1, phone: '01110255256', name: 'mohamed ali'),
    UserModel(id: 2, phone: '01010255256', name: 'ali ali'),
    UserModel(id: 3, phone: '01210255256', name: 'ziko ali'),
    UserModel(id: 5, phone: '011111025556', name: 'noha ali'),
    UserModel(id: 6, phone: '01110255256', name: 'mohamed ali'),
    UserModel(id: 7, phone: '01010255256', name: 'ali ali'),
    UserModel(id: 8, phone: '01210255256', name: 'ziko ali'),
    UserModel(id: 9, phone: '011111025556', name: 'noha ali'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Users'),
        ),
        body: ListView.separated(
            itemBuilder: (ctx, index) => buildUserItem(users[index]),
            separatorBuilder: (ctx, index) => Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ),
            itemCount: users.length));
  }

  Widget buildUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              child: Text(
                '${user.id}',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${user.phone}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
