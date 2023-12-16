import 'package:sqflite/sqflite.dart';
class databaseHelper{

   static Database? databaseObj;


   static void createDatabase()async{

    databaseObj=await openDatabase(
      "todo.db",
      onCreate: (db, version) {
        db.execute("CREATE TABLE todo( id INTEGER PRIMARY KEY, title TEXT NOT NULL, body TEXT NOT NULL, time TEXT NOT NULL, date  TEXT NOT NULL, status TEXT NOT NULL);").then((value) {
          print("note DB IS CREATED");
        }).catchError((error)=>print("Error while creating db :${error}"));


      },
      onOpen: (db) {
        print("open db successfully");

      },
      );

  }

   static void insertTodoIntoDatabase()async{
     return await databaseObj!.transaction((txn) async{
       txn.rawInsert('INSERT INTO todo( title, body, time, date, status) VALUES( "title value", "body value", "time value", "date value","status value")').then((value) {
         print("insert successful$value");
       }).catchError((error)=>print("error while inserting${error.toString()}"));
     });
   }


   static List<dynamic> todoList=[];
   static void getTodoFromDatabase(){
     databaseObj!.rawQuery("SELECT * FROM todo").then((value) {
       todoList=value;
       print("SUCCESSFUL GET $value");

     }).catchError((error){
       print("ERROR WHILE GET DB $error");
     });
   }





}