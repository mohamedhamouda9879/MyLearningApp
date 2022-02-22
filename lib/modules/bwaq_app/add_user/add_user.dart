import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_learning_app/modules/bwaq_app/cubit/cubit.dart';
import 'package:my_learning_app/shared/components/components.dart';

import 'get_image.dart';

enum ImageSourceType { gallery, camera }

class AddUser extends StatefulWidget {

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  var username = TextEditingController();

  var password = TextEditingController();

  var email = TextEditingController();

  bool isPassword = true;

  final ImagePicker  _picker = ImagePicker();

  File? _image;

  ImagePicker picker = ImagePicker();

  Future getImagefromGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image as File?;
    });
  }
  void _handleURLButtonPress(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: InkWell(
                        onTap: getImagefromGallery,
                        child: MaterialButton(
                          color: Colors.blue,
                          child: Text(
                            "Pick Image from Gallery",
                            style: TextStyle(
                                color: Colors.white70, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            _handleURLButtonPress(context, ImageSourceType.gallery);
                          },
                        )
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(child: Text('Select Image',),)
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            defaultFormField(
              controller: username,
              type: TextInputType.text,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'username must be not null';
                }
                return null;
              },
              label: 'Username',
              prefix: Icons.person,
            ),
            SizedBox(
              height: 20.0,
            ),
            defaultFormField(
                controller: password,
                type: TextInputType.visiblePassword,
                validate: (String? value) {
                  if (value!.length < 8) {
                    return 'Password should have aphabet and numbers with minimum length of 8 chars';
                  }
                  return null;
                },
                label: 'Password',
                prefix: Icons.lock),
            SizedBox(
              height: 20.0,
            ),
            defaultFormField(
              controller: email,
              type: TextInputType.emailAddress,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'username must be not null';
                }
                return null;
              },
              label: 'Email',
              prefix: Icons.email,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: double.infinity,
              child: TextButton(

                onPressed: () {
                  BwaqCubit.get(context).insertUser(username.text,password.text,email.text);
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white,),
                ),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
