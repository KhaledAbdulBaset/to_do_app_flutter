import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training2/shared/components.dart';
import 'package:training2/cubit/app_cubit.dart';
import 'package:training2/cubit/states_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class homeTodoScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<appCubit,appStates>(
        builder: (BuildContext context, appStates state) {
          appCubit appCubitObj=appCubit.get(context);
          return   ConditionalBuilder(
            condition: appCubitObj.todoList.length>0,
            builder: (context) =>  Column(
                children:[
                  Expanded(
                    child: Container(

                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => noteItemShadow(
                              title: appCubitObj.todoList[index]['title'],
                              time: appCubitObj.todoList[index]['time'],
                              date: appCubitObj.todoList[index]['date'],
                              body: appCubitObj.todoList[index]['body'],
                              status: appCubitObj.todoList[index]['status'],
                              color: appCubitObj.todoList[index]['color'],
                              id: appCubitObj.todoList[index]['id']

                          ),
                          separatorBuilder: (context, index) => SizedBox(height: 20,),
                          itemCount: appCubitObj.todoList.length),
                    ),
                  ),]
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),);





        },

        listener: (BuildContext context, appStates state) {  },

      );

  }

}