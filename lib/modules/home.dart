import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training2/colors_cubit/color_cubit.dart';
import 'package:training2/colors_cubit/color_states.dart';
import 'package:training2/cubit/app_cubit.dart';
import 'package:training2/cubit/states_cubit.dart';
import 'package:training2/modules/search_screen.dart';
import 'package:intl/intl.dart';

class homeScreen extends StatelessWidget{
  var _scaffoldKey= GlobalKey<ScaffoldState>();

  var titleTodoController=TextEditingController();

  var timeTodoController=TextEditingController();

  var dateTodoController=TextEditingController();

  var bodyTodoController=TextEditingController();

  var colorTodoController=TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 int validation(){
    if(_formKey.currentState!.validate()){
      print("validate");
      return 1;
    }
    else{
      print("Not validate");
      return 0;
     }
  }

  String myColor="pink";
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<appCubit,appStates>(
      builder: (BuildContext context, appStates state) {
        appCubit appCubitObj= appCubit.get(context);
        return  Form(
          key: _formKey,
          child: Scaffold(
            key: _scaffoldKey,
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
                  child: Text(appCubitObj.titles[appCubitObj.BottomNavIndex],style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),)),
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => searchScreen(),));
                }, iconSize: 30,icon: Icon(Icons.search))

              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                appCubitObj.changeBottomNavIndex(index);
              },
                currentIndex: appCubitObj.BottomNavIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Color(0xff650015),
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.white,
                items: [
              BottomNavigationBarItem(icon: Icon(Icons.work_outline),label: "To DO"),
              BottomNavigationBarItem(icon: Icon(Icons.done_outline),label: "Done"),
              BottomNavigationBarItem(icon: Icon(Icons.archive_outlined),label: "Archive"),
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: (){

                if(appCubitObj.isBottomSheetOpen){
                   {

                    if(validation()==1) {
                      appCubitObj.insertTodoIntoDatabase(
                          title: titleTodoController.text,
                          body: bodyTodoController.text,
                          time: timeTodoController.text,
                          date: dateTodoController.text,
                          status: "new",
                          color: appCubitObj.myColor);
                      appCubitObj.changeBottomSheet(Icons.edit, false);
                      Navigator.pop(context);


                      // print("${titleTodoController.text}");
                      // print("${timeTodoController.text}");
                      // print("${dateTodoController.text}");
                      // print("${bodyTodoController.text}");}
                    }
                  }

                }
                else{
                  appCubitObj.changeBottomSheet(Icons.add,true);
                  _scaffoldKey.currentState!.showBottomSheet((context) {
                    return SingleChildScrollView(
                      child: Container(
                        height: 550,
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
                                child: ClipPath(
                                    clipper: CustomClipClass(),
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
                                    )),
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
                                    controller: titleTodoController,
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
                                      showTimePicker(context: context, initialTime: TimeOfDay.now(),).then((value) =>timeTodoController.text=value!.format(context).toString());
                                    },
                                    keyboardType: TextInputType.text,
                                    controller: timeTodoController,
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
                                    controller: dateTodoController,
                                    onTap: (){
                                      showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100)).then((value) => dateTodoController.text=DateFormat.yMMMd().format(value!));
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
                                    controller: bodyTodoController,
                                    decoration: InputDecoration(
                                        hintText: "Subject",
                                        prefixIcon: Icon(Icons.subject),
                                        border: OutlineInputBorder()
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              BlocConsumer<appCubit,appStates>(builder: ( context,  state) {
                                appCubit colorCubitObj=appCubit.get(context);
                                return  SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: (){
                                          colorCubitObj.changeColor(0,"pink");
                                          print(colorCubitObj.colorIndex);
                                          print(appCubitObj.myColor.toString());

                                        },
                                        iconSize: 40,
                                        icon: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: colorCubitObj.colorIndex==0?Colors.green:Colors.white
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
                                          colorCubitObj.changeColor(1,"teal");
                                          print(colorCubitObj.colorIndex);

                                        },
                                        iconSize: 40,
                                        icon: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: colorCubitObj.colorIndex==1?Colors.green:Colors.white
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
                                          colorCubitObj.changeColor(2,"purple");

                                        },
                                        iconSize: 40,
                                        icon: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: colorCubitObj.colorIndex==2?Colors.green:Colors.white,
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

                                          colorCubitObj.changeColor(3,"yellow");

                                        },
                                        iconSize: 40,
                                        icon: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: colorCubitObj.colorIndex==3?Colors.green:Colors.white
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
                                          colorCubitObj.changeColor(4,"orange");


                                        },
                                        iconSize: 40,
                                        icon: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: colorCubitObj.colorIndex==4?Colors.green:Colors.white,
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
                                          colorCubitObj.changeColor(5,"red");


                                        },
                                        iconSize: 40,
                                        icon: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: colorCubitObj.colorIndex==5?Colors.green:Colors.white,
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
                                );
                              }, listener: ( context,  state) {  },

                              )

                            ],
                          ),
                        ),


                      ),
                    );
                  }).closed.then((value) {
                    appCubitObj.changeBottomSheet(Icons.edit,false);
                  });

                }


              },
              backgroundColor: Colors.pink,
              child: Icon(appCubitObj.BottomSheetIcon,),
            ),


            body: appCubitObj.todoScreen[appCubitObj.BottomNavIndex]
          ),
        );
      },
      listener: (BuildContext context, appStates state) {  },

    );

  }
}

class CustomClipClass extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
  double w= size.width;
  double h= size.height;
  final path=Path();

  path.moveTo(0*w, 0.15*h);
  path.quadraticBezierTo(w*0.1, h*0.4, w*0.2, 0.15*h);
  path.quadraticBezierTo(w*0.3, h*0.4, w*0.4, 0.15*h);
  path.quadraticBezierTo(w*0.5, h*0.4, w*0.6, 0.15*h);
  path.quadraticBezierTo(w*0.7, h*0.4, w*0.8, 0.15*h);
  path.quadraticBezierTo(w*0.9, h*0.4, w, 0.15*h);
  path.lineTo(w, h);
  path.lineTo(0, h);
  path.close();

  return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
   return true;
  }

}