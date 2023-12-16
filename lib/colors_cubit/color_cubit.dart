import 'package:training2/colors_cubit/color_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
class colorCubit extends Cubit<colorStates>{
  colorCubit():super(colorInitState());
  static colorCubit get(context)=>BlocProvider.of(context);

  int colorIndex=0;
  void changeColor(value){
    colorIndex=value;
    emit(changeColorState());
  }

}