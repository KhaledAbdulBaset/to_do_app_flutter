import 'package:flutter/material.dart';
import 'package:training2/colors_cubit/color_cubit.dart';
import 'package:training2/cubit/app_cubit.dart';
import 'package:training2/modules/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:training2/observer.dart';
void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return MultiBlocProvider(
  providers: [
   BlocProvider(create: (BuildContext context) { return appCubit()..createDatabase(); },),
   BlocProvider(create: (BuildContext context) { return colorCubit();},
    )
    ], child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
    ),
    home: homeScreen(),
  ),
  );
  }
}