import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training2/shared/components.dart';
import 'package:training2/cubit/app_cubit.dart';
import 'package:training2/cubit/states_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class doneScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<appCubit,appStates>(
        builder: (BuildContext context, appStates state) {
          appCubit appCubitObj=appCubit.get(context);
          return  ConditionalBuilder(
              condition: appCubitObj.doneTodoList.length>0,
              builder: (context) => Column(
                  children:[
                    Expanded(
                      child: Container(

                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => noteItemShadow(
                                title: appCubitObj.doneTodoList[index]['title'],
                                time: appCubitObj.doneTodoList[index]['time'],
                                date: appCubitObj.doneTodoList[index]['date'],
                                body: appCubitObj.doneTodoList[index]['body'],
                                status: appCubitObj.doneTodoList[index]['status'],
                                color: appCubitObj.doneTodoList[index]['color'],
                                id: appCubitObj.doneTodoList[index]['id']

                            ),
                            separatorBuilder: (context, index) => SizedBox(height: 20,),
                            itemCount: appCubitObj.doneTodoList.length),
                      ),
                    ),]
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),);
        },

        listener: (BuildContext context, appStates state) {  },

      );

  }

}