import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foxcare_app/bloc/patient/patient_event.dart';
import 'package:foxcare_app/bloc/patient/patient_state.dart';

class PatientFormBloc extends Bloc<PatientEvent, PatientFormState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  PatientFormBloc() : super(PatientFormInitial()) {
    on<SubmitForm>(_onSubmitForm); // Register the event handler here
  }

  Future<void> _onSubmitForm(SubmitForm event, Emitter<PatientFormState> emit) async {
    emit(FormSubmitting());
    try {
      await submitPatientData(event);
      emit(FormSubmitSuccess());
    } catch (e) {
      emit(FormSubmitFailure(e.toString()));
    }
  }

  Future<void> submitPatientData(SubmitForm event) async {
    CollectionReference patientsCollection = _firestore.collection('patients');

    await patientsCollection.add({
      'firstname': event.firstname,
      'lastname': event.lastname,
      'middlename': event.middlename,
      'dob': event.dob,
      'age': event.age,
      'address1': event.address1,
      'address2': event.address2,
      'landmark': event.landmark,
      'city': event.city,
      'state': event.state,
      'pincode': event.pincode,
      'phone1': event.phone1,
      'phone2': event.phone2,
      'sex': event.sex,
      'bloodGroup': event.bloodGroup,
    });
  }
}
