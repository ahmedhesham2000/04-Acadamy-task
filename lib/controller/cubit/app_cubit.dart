import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/controller/endpoints.dart';
import 'package:test/controller/helper/api_service.dart';
import 'package:test/controller/helper/cashHelper.dart';
import 'package:test/model/academicLevels.dart';
import 'package:test/model/progrmes_level.dart';
import 'package:test/model/request/form_request.dart';
import 'package:test/model/request/payment_request.dart';
import 'package:test/model/response/day.dart';
import 'package:test/model/response/form_response.dart';
import 'package:test/model/response/materials.dart';
import 'package:test/model/response/purpose.dart';
import 'package:test/model/response/subscription.dart';
import 'package:test/model/students.dart';
import 'package:test/utils/enums/enums.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial()) {
    checkLocalData();
  }
  checkLocalData() async {
    var data = await CacheHelper.getData(key: 'formRequest');
    if (data != null) {
      var json = jsonDecode(data);
      localFormData = FormRequest.fromMap(json);
      emit(CheckLocalData());
    }
  }

  static AppCubit get(context) => BlocProvider.of(context);
  ApiService apiService = ApiService();
  List<Purpose> purposeData = [];

  List<Materials> materialData = [];
  List<Day> dayData = [];
  List<Subscription> subscriptions = [];
  late Subscription selectedSubscription;

  final formKey7 = GlobalKey<FormState>();

  List<AcademicLevels> academicLevels = generateAcademicLevelsData();
  AcademicLevels? selectedAcademicLevel;
  List<ProgrmesLevels> progrmesLevels = generateProgramLevelsData();
  ProgrmesLevels? selectedProgrmesLevels;

  List<Students> students = generateStudentsData();
  FormRequest? localFormData;

  Role? role;
  FormRequest formRequest = FormRequest();
  FormResponse? form;
  String? selectedGender;
  bool? selectedDefucultyInStudy;
  double progress = 2;
  bool agreeToTerms = false;
  bool isDaySelected = false;
  bool isNightSelected = false;
  bool is15Selected = false;
  bool is12Selected = false;
  bool isOneSessionSelected = false;
  bool isTwoSessionSelected = false;

  bool isOneHourSelected = false;
  bool isTwoHourSelected = false;
  bool isHalfHourSelected = false;
  bool isOneHalfHourSelected = false;
  bool isTwoHalfHourSelected = false;

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();

  Future<void> getPurposeData() async {
    emit(GetPurposeDataLoading());
    await apiService.get(purposeUrl).then((value) {
      var resBody = json.decode(utf8.decode(value.bodyBytes));
      purposeData = resBody.map<Purpose>((e) => Purpose.fromMap(e)).toList();
      emit(GetPurposeDataScucess());
    }).catchError((e) {
      emit(GetPurposeDataError(e.toString()));
    });
  }

  Future<void> getMaterialData() async {
    emit(GetMaterialDataLoading());
    await apiService.get(materialUrl).then((value) {
      var resBody = json.decode(utf8.decode(value.bodyBytes));
      materialData =
          resBody.map<Materials>((e) => Materials.fromMap(e)).toList();
      emit(GetMaterialDataScucess());
    }).catchError((e) {
      emit(GetMaterialDataError(e.toString()));
    });
  }

  Future<void> getSubscriptionData() async {
    emit(GetSubscriptionDataLoading());
    await apiService.get(subsriptionUrl).then((value) {
      var resBody = json.decode(utf8.decode(value.bodyBytes));
      subscriptions =
          resBody.map<Subscription>((e) => Subscription.fromMap(e)).toList();
      emit(GetSubscriptionDataScucess());
    }).catchError((e) {
      emit(GetSubscriptionDataError(e.toString()));
    });
  }

  Future<void> getDayData() async {
    emit(GetDayDataLoading());
    await apiService.get(dayUrl).then((value) {
      var resBody = json.decode(utf8.decode(value.bodyBytes));

      dayData = resBody.map<Day>((e) => Day.fromMap(e)).toList();
      emit(GetDayDataScucess());
    }).catchError((e) {
      emit(GetDayDataError(e.toString()));
    });
  }

  Future<void> postForm({
    required String firstName,
    required String familyName,
    required String whatsapp,
    required String email,
    String? age,
    Gender? gender,
    bool? difficulties,
    String? help,
  }) async {
    emit(PostFormLoading());
    Map<String, dynamic> data = {
      'first_name': firstName,
      'family_name': familyName,
      'whatsapp': whatsapp,
      'email': email,
      'age': age,
      'gender': gender?.name,
      // 'nationality': 'national',
      'difficulties': difficulties == null
          ? null
          : difficulties
              ? 'Yes'
              : "No",
      "description": help
    };
    await apiService.post(formUrl, body: data).then((value) {
      var resBody = json.decode(utf8.decode(value.bodyBytes));

      form = FormResponse.fromMap(resBody);
      CacheHelper.clearAllData();

      emit(PostFormScucess());
    }).catchError((e) {
      emit(PostFormError(e.toString()));
    });
  }

  Future<void> postClassForm() async {
    emit(PostClassFormLoading());
    Map<String, dynamic> data = {
      'form': form?.id.toString(),
      'stage': [selectedAcademicLevel!.name],
      'classroom': selectedAcademicLevel!.classes
          .where((element) => element.isSelected == true)
          .map((e) => e.name)
          .toList(),
      'course_study': [selectedProgrmesLevels!.name],
    };
    await apiService
        .post(
      specifyUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data,
    )
        .then((value) {
      json.decode(utf8.decode(value.bodyBytes));

      // form = FormResponse.fromMap(resBody);
      emit(PostClassFormScucess());
    }).catchError((e) {
      emit(PostClassFormError(e.toString()));
    });
  }

  Future<void> postStudentForm() async {
    emit(PostStudentFormLoading());
    Map<String, dynamic> data = {
      'form': form?.id.toString(),
      'student_count': students
          .firstWhere(
            (element) => element.isSelected == true,
          )
          .count
          .toString(),
      'purposes': purposeData
          .where(
            (element) => element.isSelected == true,
          )
          .map((e) => e.id.toString())
          .toList()
    };
    await apiService
        .post(
      countUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data,
    )
        .then((value) {
      json.decode(utf8.decode(value.bodyBytes));

      // form = FormResponse.fromMap(resBody);
      emit(PostStudentFormScucess());
    }).catchError((e) {
      emit(PostStudentFormError(e.toString()));
    });
  }

  Future<void> postCourseForm() async {
    emit(PostCourseLoading());
    Map<String, dynamic> data = {
      'form': form?.id.toString(),
      'materials': materialData
          .where((element) => element.isSelected == true)
          .map((e) => e.id)
          .toList(),
    };
    await apiService
        .post(
      courseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data,
    )
        .then((value) {
      json.decode(utf8.decode(value.bodyBytes));

      // form = FormResponse.fromMap(resBody);
      emit(PostCourseScucess());
    }).catchError((e) {
      emit(PostCourseError(e.toString()));
    });
  }

  Future<void> postTimeForm() async {
    emit(PostTimeLoading());
    Map<String, dynamic> data = {
      'form': form?.id.toString(),
      'shift': isDaySelected ? 'day' : 'night',
      'time': is12Selected
          ? '12:00'
          : is15Selected
              ? '15:00'
              : null,
      'day': dayData
          .where((element) => element.isSelected == true)
          .map((e) => e.id)
          .toList(),
    };
    await apiService
        .post(
      periodUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data,
    )
        .then((value) {
      json.decode(utf8.decode(value.bodyBytes));

      // form = FormResponse.fromMap(resBody);
      emit(PostTimeScucess());
    }).catchError((e) {
      emit(PostTimeError(e.toString()));
    });
  }

  Future<void> postSubscriptionForm() async {
    emit(PostSubscribtionLoading());
    Map<String, dynamic> data = {
      'form': form?.id.toString(),
      "session": isOneSessionSelected ? 'one' : 'two',
      "hour": isHalfHourSelected
          ? '00:30'
          : isOneHourSelected
              ? '01:00'
              : isTwoHourSelected
                  ? '02:00'
                  : isOneHalfHourSelected
                      ? '01:30'
                      : isTwoHalfHourSelected
                          ? '02:30'
                          : null,
      'subscription': selectedSubscription.id,
    };
    await apiService
        .post(
      classUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data,
    )
        .then((value) {
      json.decode(utf8.decode(value.bodyBytes));
      CacheHelper.clearAllData();
      // form = FormResponse.fromMap(resBody);
      emit(PostSubscribtionScucess());
    }).catchError((e) {
      emit(PostSubscribtionError(e.toString()));
    });
  }

  Future<void> postPayment({required PaymentRequest request}) async {
    emit(PostPaymentLoading());
    await apiService
        .post(
      payUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: request.toMap(formId: form!.id!),
    )
        .then((value) {
      json.decode(utf8.decode(value.bodyBytes));

      // form = FormResponse.fromMap(resBody);
      emit(PostPaymentScucess());
    }).catchError((e) {
      emit(PostPaymentError(e.toString()));
    });
  }

  void changeRole(Role selectedRole) {
    emit(AppInitial());
    role = selectedRole;
    emit(ChangeRole());
  }

  void claculateAge(DateTime birthDate) {
    emit(AppInitial());
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    formRequest = formRequest.copyWith(age: age);
    emit(CalcAge());
  }

  void changeGender(Gender gender) {
    emit(AppInitial());
    selectedGender = gender.name;
    formRequest = formRequest.copyWith(gender: gender);
    emit(ChangeGender());
  }

  void changeDefucultyInStudy(bool defucultyInStudy) {
    emit(AppInitial());
    selectedDefucultyInStudy = defucultyInStudy;
    formRequest = formRequest.copyWith(difficulties: defucultyInStudy);
    emit(ChangeDefucultyInStudy());
  }

  void updateProgress() {
    emit(AppInitial());
    // if (progress > 10) {
    //   progress = 0.0;
    //   return;
    // }
    if (progress == 8) {
      progress += 2;
    } else {
      progress += 1;
    }

    emit(UpdateProgress());
  }

  void updateProgressBack() {
    emit(AppInitial());
    if (progress == 3.0) {
    } else {
      progress -= 1;
      emit(UpdateProgressBack());
    }
  }

  void selectAcademicLevel(int index) {
    emit(AppInitial());
    selectedAcademicLevel = null;
    for (var element in academicLevels) {
      element.isSelected = false;
    }
    academicLevels[index].isSelected = !academicLevels[index].isSelected;
    if (academicLevels[index].isSelected) {
      selectedAcademicLevel = academicLevels[index];
    } else {
      selectedAcademicLevel = null;
    }
    emit(SelectAcademicLevel());
  }

  void selectClassLevel(int index) {
    emit(AppInitial());
    selectedAcademicLevel!.classes[index].isSelected =
        !selectedAcademicLevel!.classes[index].isSelected;
    emit(SelectClassLevel());
  }

  void selectProgrmesLevels(int index) {
    emit(AppInitial());
    for (var element in progrmesLevels) {
      element.isSelected = false;
    }
    progrmesLevels[index].isSelected = !progrmesLevels[index].isSelected;
    if (progrmesLevels[index].isSelected) {
      selectedProgrmesLevels = progrmesLevels[index];
    } else {
      selectedProgrmesLevels = null;
    }
    emit(SelectProgrmesLevels());
  }

  void selectMaterial(index) {
    emit(AppInitial());
    materialData[index].isSelected = !materialData[index].isSelected!;
    emit(SelectMaterial());
  }

  void selectStudent(index) {
    emit(AppInitial());
    for (var element in students) {
      element.isSelected = false;
    }
    students[index].isSelected = !students[index].isSelected;
    emit(SelectMaterial());
  }

  void selectObjective(index) {
    emit(AppInitial());
    purposeData[index].isSelected = !purposeData[index].isSelected!;
    emit(SelectPurpose());
  }

  void selectDay(index) {
    emit(AppInitial());
    dayData[index].isSelected = !dayData[index].isSelected;
    emit(SelectDay());
  }

  void selectSubscription(index) {
    emit(AppInitial());
    for (var element in subscriptions) {
      element.isSelected = false;
    }
    subscriptions[index].isSelected = !subscriptions[index].isSelected;
    selectedSubscription = subscriptions[index];
    emit(SubscriptionsSelected());
  }

  void setAgreeToTerms(bool value) {
    emit(AppInitial());
    agreeToTerms = value;
    emit(AgreeToTerms());
  }

  void callAllRequests() async {
    emit(PostAllReuestsLoading());
    try {
      await postClassForm();
      await postCourseForm();
      await postStudentForm();
      await postTimeForm();
      await postSubscriptionForm();
      emit(PostAllReuestsScucess());
    } catch (e) {
      emit(PostAllReuestsError(e.toString()));
    }
  }
}
