import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget{
  final double screenHeight;
  final TextEditingController emailController;
  const ForgetPassword({Key key,this.screenHeight,this.emailController}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey;

    return Container(
      height: screenHeight * 0.25,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Forget Password",
              //style: Styles.instance.defaultTitleStyle,
            ),
            const SizedBox(
              height: 60,
            ),
            MyTextFormField(
              maxLine: 1,
              controller: this.emailController,
              label: 'Email',
              textInputType: TextInputType.emailAddress,
              prefixIcon: Icon(
                Icons.email,
                // color: Styles.instance.formPrefixIconColor,
                // size: Styles.instance.defaultPrefixIconSize,
              ),
              //validator: checkEmail,
            ),
          ],
        ),
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final Widget prefixIcon;
  final Function validator;
  final TextInputType textInputType;
  final bool showPassword;
  final int maxLine;
  const MyTextFormField({
    Key key,
    this.label,
    this.hint,
    this.controller,
    this.prefixIcon,
    this.validator,
    this.textInputType,
    this.showPassword,
    this.maxLine
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: this.validator,
      controller: this.controller,
      keyboardType: this.textInputType,
      obscureText: this.showPassword ?? false,
      maxLines: this.maxLine,
      decoration: InputDecoration(
        hintText: this.hint,
        prefixIcon: this.prefixIcon,
        labelText: this.label,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
}