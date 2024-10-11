// patient_event.dart
abstract class PatientEvent {}

class SubmitForm extends PatientEvent {
  final String firstname;
  final String lastname;
  final String middlename;
  final String dob;
  final String age;
  final String address1;
  final String address2;
  final String landmark;
  final String city;
  final String state;
  final String pincode;
  final String phone1;
  final String phone2;
  final String sex;
  final String bloodGroup;

  SubmitForm({
    required this.firstname,
    required this.lastname,
    required this.middlename,
    required this.dob,
    required this.age,
    required this.address1,
    required this.address2,
    required this.landmark,
    required this.city,
    required this.state,
    required this.pincode,
    required this.phone1,
    required this.phone2,
    required this.sex,
    required this.bloodGroup,
  });
}
