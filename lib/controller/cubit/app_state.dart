part of 'app_cubit.dart';

sealed class AppState {}

final class AppInitial extends AppState {}

final class GetPurposeDataLoading extends AppState {}

final class GetPurposeDataScucess extends AppState {}

final class GetPurposeDataError extends AppState {
  final String error;

  GetPurposeDataError(this.error);
}

final class GetMaterialDataLoading extends AppState {}

final class GetMaterialDataScucess extends AppState {}

final class GetMaterialDataError extends AppState {
  final String error;

  GetMaterialDataError(this.error);
}

final class GetSubscriptionDataLoading extends AppState {}

final class GetSubscriptionDataScucess extends AppState {}

final class GetSubscriptionDataError extends AppState {
  final String error;

  GetSubscriptionDataError(this.error);
}

final class GetDayDataLoading extends AppState {}

final class GetDayDataScucess extends AppState {}

final class GetDayDataError extends AppState {
  final String error;

  GetDayDataError(this.error);
}

final class ChangeRole extends AppState {}

final class PostFormLoading extends AppState {}

final class PostFormScucess extends AppState {}

final class PostFormError extends AppState {
  final String error;

  PostFormError(this.error);
}

final class PostClassFormLoading extends AppState {}

final class PostClassFormScucess extends AppState {}

final class PostClassFormError extends AppState {
  final String error;

  PostClassFormError(this.error);
}

final class PostStudentFormLoading extends AppState {}

final class PostStudentFormScucess extends AppState {}

final class PostStudentFormError extends AppState {
  final String error;

  PostStudentFormError(this.error);
}

final class PostCourseLoading extends AppState {}

final class PostCourseScucess extends AppState {}

final class PostCourseError extends AppState {
  final String error;

  PostCourseError(this.error);
}

final class PostTimeLoading extends AppState {}

final class PostTimeScucess extends AppState {}

final class PostTimeError extends AppState {
  final String error;

  PostTimeError(this.error);
}

final class PostSubscribtionLoading extends AppState {}

final class PostSubscribtionScucess extends AppState {}

final class PostSubscribtionError extends AppState {
  final String error;

  PostSubscribtionError(this.error);
}

final class ChangeGender extends AppState {}

final class ChangeDefucultyInStudy extends AppState {}

final class CalcAge extends AppState {}

final class UpdateProgress extends AppState {}

final class UpdateProgressBack extends AppState {}

final class SelectAcademicLevel extends AppState {}

final class SelectProgrmesLevels extends AppState {}

final class SelectClassLevel extends AppState {}

final class SelectMaterial extends AppState {}

final class SelectPurpose extends AppState {}

final class SelectDay extends AppState {}

final class SubscriptionsSelected extends AppState {}

final class AgreeToTerms extends AppState {}

final class PostAllReuests extends AppState {}

final class PostAllReuestsLoading extends AppState {}

final class PostAllReuestsScucess extends AppState {}

final class PostAllReuestsError extends AppState {
  final String error;

  PostAllReuestsError(this.error);
}

final class PostPaymentLoading extends AppState {}

final class PostPaymentScucess extends AppState {}

final class PostPaymentError extends AppState {
  final String error;

  PostPaymentError(this.error);
}

final class CheckLocalData extends AppState {}
