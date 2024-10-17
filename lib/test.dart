/*
// patient_registration.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'patient_bloc.dart';
import 'patient_event.dart';
import 'patient_state.dart';

class PatientRegistration extends StatefulWidget {
  @override
  State<PatientRegistration> createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController phone1Controller = TextEditingController();
  final TextEditingController phone2Controller = TextEditingController();

  String selectedSex = 'Male';
  String selectedBloodGroup = 'A+';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientBloc(FirebaseFirestore.instance),
      child: Scaffold(
        appBar: AppBar(title: Text('Patient Registration')),
        body: BlocListener<PatientBloc, PatientState>(
          listener: (context, state) {
            if (state is PatientLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Registering Patient...')),
              );
            } else if (state is PatientSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Patient Registered Successfully')),
              );
            } else if (state is PatientFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(controller: firstNameController, hintText: 'First Name'),
                  CustomTextField(controller: middleNameController, hintText: 'Middle Name'),
                  CustomTextField(controller: lastNameController, hintText: 'Last Name'),
                  customDropdown('Sex', ['Male', 'Female', 'Other'], selectedSex, (value) {
                    setState(() {
                      selectedSex = value!;
                    });
                  }),
                  CustomTextField(controller: ageController, hintText: 'Age'),
                  CustomTextField(controller: dobController, hintText: 'DOB (YYYY-MM-DD)'),
                  CustomTextField(controller: address1Controller, hintText: 'Address Line 1'),
                  CustomTextField(controller: address2Controller, hintText: 'Address Line 2'),
                  CustomTextField(controller: cityController, hintText: 'City'),
                  CustomTextField(controller: stateController, hintText: 'State'),
                  CustomTextField(controller: pincodeController, hintText: 'Pincode'),
                  CustomTextField(controller: phone1Controller, hintText: 'Phone Number 1'),
                  CustomTextField(controller: phone2Controller, hintText: 'Phone Number 2'),
                  customDropdown('Blood Group', ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'], selectedBloodGroup, (value) {
                    setState(() {
                      selectedBloodGroup = value!;
                    });
                  }),
                  SizedBox(height: 20),
                  Center(
                    child: CustomButton(
                      label: 'Register',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final patientData = {
                            'firstName': firstNameController.text,
                            'middleName': middleNameController.text,
                            'lastName': lastNameController.text,
                            'sex': selectedSex,
                            'age': ageController.text,
                            'dob': dobController.text,
                            'address1': address1Controller.text,
                            'address2': address2Controller.text,
                            'city': cityController.text,
                            'state': stateController.text,
                            'pincode': pincodeController.text,
                            'phone1': phone1Controller.text,
                            'phone2': phone2Controller.text,
                            'bloodGroup': selectedBloodGroup,
                          };
                          BlocProvider.of<PatientBloc>(context)
                              .add(PatientFormSubmitted(formData: patientData));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

 */