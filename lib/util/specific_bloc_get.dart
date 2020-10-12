import 'package:e_com/viewmodel/bloc/check_onboard_seen_bloc.dart';
import 'package:e_com/viewmodel/bloc/firebase_bloc.dart';
import 'package:e_com/viewmodel/bloc/input_field_bloc.dart';
import 'package:e_com/viewmodel/bloc/validate_signup_form_bloc.dart';
import 'package:e_com/viewmodel/state/validate_form_state/validate_signup_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocWithType {
  static InputFieldBloc inputValuebloc(ctx) =>
      BlocProvider.of<InputFieldBloc>(ctx);
  static ValidateSignUpFormBloc validateSignUpbloc(ctx) =>
      BlocProvider.of<ValidateSignUpFormBloc>(ctx);
  static FirebaseBloc firebaseBloc(ctx) => BlocProvider.of<FirebaseBloc>(ctx);
  static CheckOnboardSeenBloc checkOnBoardBloc(ctx) =>
      BlocProvider.of<CheckOnboardSeenBloc>(ctx);
}
