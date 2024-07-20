import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';
import 'package:test/controller/helper/bloc_observer.dart';
import 'package:test/controller/helper/cashHelper.dart';
import 'package:test/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  List<Locale> supportedLocales = const [
    Locale('en'),
    Locale('ar'),
    Locale('en', 'US'),
    Locale('ar', 'SA'),
  ];
  Locale startLocale = const Locale('ar');

  runApp(EasyLocalization(
    supportedLocales: supportedLocales,
    path: 'assets/translations',
    fallbackLocale: const Locale('ar'),
    startLocale: startLocale,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double baseWidth = 393;

    double fem = MediaQuery.sizeOf(context).width / baseWidth;

    double ffem = fem * 0.97;

    textSize = ffem;

    ratio = fem;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..getPurposeData()
            ..getDayData()
            ..getMaterialData()
            ..getSubscriptionData(),
        ),
      ],
      child: MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        debugShowCheckedModeBanner: false,
        locale: context.locale,

        // * Initialize Router using Go Router package to apply deep linking (Shared Posts)
        routerConfig: router,
      ),
    );
  }
}
