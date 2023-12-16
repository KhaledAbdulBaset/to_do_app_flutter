import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training2/cubit/app_cubit.dart';
import 'package:training2/cubit/states_cubit.dart';
import 'package:training2/modules/home_todo_screen.dart';

class todoPage extends StatelessWidget{
  var myTitleTodoController=TextEditingController();
  var myTimeTodoController=TextEditingController();
  var myDateTodoController=TextEditingController();
  var myBodyTodoController=TextEditingController();
  var myColorTodoController=TextEditingController();

  var _formKey=GlobalKey<FormState>();
  int validation1(){
    if(_formKey.currentState!.validate()){
      print("validate");
      return 1;
    }
    else{
      print("Not validate");
      return 0;
    }
  }


  String? myTitle;
  String? myTime;
  String? myDate;
  String? myBody;
  String? myStatus;
  String? myColor;
  int? myId;


  todoPage(
      {this.myTitle,
      this.myTime,
      this.myDate,
      this.myBody,
      this.myStatus,
      this.myColor,
      this.myId
      });

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<appCubit,appStates>(
     builder: (BuildContext context, appStates state) {
     appCubit appCubitObj=appCubit.get(context);
     return Form(
         key: _formKey,
         child: Scaffold(
             appBar: AppBar(
               flexibleSpace: Container(
                 width: double.infinity,
                 decoration: BoxDecoration(
                     gradient: LinearGradient(
                         begin: Alignment.centerLeft,
                         end: Alignment.centerRight,
                         colors: <Color>[Color(0xff650015),Colors.pink,Color(0xff182232),]

                     )
                 ),
               ),
               title: Container(
                   width: double.infinity,
                   alignment: Alignment.center,
                   child: Text("TO DO PAGE",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),)),
             ),
             body: Container(
               height: double.infinity,
               width: double.infinity,
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                       Container(
                         height: 90,
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.all(Radius.circular(10))
                         ),
                         clipBehavior: Clip.antiAliasWithSaveLayer,
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
                           child: TextFormField(
                             validator: (String? value){
                               if(value==null||value.length<3)
                               {return "please put a title";}
                               return null;
                             },
                             keyboardType: TextInputType.text,
                             controller: myTitleTodoController=TextEditingController(text: myTitle),
                             textInputAction: TextInputAction.next,
                             maxLines: 2,
                             decoration: InputDecoration(
                                 hintText: "Title",
                                 prefixIcon: Icon(Icons.title_outlined),
                                 border: OutlineInputBorder()
                             ),
                           ),
                         ),
                       ),
                       SizedBox(height: 15,),
                       Container(height: 90,
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.all(Radius.circular(10))
                         ),
                         clipBehavior: Clip.antiAliasWithSaveLayer,
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
                           child: TextFormField(
                             validator: (String? value){
                               if(value==null||value.length<1){return "please put a time";}
                               return null;
                             },
                             onTap: (){
                               showTimePicker(context: context, initialTime: TimeOfDay.now(),).then((value) =>myTimeTodoController.text=value!.format(context).toString());
                             },
                             keyboardType: TextInputType.text,
                             controller: myTimeTodoController=TextEditingController(text: myTime),
                             decoration: InputDecoration(
                                 hintText: "time",
                                 prefixIcon: Icon(Icons.watch),
                                 border: OutlineInputBorder()
                             ),
                           ),
                         ),
                       ),
                       SizedBox(height: 15,),
                       Container(
                         height: 90,
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.all(Radius.circular(10))
                         ),
                         clipBehavior: Clip.antiAliasWithSaveLayer,

                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
                           child: TextFormField(
                             keyboardType: TextInputType.text,
                             controller: myDateTodoController=TextEditingController(text: myDate),                     onTap: (){
                             showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100)).then((value) => myDateTodoController.text=DateFormat.yMMMd().format(value!));
                           },
                             validator: (String? value){
                               if(value==null||value.length<2){return "please put a date";}
                               return null;
                             },
                             decoration: InputDecoration(
                                 hintText: "Date",
                                 prefixIcon: Icon(Icons.calendar_today),
                                 border: OutlineInputBorder()
                             ),
                           ),
                         ),
                       ),
                       SizedBox(height: 15,),
                       Container(
                         height: 120,
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.all(Radius.circular(10))
                         ),
                         clipBehavior: Clip.antiAliasWithSaveLayer,

                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
                           child: TextFormField(
                             validator: (String? value){
                               if(value==null||value.length<3){return "please put a subject";}
                               return null;
                             },
                             maxLines: 10,
                             keyboardType: TextInputType.text,
                             controller: myBodyTodoController=TextEditingController(text: myBody),                       decoration: InputDecoration(
                               hintText: "Subject",
                               prefixIcon: Icon(Icons.subject),
                               border: OutlineInputBorder()
                           ),
                           ),
                         ),
                       ),
                       SizedBox(height: 15,),
                       SingleChildScrollView(
                         scrollDirection: Axis.horizontal,
                         child: Container(
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.all(Radius.circular(20)),
                               gradient: LinearGradient(
                                   begin: Alignment.centerLeft,
                                   end: Alignment.centerRight,
                                   colors:<Color>[Color(0xff650015),Colors.pink,Color(0xff182232)]

                               )
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               IconButton(
                                 onPressed: (){


                                 },
                                 iconSize: 40,
                                 icon: Stack(
                                   alignment: Alignment.center,
                                   children: [
                                     Container(
                                       height: 40,
                                       width: 40,
                                       decoration: BoxDecoration(
                                           color: myColor=="pink"?Colors.green:Colors.white
                                           , shape: BoxShape.circle
                                       ),),
                                     Container(
                                       height: 30,
                                       width: 30,
                                       decoration: BoxDecoration(
                                           color: Colors.pink,
                                           shape: BoxShape.circle
                                       ),)
                                   ],
                                 ),
                               ),
                               SizedBox(width: 8,),
                               IconButton(
                                 onPressed: (){

                                 },
                                 iconSize: 40,
                                 icon: Stack(
                                   alignment: Alignment.center,
                                   children: [
                                     Container(
                                       height: 40,
                                       width: 40,
                                       decoration: BoxDecoration(
                                           color: myColor=="teal"?Colors.green:Colors.white
                                           ,shape: BoxShape.circle
                                       ),),
                                     Container(
                                       height: 30,
                                       width: 30,
                                       decoration: BoxDecoration(
                                           color: Colors.teal,
                                           shape: BoxShape.circle
                                       ),)
                                   ],
                                 ),
                               ),
                               SizedBox(width: 8,),
                               IconButton(
                                 onPressed: (){


                                 },
                                 iconSize: 40,
                                 icon: Stack(
                                   alignment: Alignment.center,
                                   children: [
                                     Container(
                                       height: 40,
                                       width: 40,
                                       decoration: BoxDecoration(
                                           color: myColor=="purple"?Colors.green:Colors.white,
                                           shape: BoxShape.circle
                                       ),),
                                     Container(
                                       height: 30,
                                       width: 30,
                                       decoration: BoxDecoration(
                                           color: Colors.purple,
                                           shape: BoxShape.circle
                                       ),)
                                   ],
                                 ),
                               ),
                               SizedBox(width: 8,),
                               IconButton(
                                 onPressed: (){



                                 },
                                 iconSize: 40,
                                 icon: Stack(
                                   alignment: Alignment.center,
                                   children: [
                                     Container(
                                       height: 40,
                                       width: 40,
                                       decoration: BoxDecoration(
                                           color: myColor=="yellow"?Colors.green:Colors.white
                                           ,shape: BoxShape.circle
                                       ),),
                                     Container(
                                       height: 30,
                                       width: 30,
                                       decoration: BoxDecoration(
                                           color: Colors.amberAccent,
                                           shape: BoxShape.circle
                                       ),)
                                   ],
                                 ),
                               ),
                               SizedBox(width: 8,),
                               IconButton(
                                 onPressed: (){

                                 },
                                 iconSize: 40,
                                 icon: Stack(
                                   alignment: Alignment.center,
                                   children: [
                                     Container(
                                       height: 40,
                                       width: 40,
                                       decoration: BoxDecoration(
                                           color: myColor=="orange"?Colors.green:Colors.white,
                                           shape: BoxShape.circle
                                       ),),
                                     Container(
                                       height: 30,
                                       width: 30,
                                       decoration: BoxDecoration(
                                           color: Colors.deepOrange,
                                           shape: BoxShape.circle
                                       ),)
                                   ],
                                 ),
                               ),
                               SizedBox(width: 8,),
                               IconButton(
                                 onPressed: (){


                                 },
                                 iconSize: 40,
                                 icon: Stack(
                                   alignment: Alignment.center,
                                   children: [
                                     Container(
                                       height: 40,
                                       width: 40,
                                       decoration: BoxDecoration(
                                           color: myColor=="red"?Colors.green:Colors.white,
                                           shape: BoxShape.circle
                                       ),),
                                     Container(
                                       height: 30,
                                       width: 30,
                                       decoration: BoxDecoration(
                                           color: Color(0xff650015),
                                           shape: BoxShape.circle
                                       ),)
                                   ],
                                 ),
                               )
                             ],
                           ),
                         ),
                       )
                       ,SizedBox(height: 10,),

                       Stack(
                         children: [
                           Container(height: 70,width: 70,color: Colors.white,),
                           IconButton(
                             onPressed: (){
                               validation1();
                               if(validation1()==1){
                                 appCubitObj.updateDatabase(
                                     title: myTitleTodoController.text,
                                     body: myBodyTodoController.text,
                                     time: myTimeTodoController.text,
                                     date: myDateTodoController.text,
                                     status: myStatus,
                                     color: myColor,
                                     id: myId);
                               }
                               // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => homeTodoScreen(),), (route) => false);
                            Navigator.pop(context);
                             },
                             iconSize: 50,
                             icon: Container(
                                 height: 50,
                                 width: 50,
                                 decoration: BoxDecoration(
                                     boxShadow: [BoxShadow(
                                         color: Colors.black,offset: Offset(1, 1),blurRadius: 7, spreadRadius: 4
                                     )],
                                     borderRadius: BorderRadius.all(Radius.circular(10)),
                                     gradient: LinearGradient(
                                         begin: Alignment.centerLeft,
                                         end: Alignment.centerRight,
                                         colors: <Color>[Color(0xff650015),Colors.pink,Color(0xff182232),]

                                     )
                                 ),
                                 child: Icon(Icons.edit,color: Colors.white,)),),
                         ],
                       )



                     ],
                   ),
                 ),
               ),

             )

         )
     );
   }, listener: (BuildContext context, appStates state) {  },

   );
  }}


       /*SingleChildScrollView(
         child: Container(
           height: double.infinity,
           width: double.infinity,
           decoration: BoxDecoration(
               borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight:Radius.circular(40) ),
               gradient: LinearGradient(
                   begin: Alignment.centerLeft,
                   end: Alignment.centerRight,
                   colors: <Color>[Color(0xff650015),Colors.pink,Color(0xff182232),]

               )
           ),
           clipBehavior: Clip.antiAliasWithSaveLayer,

           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10.0),
             child: Column(
               children: [

                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Container(width: 100,height: 20,
                     decoration: BoxDecoration(
                         color: Colors.amberAccent,
                         boxShadow: [BoxShadow(
                             color: Colors.black,
                             offset: Offset(1, 1),
                             spreadRadius: 7,
                             blurRadius: 7
                         )]
                     ),
                   ),
                 ),
                 SizedBox(height: 20,),
                 Container(
                   height: 90,
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.all(Radius.circular(10))
                   ),
                   clipBehavior: Clip.antiAliasWithSaveLayer,

                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                     child: TextFormField(
                       validator: (String? value){
                         if(value==null||value.length<3)
                         {return "please put a title";}
                         return null;
                       },
                       keyboardType: TextInputType.text,
                       controller: myTitleTodoController,
                       textInputAction: TextInputAction.next,
                       decoration: InputDecoration(

                           hintText: "Title",
                           prefixIcon: Icon(Icons.title_outlined),
                           border: OutlineInputBorder()
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: 20,),
                 Container(height: 90,
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.all(Radius.circular(10))
                   ),
                   clipBehavior: Clip.antiAliasWithSaveLayer,
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                     child: TextFormField(
                       validator: (String? value){
                         if(value==null||value.length<1){return "please put a time";}
                         return null;
                       },
                       onTap: (){
                         showTimePicker(context: context, initialTime: TimeOfDay.now(),).then((value) =>myTimeTodoController.text=value!.format(context).toString());
                       },
                       keyboardType: TextInputType.text,
                       controller: myTimeTodoController,
                       decoration: InputDecoration(
                           hintText: "time",
                           prefixIcon: Icon(Icons.watch),
                           border: OutlineInputBorder()
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: 20,),
                 Container(
                   height: 90,
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.all(Radius.circular(10))
                   ),
                   clipBehavior: Clip.antiAliasWithSaveLayer,

                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                     child: TextFormField(
                       keyboardType: TextInputType.text,
                       controller: myDateTodoController,
                       onTap: (){
                         showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100)).then((value) => myDateTodoController.text=DateFormat.yMMMd().format(value!));
                       },
                       validator: (String? value){
                         if(value==null||value.length<2){return "please put a date";}
                         return null;
                       },
                       decoration: InputDecoration(
                           hintText: "Date",
                           prefixIcon: Icon(Icons.calendar_today),
                           border: OutlineInputBorder()
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: 20,),
                 Container(
                   height: 90,
                   alignment: Alignment.center,
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.all(Radius.circular(10))
                   ),
                   clipBehavior: Clip.antiAliasWithSaveLayer,

                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                     child: TextFormField(
                       validator: (String? value){
                         if(value==null||value.length<3){return "please put a subject";}
                         return null;
                       },
                       keyboardType: TextInputType.text,
                       controller: myBodyTodoController,
                       decoration: InputDecoration(
                           hintText: "Subject",
                           prefixIcon: Icon(Icons.subject),
                           border: OutlineInputBorder()
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: 10,),
                 // BlocConsumer<appCubit,appStates>(builder: ( context,  state) {
                 //   appCubit colorCubitObj=appCubit.get(context);
                   //return

                 //Row of colors
    //              SingleChildScrollView(
    //                  scrollDirection: Axis.horizontal,
    //                  child: Row(
    //                    mainAxisAlignment: MainAxisAlignment.center,
    //                    children: [
    //                      IconButton(
    //                        onPressed: (){
    //                          // colorCubitObj.changeColor(0,"pink");
    //                          // print(colorCubitObj.colorIndex);
    //                          // print(appCubitObj.myColor.toString());
    //
    //                        },
    //                        iconSize: 40,
    //                        icon: Stack(
    //                          alignment: Alignment.center,
    //                          children: [
    //                            Container(
    //                              height: 40,
    //                              width: 40,
    //                              decoration: BoxDecoration(
    //                                  // color: colorCubitObj.colorIndex==0?Colors.green:Colors.white
    // color: Colors.white
    //                                  , shape: BoxShape.circle
    //                              ),),
    //                            Container(
    //                              height: 30,
    //                              width: 30,
    //                              decoration: BoxDecoration(
    //                                  color: Colors.pink,
    //                                  shape: BoxShape.circle
    //                              ),)
    //                          ],
    //                        ),
    //                      ),
    //                      SizedBox(width: 8,),
    //                      IconButton(
    //                        onPressed: (){
    //                          // colorCubitObj.changeColor(1,"teal");
    //                          // print(colorCubitObj.colorIndex);
    //
    //                        },
    //                        iconSize: 40,
    //                        icon: Stack(
    //                          alignment: Alignment.center,
    //                          children: [
    //                            Container(
    //                              height: 40,
    //                              width: 40,
    //                              decoration: BoxDecoration(
    //                                  // color: colorCubitObj.colorIndex==1?Colors.green:Colors.white
    // color:Colors.white
    // ,shape: BoxShape.circle
    //                              ),),
    //                            Container(
    //                              height: 30,
    //                              width: 30,
    //                              decoration: BoxDecoration(
    //                                  color: Colors.teal,
    //                                  shape: BoxShape.circle
    //                              ),)
    //                          ],
    //                        ),
    //                      ),
    //                      SizedBox(width: 8,),
    //                      IconButton(
    //                        onPressed: (){
    //                          // colorCubitObj.changeColor(2,"purple");
    //
    //                        },
    //                        iconSize: 40,
    //                        icon: Stack(
    //                          alignment: Alignment.center,
    //                          children: [
    //                            Container(
    //                              height: 40,
    //                              width: 40,
    //                              decoration: BoxDecoration(
    //                                  // color: colorCubitObj.colorIndex==2?Colors.green:Colors.white,
    // color:Colors.white,
    //                                  shape: BoxShape.circle
    //                              ),),
    //                            Container(
    //                              height: 30,
    //                              width: 30,
    //                              decoration: BoxDecoration(
    //                                  color: Colors.purple,
    //                                  shape: BoxShape.circle
    //                              ),)
    //                          ],
    //                        ),
    //                      ),
    //                      SizedBox(width: 8,),
    //                      IconButton(
    //                        onPressed: (){
    //
    //                          // colorCubitObj.changeColor(3,"yellow");
    //
    //                        },
    //                        iconSize: 40,
    //                        icon: Stack(
    //                          alignment: Alignment.center,
    //                          children: [
    //                            Container(
    //                              height: 40,
    //                              width: 40,
    //                              decoration: BoxDecoration(
    //                                  // color: colorCubitObj.colorIndex==3?Colors.green:Colors.white
    // color:Colors.white
    //                                  ,shape: BoxShape.circle
    //                              ),),
    //                            Container(
    //                              height: 30,
    //                              width: 30,
    //                              decoration: BoxDecoration(
    //                                  color: Colors.amberAccent,
    //                                  shape: BoxShape.circle
    //                              ),)
    //                          ],
    //                        ),
    //                      ),
    //                      SizedBox(width: 8,),
    //                      IconButton(
    //                        onPressed: (){
    //                          // colorCubitObj.changeColor(4,"orange");
    //
    //
    //                        },
    //                        iconSize: 40,
    //                        icon: Stack(
    //                          alignment: Alignment.center,
    //                          children: [
    //                            Container(
    //                              height: 40,
    //                              width: 40,
    //                              decoration: BoxDecoration(
    //                                  // color: colorCubitObj.colorIndex==4?Colors.green:Colors.white,
    // color:Colors.white,
    //                                  shape: BoxShape.circle
    //                              ),),
    //                            Container(
    //                              height: 30,
    //                              width: 30,
    //                              decoration: BoxDecoration(
    //                                  color: Colors.deepOrange,
    //                                  shape: BoxShape.circle
    //                              ),)
    //                          ],
    //                        ),
    //                      ),
    //                      SizedBox(width: 8,),
    //                      IconButton(
    //                        onPressed: (){
    //                          // colorCubitObj.changeColor(5,"red");
    //
    //
    //                        },
    //                        iconSize: 40,
    //                        icon: Stack(
    //                          alignment: Alignment.center,
    //                          children: [
    //                            Container(
    //                              height: 40,
    //                              width: 40,
    //                              decoration: BoxDecoration(
    //                                  // color: colorCubitObj.colorIndex==5?Colors.green:Colors.white,
    // color:Colors.white,
    //                                  shape: BoxShape.circle
    //                              ),),
    //                            Container(
    //                              height: 30,
    //                              width: 30,
    //                              decoration: BoxDecoration(
    //                                  color: Color(0xff650015),
    //                                  shape: BoxShape.circle
    //                              ),)
    //                          ],
    //                        ),
    //                      )
    //                    ],
    //                  ),
    //                ),




                 // },

  // listener: ( context,  state) {  },

                 // )

               ],
             ),
           ),


         ),
       )

     ),
   );

    )
   )
  }

}
*/