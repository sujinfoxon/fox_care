import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      await submitPatientData(event, emit);
    } catch (e) {
      emit(FormSubmitFailure(e.toString())); // Emit failure state with the error message
    }
  }

  Future<void> submitPatientData(SubmitForm event, Emitter<PatientFormState> emit) async {
    CollectionReference patientsCollection = _firestore.collection('patients');
    User? user = FirebaseAuth.instance.currentUser;  // Get the current logged-in user

    // Query to check if a patient with the same exact data already exists
    QuerySnapshot existingPatient = await patientsCollection
        .where('firstname', isEqualTo: event.firstname)
        .where('lastname', isEqualTo: event.lastname)
        .where('middlename', isEqualTo: event.middlename)
        .where('dob', isEqualTo: event.dob)
        .where('age', isEqualTo: event.age)
        .where('address1', isEqualTo: event.address1)
        .where('address2', isEqualTo: event.address2)
        .where('landmark', isEqualTo: event.landmark)
        .where('city', isEqualTo: event.city)
        .where('state', isEqualTo: event.state)
        .where('pincode', isEqualTo: event.pincode)
        .where('phone1', isEqualTo: event.phone1)
        .where('phone2', isEqualTo: event.phone2)
        .where('sex', isEqualTo: event.sex)
        .where('bloodGroup', isEqualTo: event.bloodGroup)
        .where('opNumber', isEqualTo: event.opNumber)
        .get();

    if (existingPatient.docs.isNotEmpty) {
      // Data with the exact same fields already exists
      emit(FormSubmitDuplicate());  // Emit a new state for duplicates
      return;
    }

    // If no record with the same data exists, save the new patient record
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
      'opNumber': event.opNumber,
      'Createdon': DateTime.now(),
      'Employeid': user?.email,
    });

    emit(FormSubmitSuccess());  // Emit success state when data is saved
  }
}
