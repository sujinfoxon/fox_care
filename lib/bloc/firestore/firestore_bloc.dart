import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_event.dart';
import 'firestore_state.dart';

class FirestoreBloc extends Bloc<FirestoreEvent, FirestoreState> {
  FirestoreBloc() : super(FirestoreInitial());

  @override
  Stream<FirestoreState> mapEventToState(FirestoreEvent event) async* {
    if (event is SubmitDataEvent) {
      yield FirestoreLoading();
      try {
        await FirebaseFirestore.instance.collection('your_collection').add({
          'text': event.text,
          'createdAt': Timestamp.now(),
        });
        yield FirestoreSuccess();
      } catch (e) {
        yield FirestoreFailure(e.toString());
      }
    }
  }
}
