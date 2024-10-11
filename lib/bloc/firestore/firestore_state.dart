import 'package:equatable/equatable.dart';

abstract class FirestoreState extends Equatable {
  @override
  List<Object> get props => [];
}

class FirestoreInitial extends FirestoreState {}

class FirestoreLoading extends FirestoreState {}

class FirestoreSuccess extends FirestoreState {}

class FirestoreFailure extends FirestoreState {
  final String error;

  FirestoreFailure(this.error);

  @override
  List<Object> get props => [error];
}
