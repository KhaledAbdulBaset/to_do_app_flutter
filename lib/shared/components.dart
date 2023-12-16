import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training2/cubit/app_cubit.dart';
import 'package:training2/cubit/states_cubit.dart';
import 'package:training2/modules/single_todo_page.dart';
Widget noteItemShadow(
{
  required String title,
  required String time,
  required String date,
  required String body,
  required String status,
  required String color,
  required int id,


}
    )=>BlocConsumer<appCubit,appStates>(builder: (BuildContext context, appStates state) {


      return Dismissible(
        key: Key(id.toString()),
        onDismissed: (value){
          appCubit.get(context).deleteFromDatabase(id: id);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 250,width: 250,color: Colors.white,),
            MaterialButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => todoPage(
                  myTitle: title,
                  myTime: time,
                  myDate: date,
                  myBody: body,
                  myColor: color,
                  myStatus: status,
                  myId:id
                ),));
              },
              child: Container(
                height: 220,
                width: 250,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(bottomLeft:Radius.circular(30),bottomRight: Radius.circular(30)),
                    color: color.toString()=="pink"?Colors.pink:
                    color.toString()=="teal"?Colors.teal:
                    color.toString()=="purple"?Colors.purple:
                    color.toString()=="yellow"?Colors.amber:
                    color.toString()=="orange"?Colors.orange:
                    Color(0xff650015),
                    boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(0.55),
                        offset: Offset(20, 12),
                        blurRadius: 1,
                        spreadRadius: 1
                    )]

                ),
                clipBehavior:  Clip.antiAliasWithSaveLayer,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(title,style: TextStyle(color:Colors.white,fontSize: 22,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,),
                      ),
                      Container(width: double.infinity,height: 1,color: Colors.black,),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(time,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,),
                      ),
                      Container(width: double.infinity,height: 1,color: Colors.black,),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(date,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,),
                      ),
                      Container(width: double.infinity,height: 1,color: Colors.black,),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(body,style: TextStyle(color:Colors.white,fontSize: 18,fontWeight: FontWeight.w500),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      )),
                      Row(children: [
                        IconButton(onPressed: (){
                          appCubit.get(context).updateDatabase(title: title, body: body, time: time, date: date, status: "done", color: color, id: id);


                        }, icon: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),child: Icon(Icons.done)),color: Colors.teal,),
                        Spacer(),
                        IconButton(onPressed: (){
                          appCubit.get(context).updateDatabase(title: title, body: body, time: time, date: date, status: "archive", color: color, id: id);


                        }, icon: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),child: Icon(Icons.archive_rounded)),color: Colors.grey,)
                      ],)
                    ]),


              ),
            ),
          ],
        ),
      );
}, listener: (BuildContext context, appStates state) {  },

    );