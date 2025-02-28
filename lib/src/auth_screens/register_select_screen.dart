import 'package:flutter/material.dart';
import 'package:umbrella_care/AuthUI/doctorRegistration.dart';
import 'package:umbrella_care/AuthUI/login_page.dart';
import 'package:umbrella_care/core/app_core.dart';
import 'package:umbrella_care/core/extension/sized_box_extension.dart';
import 'package:umbrella_care/core/shared/widgets/extended_text_button.dart';
import 'package:umbrella_care/src/auth_screens/register_screen.dart';

class RegisterSelectScreen extends StatelessWidget {
  const RegisterSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Logo
                    const Align(
                      alignment: Alignment.center,
                      child: AppLogo(),
                    ),

                    100.yGap,

                    //Text
                    Text(
                      'Simple Healthcare',
                      style: AppTextStyle.headerText,
                    ),

                    //Text
                    Text(
                      'Trust us with your precious health\nLifestyle',
                      style: AppTextStyle.regularText,
                      textAlign: TextAlign.center,
                    ),

                    80.yGap,

                    //Patient Button
                    PrimaryButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(
                            registerType: RegisterType.patient,
                          ),
                        ),
                      ),
                      text: 'As a patient',
                    ),

                    15.yGap,

                    PrimaryOutlinedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorRegistration(),
                        ),
                      ),
                      text: 'As a doctor',
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ExtendedTextButton(
                  prefixText: 'Already have an account?',
                  buttonText: 'Log in',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
