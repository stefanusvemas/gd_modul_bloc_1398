import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gd_modul_bloc_1398/bloc/form_submission_state.dart';
import 'package:gd_modul_bloc_1398/bloc/login_event.dart';
import 'package:gd_modul_bloc_1398/bloc/login_state.dart';
import 'package:gd_modul_bloc_1398/repository/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final LoginRepository loginRepository = LoginRepository();
  LoginBloc() : super(LoginState()){
    on<IsPasswordVisibleChanged>((event, emit) => _onIsPasswordVisibleChanged(event, emit));
    on<FormSubmitted>((event, emit) => _onFormSubmitted(event, emit));
  }
  void _onIsPasswordVisibleChanged(
    IsPasswordVisibleChanged event, Emitter<LoginState> emit){
      emit(state.coptWith(
        isPasswordVisible: !state.isPasswordVisible,
        formSubmissionState: const InitialFormState(),
      ));
    }

  void _onFormSubmitted(FormSubmitted event, Emitter<LoginState> emit) async{
    emit(state.coptWith(formSubmissionState: FormSubmitting()));
    try{
      await loginRepository.login(event.username, event.password);
      emit(state.coptWith(formSubmissionState: SubmissionSuccess()));
    } on FailedLogin catch (e){
      emit(state.coptWith(formSubmissionState: SubmissionFailed(e.errorMessage())));
    } on String catch (e){
      emit(state.coptWith(formSubmissionState: SubmissionFailed(e)));
    }catch (e){
      emit(state.coptWith(formSubmissionState: SubmissionFailed(e.toString())));
    }
  }
}