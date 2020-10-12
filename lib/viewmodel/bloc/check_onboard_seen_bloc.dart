import 'package:bloc/bloc.dart';
import 'package:e_com/viewmodel/events/check_onbaord_seen_event.dart';
import 'package:e_com/viewmodel/state/check_onboard_seen_state.dart';

class CheckOnboardSeenBloc
    extends Bloc<CheckOnboardSeenEvent, CheckOnBoardSeenState> {
  CheckOnboardSeenBloc() : super(OnBoardToBeSeen());

  @override
  Stream<CheckOnBoardSeenState> mapEventToState(
      CheckOnboardSeenEvent event) async* {
    final _box = event.hiveBox;
    final value = _box.get(event.key);

    print("Event value ${event.value}");
    if (value != null && value == true)
      yield OnBoardAlreadySeen();
    else if (event.value != null) {
      _box.put(event.key, event.value);
      yield OnBoardAlreadySeen();
    } else
      yield OnBoardToBeSeen();
  }
}

/* 
  1) Main Method checks state
 */
