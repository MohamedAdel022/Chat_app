import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/screens/chat_page.dart';
import 'package:scholar_chat/screens/cubits/cubit/chat_cubit.dart';
import 'package:scholar_chat/screens/cubits/login_cubit/login_cubit.dart';
import 'package:scholar_chat/screens/register_page.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class LoginPage extends StatelessWidget {
  static String id = 'LoginPage';

  String? emailAddress;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },

      // ...

      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            isLoading = true;
          } else if (state is LoginSuccess) {
            BlocProvider.of<ChatCubit>(context).getMessages();
            Navigator.pushNamed(context, ChatPage.id, arguments: emailAddress);
            isLoading = false;
            showSnackBar(context, message: 'Login successful');
          } else if (state is LoginFaliure) {
            showSnackBar(context, message: state.message);
            isLoading = false;
          }

          isLoading = false;
        },
        builder: (context, state) => ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(
                        flex: 1,
                      ),
                      Image(
                        image: AssetImage(klogo),
                      ),
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'pacifico',
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Row(
                        children: [
                          Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      CustomFormTextField(
                          onChanged: (value) {
                            emailAddress = value;
                          },
                          label: 'Username'),
                      SizedBox(height: 16),
                      PasswordCustomTextField(
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(height: 16),
                      CustomButtom(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<LoginCubit>(context).signInUser(
                                  emailAddress: emailAddress!,
                                  password: password!);
                            } else {
                              showSnackBar(context,
                                  message: 'Invalid credentials');
                            }
                          },
                          text: Text(
                            'Login',
                          )),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RegisterPage.id);
                            },
                            child: Text(
                              " Sign up",
                              style: TextStyle(
                                  color: Color(0xffD7F2EC), fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Spacer(
                        flex: 3,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInUser() async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress!, password: password!);
    print(credential.user!.email);
  }
}
