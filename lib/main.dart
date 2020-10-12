import 'package:e_com/util/specific_bloc_get.dart';
import 'package:e_com/view/responsive_setup/device_size_config.dart';
import 'package:e_com/view/signup/components/sign_up_btn.dart';
import 'package:e_com/view/signup/signup_view.dart';
import 'package:e_com/routes/routes.dart';
import 'package:e_com/util/constants/color_const.dart';
import 'package:e_com/view/login/login_view.dart';
import 'package:e_com/view/onboard/onboard_view.dart';
import 'package:e_com/view/responsive_setup/responsive_builder.dart';
import 'package:e_com/viewmodel/bloc/check_onboard_seen_bloc.dart';
import 'package:e_com/viewmodel/bloc/page_bloc/page_change_bloc.dart';
import 'package:e_com/viewmodel/bloc/validate_signup_form_bloc.dart';
import 'package:e_com/viewmodel/events/check_onbaord_seen_event.dart';
import 'package:e_com/viewmodel/state/check_onboard_seen_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('onbaord');

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool seen = false;
  int count = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    //Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ValidateSignUpFormBloc()),
            BlocProvider(create: (context) => PageChangeBloc()),
            BlocProvider(create: (context) => CheckOnboardSeenBloc()),
          ],
          child: MaterialApp(
            theme: ThemeData(
              primaryColor: kPrimaryColor,
            ),
            initialRoute: Routes.initial,
            routes: {
              Routes.login: (ctx) => Login(),
              Routes.signup: (ctx) => SignUp(),
              Routes.onboard: (ctx) => OnBoardView(),
              Routes.initial: (ctx) => MainScreen(),
            },
          ),
        );
      },
    );

    //return ResponsiveBuilder(builder: (ctx) {});
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("LayoutBuilder->MaterialApp -> MainScreen");
    print(context.deviceSize.orientation);
    return SignUp();
    /*  if (_checkFirstScreen(context))
      return SignUp();
    else
      return OnBoardView(); */
  }

  bool _checkFirstScreen(BuildContext ctx) {
    final _hivebox = Hive.box('onbaord');
    bool seen = _hivebox.get('check on board screen', defaultValue: false);

    return seen;
  }
}
