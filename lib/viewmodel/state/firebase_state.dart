import 'package:e_com/viewmodel/events/firebase_event.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseState extends Equatable {
  @override
  List<Object> get props => [];
}

class FirebaseInitialState extends FirebaseState {
  final FirebaseApp init;
  FirebaseInitialState({this.init});
}
