import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training2/modules/archive_screen.dart';
import 'package:training2/cubit/states_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:training2/modules/done_screen.dart';
import 'package:training2/modules/home_todo_screen.dart';

class appCubit extends Cubit<appStates>{
  appCubit():super(appInitState());

  static appCubit get(context)=> BlocProvider.of(context);

  int BottomNavIndex=0;

  void changeBottomNavIndex(index){
    BottomNavIndex=index;
    emit(changeBottomNavIndexState());
  }

  List<Widget> todoScreen=[homeTodoScreen(),doneScreen(),archiveScreen()];
  List<String> titles=["Let's D0","DONE","ARCHIVED"];
  bool isBottomSheetOpen=false;
  IconData BottomSheetIcon=Icons.edit;
  void changeBottomSheet(IconData icon,bool flag){
    isBottomSheetOpen=flag;
    BottomSheetIcon=icon;
    emit(changeBottomSheetState());

  }

  int colorIndex=0;
  String myColor="pink";
  void changeColor(value,@required String color){
    colorIndex=value;
    myColor=color;
    emit(changeColorState());
  }



  // void changeMyColor(value){
  //   myColor=value;
  //   emit(changeMyColorState());
  // }



   Database? databaseObj;



   void createDatabase()async{
    databaseObj=await openDatabase(
      "todox.db",
      version: 1,
      onCreate: (db, version) {
        db.execute("CREATE TABLE todo( id INTEGER PRIMARY KEY, title TEXT NOT NULL, body TEXT NOT NULL, time TEXT NOT NULL, date  TEXT NOT NULL, status TEXT NOT NULL, color TEXT NOT NULL);").then((value) {
          print("note DB IS CREATED");
        }).catchError((error)=>print("Error while creating db :${error}"));

      },
      onOpen: (db) {
        print("open db successfully");
        getTodoFromDatabase(db);
        getDoneTodoFromDatabase(db);
        getArchivedTodoFromDatabase(db);
      },

    );
    emit(appCreateDatabase());

   }

   void insertTodoIntoDatabase(
       {required String? title,
         required String? body,
         required String? time,
         required String? date,
         required String? status,
         required String? color,
       }
       )async{
    return await databaseObj!.transaction((txn) async{
      txn.rawInsert('INSERT INTO todo( title, body, time, date, status, color) VALUES( "$title", "$body", "$time", "$date","$status","$color")').then((value) {
        print("insert successful$value");
        getTodoFromDatabase(databaseObj);
        emit(appInsertatabase());

      }).catchError((error)=>print("error while inserting${error.toString()}"));
    });
  }


   List<dynamic> todoList=[];
   void getTodoFromDatabase(databaseObj){
    databaseObj!.rawQuery("SELECT * FROM todo WHERE status=?",["new"]).then((value) {
      todoList=value;
      print("SUCCESSFUL GET $value");
      emit(appGetDatabase());

    }).catchError((error){
      print("ERROR WHILE GET DB $error");
    });
  }


  List<dynamic> doneTodoList=[];
  void getDoneTodoFromDatabase(databaseObj){
    databaseObj!.rawQuery("SELECT * FROM todo WHERE status=?",["done"]).then((value) {
      doneTodoList=value;
      print("SUCCESSFUL GET DONE $value");
      emit(appGetDoneFromDatabase());

    }).catchError((error){
      print("ERROR WHILE GET DONE DB $error");
    });
  }


  List<dynamic> archiveTodoList=[];
  void getArchivedTodoFromDatabase(databaseObj){
    databaseObj!.rawQuery("SELECT * FROM todo WHERE status=?",["archive"]).then((value) {
      archiveTodoList=value;
      print("SUCCESSFUL GET ARCHIVED $value");
      emit(appGetArchivedFromDatabase());

    }).catchError((error){
      print("ERROR WHILE GET ARCHIVED DB $error");
    });
  }





  void updateDatabase({required String? title,
                       required String? body,
                       required String? time,
                       required String? date,
                       required String? status,
                       required String? color,

                        required int? id,
  }){databaseObj!.rawUpdate("UPDATE todo SET title=?, body=?, time=?, date=?, status=?, color=? WHERE id=?",[title,body,time,date,status,color,id]).then((value) {
    print("successful updated$value");
    getTodoFromDatabase(databaseObj);
    getDoneTodoFromDatabase(databaseObj);
    getArchivedTodoFromDatabase(databaseObj);
    emit(appUpdateDatabase());
  }).catchError((error){print("error while updated$error");});
  }

  void deleteFromDatabase({required int id}){
     databaseObj!.rawDelete("DELETE FROM todo WHERE id=?",[id])
         .then((value) {
       print("successful delete");
       getTodoFromDatabase(databaseObj);
       getDoneTodoFromDatabase(databaseObj);
       getArchivedTodoFromDatabase(databaseObj);
       emit(appDeleteFromDatabase());
     } );

  }

  List<dynamic> searchList=[];
  void searchDatabase({required String? title}){
     databaseObj!.rawQuery("SELECT * FROM todo WHERE title=?",[title])
         .then((value) {
       print("successful search");
       print(value);
       searchList=value;
       emit(appSearchDatabase());
     }).catchError((error)=>print(error.toString()));
  }


  int todoPageColorIndex=0;
  void changeTodoPageColorIndex(index){
    todoPageColorIndex=index;
    emit(changeTodoPageColorIndexState());
  }


}