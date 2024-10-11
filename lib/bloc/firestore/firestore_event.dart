import 'package:equatable/equatable.dart';

abstract class FirestoreEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitDataEvent extends FirestoreEvent {
  final String text;

  SubmitDataEvent(this.text);

  @override
  List<Object> get props => [text];
}
