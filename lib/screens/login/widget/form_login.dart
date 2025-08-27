import 'package:exchange_book/screens/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/screens/login/widget/widget_button_login.dart';
import 'package:exchange_book/screens/login/widget/widget_finger.dart';
import 'package:exchange_book/screens/login/widget/widget_navigator_to_sign_up.dart';
import 'package:exchange_book/util/widget_text_field_custom.dart';

import '../../../data/ConstraintData.dart';
import '../../../util/widget_text_field_password_custom.dart';

class FormLogin extends StatefulWidget {
  bool isDesktop   ;
  FormLogin({super.key, this.isDesktop = false});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LoginCubit>().loadingUsername() ;

    final state = context.read<LoginCubit>().state;
    emailController = TextEditingController(text: state.email);
    passwordController = TextEditingController(text: state.password);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: const Text(
            "Welcome",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        Column(
          children: [
            WidgetTextFieldCustom(
              controller: emailController,
              textInputType: TextInputType.emailAddress,
              hint: "Email",
              iconData: Icons.mail,
              onChange: (value) => context.read<LoginCubit>().changeEmail(value),
            ),
            const SizedBox(height: 25,),
            WidgetTextFieldPasswordCustom(
              controller: passwordController,
              onChange: (value) => context.read<LoginCubit>().changePassword(value),

              isVisibility: context.read<LoginCubit>().state.isVisibility,
              changeVisibility:() => context.read<LoginCubit>().changeIsVisibility(),
            ),

            if(!widget.isDesktop)
              Column(
                children: [
                  const SizedBox(height: 25,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: context.watch<LoginCubit>().state.isSaveFinger,
                        onChanged: (value) =>  context.read<LoginCubit>().changeIsSaveFinger()
                      ),
                      const Text(
                        "Save your finger?",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),

                ],
              ),
            const SizedBox(height: 25,),
            Row(
              children: [
                Expanded(child:WidgetButtonLogin(handle: () async {
                  UserModel? user = await UserModel.login(emailController.text, passwordController.text);

                  if(context.read<LoginCubit>().state.isSaveFinger) {
                    UserModel.saveAccount(emailController.text, passwordController.text) ;
                    toast("Đã lưu vân tay");
                  }
                  if(user != null) {
                    UserModel.saveUserData(user) ;
                    Navigator.pushReplacementNamed(context, "/dashboard");
                  }
                  else {toast("Lỗi đăng nhập");}

                },)),
                if(!widget.isDesktop)
                  Column(
                    children: [
                      const SizedBox(width: 20,),
                      WidgetFinger(handle: () async {
                        // List<String> data = await UserModel.loadAccount() ;
                        //
                        // bool auth = await Authentication.authenticateUser();
                        // print(auth) ;
                        // if(auth) {
                        //   UserModel? user = await UserModel.login(data[0], data[1]);
                        //   UserModel.saveUserData(user!) ;
                        //   Navigator.pushReplacementNamed(context, "/dashboard");
                        // }
                        // else {
                        //   Fluttertoast.showToast(
                        //     msg: "Vân tay không hợp lệ",
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     gravity: ToastGravity.BOTTOM,
                        //     backgroundColor: Colors.black54,
                        //     textColor: Colors.white,
                        //     fontSize: 16.0,
                        //   );
                        // }
                      },)
                    ],
                  ),
              ],
            )
          ],
        ),
        const SizedBox(height: 150,),
        const WidgetNavigatorToSignUp() ,
      ],
    );
  }
}
