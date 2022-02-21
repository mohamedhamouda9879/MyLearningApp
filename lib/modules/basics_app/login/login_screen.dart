import 'package:flutter/material.dart';
import 'package:my_learning_app/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultFormField(
                    prefix: Icons.email,
                    type: TextInputType.emailAddress,
                    label: 'Email Address',
                    controller: emailController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Email must be not null';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                    prefix: Icons.lock,
                    type: TextInputType.visiblePassword,
                    label: 'Password',
                    isPassword: isPassword,
                    suffixPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    suffix:
                        isPassword ? Icons.visibility : Icons.visibility_off,
                    controller: passwordController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'password must be not null';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                      text: 'Login',
                      radius: 10.0,
                      function: () {
                        if (formKey.currentState!.validate()) {
                          print(emailController.text);
                        }
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account'),
                      TextButton(
                        onPressed: () {},
                        child: Text('Register now'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
