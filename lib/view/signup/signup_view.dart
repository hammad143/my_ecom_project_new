import 'package:e_com/util/constants/color_const.dart';
import 'package:e_com/util/constants/main_const.dart';
import 'package:e_com/util/specific_bloc_get.dart';
import 'package:e_com/view/connection_state_widget/connection_state_view.dart';
import 'package:e_com/view/responsive_setup/device_size_config.dart';
import 'package:e_com/view/responsive_setup/device_type_layout.dart';
import 'package:e_com/view/responsive_setup/local_widget_builder.dart';
import 'package:e_com/view/signup/components/custom_text_field.dart';
import 'package:e_com/view/signup/components/form_fields.dart';
import 'package:e_com/viewmodel/events/form_validation_events/validate_signup_form_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController, passController, confirmPassController;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
    confirmPassController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ConnectionStateWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 0, horizontal: kDefaultPadding),
          child: DeviceTypeLayout(
            landscape: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: DeviceSizeConfig.widgetScaleFactor * 80,
                    child: _signupImage(),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormFields(
                      emailController: emailController,
                      passController: passController,
                      isChecked: isChecked,
                      onCheckBoxPress: onCheckBoxPress,
                      confirmPassController: confirmPassController,
                      onRegister: onSignupPress,
                    ),
                  )),
                ],
              ),
            ),
            portrait: Column(
              children: [
                //sign up image
                _signupImage(),
                //Form Fields
                FormFields(
                  emailController: emailController,
                  passController: passController,
                  isChecked: isChecked,
                  onCheckBoxPress: onCheckBoxPress,
                  confirmPassController: confirmPassController,
                  onRegister: onSignupPress,
                ),
                //spacer
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signupImage({String image = "assets/onboard/5.png"}) {
    return Image.asset(image);
  }

  onCheckBoxPress() => setState(() {
        isChecked = !isChecked;
      });

  onSignupPress() async {
    final email = emailController.text;
    final password = passController.text;
    final confirmPass = confirmPassController.text;
    final _box = Hive.box('onbaord');
    _box.put('isOnbaordSeen', false);

    BlocWithType.validateSignUpbloc(context)
        .add(ValidateSignUpFormEvent(email, password, confirmPass, isChecked));
  }
}
