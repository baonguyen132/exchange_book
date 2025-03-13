import 'package:flutter/material.dart';
import 'package:project_admin/model/UserModal.dart';
import 'package:project_admin/screens/login/widget/widget_button_login.dart';
import 'package:project_admin/screens/login/widget/widget_finger.dart';
import 'package:project_admin/screens/login/widget/wiget_navigator_to_sign_up.dart';
import 'package:project_admin/util/wiget_textfield_custome.dart';

import '../../../util/widget_textfield_password_custome.dart';

class WidgetFormLogin extends StatefulWidget {
  TextEditingController emailController  ;
  TextEditingController passwordController  ;
  bool isSaveFinger ;
  Function () changeSaveFinger ;

  bool isDesktop = false  ;

  WidgetFormLogin({super.key , required this.emailController , required this.passwordController , required this.isSaveFinger , required this.changeSaveFinger , this.isDesktop = false});

  @override
  State<WidgetFormLogin> createState() => _WidgetFormLoginState();
}

class _WidgetFormLoginState extends State<WidgetFormLogin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPre() ;
  }

  initPre() async {
    String? username =  await UserModel.loadUserName();
    setState(() {
      widget.emailController.text =  username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 25),
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
            WigetTextfieldCustome(
              controller: widget.emailController,
              textInputType: TextInputType.emailAddress,
              hint: "Email",
              iconData: Icons.mail,
            ),
            const SizedBox(height: 25,),
            WidgetTextfieldPasswordCustome(controller: widget.passwordController,),
            !widget.isDesktop ? const SizedBox(height: 25,) : Container(),
            !widget.isDesktop ?
            Row(
              mainAxisAlignment: MainAxisAlignment.start ,
              children: [
                Checkbox(
                  value: widget.isSaveFinger,
                  onChanged: (value) {widget.changeSaveFinger() ;},
                ),
                GestureDetector(
                  onTap: () {widget.changeSaveFinger();},
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      "Save your finger?",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                )
              ],
            ) : Container(),
            const SizedBox(height: 25,),
            Row(
              children: [
                Expanded(child:WidgetButtonLogin(handle: () async {
                  UserModel? user = await UserModel.login(widget.emailController.text, widget.passwordController.text);
                  UserModel.saveAccount(widget.emailController.text, widget.passwordController.text) ;
                  UserModel.saveUserData(user!) ;

                  Navigator.pushReplacementNamed(context, "/dashboard");
                },)),
                !widget.isDesktop ? const SizedBox(width: 20,) : Container() ,
                !widget.isDesktop ? WidgetFinger(handle: () {},) : Container()
              ],
            )
          ],
        ),
        const SizedBox(height: 150,),
        WigetNavigatorToSignUp() ,
      ],
    );
  }
}
