import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/screens/checkopt/check_otp.dart';
import 'package:project_admin/screens/signup/widget/widget_button_sign_up.dart';
import 'package:project_admin/screens/signup/widget/wiget_choose_gender.dart';
import 'package:project_admin/screens/signup/widget/wiget_scan_qr_code.dart';

import '../../../data/ConstraintData.dart';
import '../../../model/UserModal.dart';
import '../../../util/widget_textfield_password_custome.dart';
import '../../../util/wiget_textfield_custome.dart';

import 'package:http/http.dart' as http;


class WidgetFormSignUp extends StatefulWidget {
  TextEditingController emailController  ;
  TextEditingController fullnameController  ;

  TextEditingController passwordController  ;
  TextEditingController checkPasswordController  ;

  TextEditingController dobController  ;
  TextEditingController numberIdController  ;

  TextEditingController addressController  ;

  String gender = "Male" ;

  WidgetFormSignUp({super.key, required this.emailController , required this.fullnameController , required this.passwordController , required this.checkPasswordController , required this.dobController , required this.numberIdController , required this.addressController});

  @override
  State<WidgetFormSignUp> createState() => _WidgetFormSignUpState();
}

class _WidgetFormSignUpState extends State<WidgetFormSignUp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 45,
          child: const Text(
            "Sign up",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 25,),
        WigetScanQrCode(hanldeScanQR: (data) {
          print(data);
          List<String> arrayData = data.split("|") ;
          setState(() {
            widget.numberIdController.text = arrayData[0] ;
            widget.fullnameController.text = arrayData[2] ;
            widget.dobController.text = formatIDToDate(arrayData[3]);
            if (arrayData[4] == "Nam") {widget.gender = "Male";} else {widget.gender = "Female" ;}
            widget.addressController.text = arrayData[5] ;
          });

        },),
        const SizedBox(height: 25,),
        WigetTextfieldCustome(controller: widget.fullnameController, textInputType: TextInputType.name, hint: "Fullname", iconData: Icons.person),
        const SizedBox(height: 25,),
        WigetTextfieldCustome(controller: widget.emailController, textInputType: TextInputType.emailAddress, hint: "Email", iconData: Icons.email),
        const SizedBox(height: 25,),
        WidgetTextfieldPasswordCustome(controller: widget.passwordController),
        const SizedBox(height: 25,),
        WidgetTextfieldPasswordCustome(controller: widget.checkPasswordController, hint: "Check Password",),
        const SizedBox(height: 25,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  WigetTextfieldCustome(
                      controller: widget.dobController,
                      textInputType: TextInputType.datetime,
                      hint: "DDMMYYYY",
                      iconData: Icons.edit_calendar,
                      onChange: (value) {
                        if (value.length == 8) {
                          String formatted = formatIDToDate(value);
                          setState(() {
                            widget.dobController.text = formatted;
                          });
                        }
                      },
                  ),
                  const SizedBox(height: 25,),
                  WigetTextfieldCustome(controller: widget.numberIdController, textInputType: TextInputType.number, hint: "Number Id", iconData: Icons.perm_identity_rounded),
                ],
              ),
            ),
            const SizedBox(width: 20,) ,
            WigetChooseGender(currentOption: widget.gender , handle: (data) {
              setState(() {
                widget.gender = data ;
              });
            },)
          ],
        ),
        const SizedBox(height: 25,),
        WigetTextfieldCustome(controller: widget.addressController, textInputType: TextInputType.streetAddress, hint: "Address", iconData: Icons.account_box_rounded),
        const SizedBox(height: 25,),
        WidgetButtonSignUp(handle: () async {

          Random random = Random();
          int number =  100000 + random.nextInt(900000);

          UserModel.sendCodeOtp(widget.emailController.text, number) ;

          bool data = await Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOtp(number: number,email: widget.emailController.text,),));
          if (data) {
            UserModel newUser = UserModel(
              name: widget.fullnameController.text,
              email: widget.emailController.text,
              password: widget.passwordController.text,
              cccd: widget.numberIdController.text,
              dob: widget.dobController.text,
              gender: widget.gender,
              address: widget.addressController.text,
            );
            UserModel.registerUser(newUser ,() {
              Navigator.pop(context);
            },) ;
          }
        },)

      ],
    );
  }
}