import 'package:bloc/bloc.dart';
import 'package:e_com/viewmodel/events/firebase_event.dart';
import 'package:e_com/viewmodel/state/firebase_state.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  FirebaseBloc() : super(FirebaseInitialState());

  @override
  Stream<FirebaseState> mapEventToState(FirebaseEvent event) async* {
    yield FirebaseInitialState(
      init: await event.initializeFirebase(),
    );
  }
}
