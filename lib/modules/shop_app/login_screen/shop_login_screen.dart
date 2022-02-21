import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_learning_app/layout/shop_app/shop_app_layout.dart';
import 'package:my_learning_app/modules/shop_app/login_screen/cubit/cubit.dart';
import 'package:my_learning_app/modules/shop_app/login_screen/cubit/states.dart';
import 'package:my_learning_app/modules/shop_app/register_screen/shop_register_screen.dart';
import 'package:my_learning_app/shared/components/components.dart';
import 'package:my_learning_app/shared/components/constants.dart';
import 'package:my_learning_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) async{
          if (state is ShopLoginSucessStates){
            if (state.shopLoginModel.status) {
              print(state.shopLoginModel.message);
              print(state.shopLoginModel.data.token);
              CacheHelper.saveData(
                  key: 'token', value: state.shopLoginModel.data.token)
                  .then((value) {
                    TOKEN= state.shopLoginModel.data.token;
                NavigateAndFinish(context, ShopLayout());
              });
              showToast(
                  message: state.shopLoginModel.message,
                  toastStates: ToastStates.SUCCESS);
            } else
            {
              print('hamouda');
              print(state.shopLoginModel.message);
              showToast(
                  message: state.shopLoginModel.message,
                  toastStates: ToastStates.EROOR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login',
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: Colors.black,
                                    )),
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Login Now to browse out hot offer ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty)
                              return 'Please Enter Your Email Address';
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          isPassword:
                              ShopLoginCubit.get(context).isPasswordShowen,
                          type: TextInputType.visiblePassword,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).UserLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) return 'Password is Too Short';
                          },
                          label: 'Password',
                          suffix: ShopLoginCubit.get(context).sufix,
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingStates,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).UserLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'Login',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              function: () {
                                NavigateTo(context, ShopRegisterScreen());
                              },
                              text: 'Register',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
