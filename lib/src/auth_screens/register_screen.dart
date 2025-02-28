import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:umbrella_care/AuthUI/login_page.dart';
import 'package:umbrella_care/Models/models.dart';
import 'package:umbrella_care/core/app_core.dart';
import 'package:umbrella_care/core/exceptions/app_exceptions.dart';
import 'package:umbrella_care/core/exceptions/exception_handler.dart';
import 'package:umbrella_care/core/extension/sized_box_extension.dart';
import 'package:umbrella_care/core/firebase_services/firebase_services.dart';
import 'package:umbrella_care/core/shared/widgets/extended_text_button.dart';
import 'package:umbrella_care/core/utils/form_validator.dart';

enum RegisterType {
  patient,
  doctor,
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
    required this.registerType,
  });

  final RegisterType registerType;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _hidePass = true;
  bool _hideConfirmPass = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  CollectionReference students =
      FirebaseFirestore.instance.collection('patients');
  bool _isLoading = false;

  //Patient registration
  registration() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });
        await FirebaseAuthService.registerPatient(
          PatientModel(
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          ),
        ).then(
          (result) {
            SnackbarUtils.showSuccessBar(
              context,
              "Account created successfully",
            );

            setState(() {
              _isLoading = false;
            });

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          },
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (e is WeakPasswordException) {
          SnackbarUtils.showWarningBar(context, e.message);
        } else {
          SnackbarUtils.showErrorBar(context, ExceptionHandler.parseError(e));
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                120.yGap,
                Text(
                  'Create Account',
                  style: AppTextStyle.headerText,
                ),

                40.yGap,

                const SizedBox(height: 20),

                //Name
                CustomTextFormField(
                  textFieldTitle: "Name",
                  controller: _nameController,
                  labelText: 'Your Name',
                  validator: (value) =>
                      FormValidator.validateEmptyField(value, "Name"),
                ),
                20.yGap,

                //Email
                CustomTextFormField(
                  textFieldTitle: "Email",
                  controller: _emailController,
                  labelText: 'Email Address',
                  validator: (value) => FormValidator.validateEmail(value),
                ),

                20.yGap,

                //Pass
                CustomTextFormField(
                  textFieldTitle: "Password",
                  controller: _passwordController,
                  hideText: _hidePass,
                  labelText: 'Password',
                  validator: (value) => FormValidator.validatePassword(value),
                  suffixIcon: _hidePass
                      ? Ionicons.eye_off_outline
                      : Ionicons.eye_outline,
                  onSuffixIconPressed: () => setState(() {
                    _hidePass = !_hidePass;
                  }),
                ),

                20.yGap,

                //Confirm Pass
                CustomTextFormField(
                  textFieldTitle: "Confirm Password",
                  controller: _confirmPasswordController,
                  hideText: _hideConfirmPass,
                  labelText: 'Password',
                  validator: (value) => FormValidator.validateConfirmPassword(
                    value,
                    _passwordController.text,
                  ),
                  suffixIcon: _hideConfirmPass
                      ? Ionicons.eye_off_outline
                      : Ionicons.eye_outline,
                  onSuffixIconPressed: () => setState(() {
                    _hideConfirmPass = !_hideConfirmPass;
                  }),
                ),

                30.yGap,

                //Register Button
                PrimaryButton(
                  onPressed: registration,
                  text: 'Create account',
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 40),

                //Log in
                ExtendedTextButton(
                  prefixText: 'Already have an account?',
                  buttonText: 'Log in',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
