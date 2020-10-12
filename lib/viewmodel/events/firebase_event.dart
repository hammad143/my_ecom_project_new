import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseEvent extends Equatable {
  final Future<FirebaseApp> Function({String name, FirebaseOptions options})
      initializeFirebase;

  FirebaseEvent(this.initializeFirebase);
  @override
  List<Object> get props => [];
}
