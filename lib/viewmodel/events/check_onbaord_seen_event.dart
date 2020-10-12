import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class CheckOnboardSeenEvent<E> extends Equatable {
  CheckOnboardSeenEvent(this.hiveBox,
      {this.key, this.value, this.defaultValue});
  final Box<E> hiveBox;
  final String key;

  final dynamic value;
  final dynamic defaultValue;
  @override
  List<Object> get props => [];
}
