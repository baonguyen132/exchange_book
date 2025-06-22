import 'dart:math';

import 'package:exchange_book/screens/signup/cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/screens/signup/widget/widget_button_sign_up.dart';
import 'package:exchange_book/screens/signup/widget/widget_scan_qr_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/UserModal.dart';
import '../../../util/widget_textfield_password_custome.dart';
import '../../../util/wiget_textfield_custome.dart';
import '../../checkopt/check_otp.dart';


class FormSignUp extends StatefulWidget {

  const FormSignUp({super.key});

  @override
  State<FormSignUp> createState() => _FormSignUpState();
}

class _FormSignUpState extends State<FormSignUp> {

  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController checkPasswordController;
  late final TextEditingController dobController;
  late final TextEditingController numberIdController;
  late final TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    final state = context.read<SignUpCubit>().state;
    fullNameController = TextEditingController(text: state.fullName);
    emailController = TextEditingController(text: state.email);
    passwordController = TextEditingController(text: state.password);
    checkPasswordController = TextEditingController(text: state.checkPassword);
    dobController = TextEditingController(text: state.dob);
    numberIdController = TextEditingController(text: state.numberId);
    addressController = TextEditingController(text: state.address);
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    checkPasswordController.dispose();
    dobController.dispose();
    numberIdController.dispose();
    addressController.dispose();
    super.dispose();
  }

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
        const SizedBox(height: 25),
        WidgetScanQrCode(handleScanQR: (data) {
          context.read<SignUpCubit>().handleQRCode(data);

          numberIdController.text = context.read<SignUpCubit>().state.numberId ;
          fullNameController.text = context.read<SignUpCubit>().state.fullName ;
          dobController.text = context.read<SignUpCubit>().state.dob;
          addressController.text = context.read<SignUpCubit>().state.address;

        },),
        const SizedBox(height: 25),
        WigetTextfieldCustome(
          controller: fullNameController,
          textInputType: TextInputType.name,
          hint: "FullName",
          iconData: Icons.person,
          onChange: (value) => context.read<SignUpCubit>().changeFullName(value),
        ),
        const SizedBox(height: 25),
        WigetTextfieldCustome(
          controller: emailController,
          textInputType: TextInputType.emailAddress,
          hint: "Email",
          iconData: Icons.email,
          onChange: (value) => context.read<SignUpCubit>().changeEmail(value),
        ),
        const SizedBox(height: 25),
        WidgetTextfieldPasswordCustome(
          controller: passwordController,
          onChange: (value) => context.read<SignUpCubit>().changePassword(value),
        ),
        const SizedBox(height: 25),
        WidgetTextfieldPasswordCustome(
          controller: checkPasswordController,
          hint: "Check Password",
          onChange: (value) => context.read<SignUpCubit>().changeCheckPassword(value),
        ),
        const SizedBox(height: 25),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  WigetTextfieldCustome(
                    controller: dobController,
                    textInputType: TextInputType.datetime,
                    hint: "DDMMYYYY",
                    iconData: Icons.edit_calendar,
                    onChange: (value) {
                      context.read<SignUpCubit>().changeDob(value);
                      if (value.length == 8) dobController.text = context.read<SignUpCubit>().state.dob ;

                    },
                  ),
                  const SizedBox(height: 25),
                  WigetTextfieldCustome(
                    controller: numberIdController,
                    textInputType: TextInputType.number,
                    hint: "Number Id",
                    iconData: Icons.perm_identity_rounded,
                    onChange: (value) => context.read<SignUpCubit>().changeNumberId(value),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),

            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Gender",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(context.read<SignUpCubit>().state.gender == "Femail" ? Icons.female : Icons.male),
                      const SizedBox(width: 10,),
                      Text(context.read<SignUpCubit>().state.gender) ,
                    ],
                  )
                ]
            )

          ],
        ),
        const SizedBox(height: 25),
        WigetTextfieldCustome(
          controller: addressController,
          textInputType: TextInputType.streetAddress,
          hint: "Address",
          iconData: Icons.account_box_rounded,
          onChange: (value) => context.read<SignUpCubit>().changeAddress(value),
        ),
        const SizedBox(height: 25),
        WidgetButtonSignUp(
          handle: () async {
            final random = Random();
            final number = 100000 + random.nextInt(900000);

            UserModel.sendCodeOtp(emailController.text, number) ;

            bool data = await Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOtp(number: number,email: emailController.text,),));

            if (data) {
              UserModel newUser = UserModel(
                name: fullNameController.text,
                email: emailController.text,
                password: passwordController.text,
                cccd: numberIdController.text,
                dob: dobController.text,
                gender: context.read<SignUpCubit>().state.gender,
                address: addressController.text,
                point: '50000',
              );
              UserModel.registerUser(newUser ,() {
                Navigator.pop(context);
              },) ;
            }
          },
        ),
      ],
    );
  }
}