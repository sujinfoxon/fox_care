// patient_state.dart
abstract class PatientFormState {}

class PatientFormInitial extends PatientFormState {}

class FormSubmitting extends PatientFormState {}

class FormSubmitSuccess extends PatientFormState {}

class FormSubmitFailure extends PatientFormState {
  final String error;

  FormSubmitFailure(this.error);
}
