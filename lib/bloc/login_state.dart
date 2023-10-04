import 'package:gd_modul_bloc_1398/bloc/form_submission_state.dart';

class LoginState{
  final bool isPasswordVisible;
  final FormSubmissionState formSubmissionState;

  LoginState({
    this.isPasswordVisible = false,
    this.formSubmissionState = const InitialFormState(),
  });

  LoginState coptWith({
    bool? isPasswordVisible,
    FormSubmissionState? formSubmissionState,
  }){
    return LoginState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      formSubmissionState: formSubmissionState ?? this.formSubmissionState,
    );
  }
}