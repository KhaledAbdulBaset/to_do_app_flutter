import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training2/shared/components.dart';
import 'package:training2/cubit/app_cubit.dart';
import 'package:training2/cubit/states_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class searchScreen extends StatelessWidget{
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appCubit,appStates>(
      builder: (BuildContext context, appStates state) {

        appCubit appCubitSearchObj = appCubit.get(context);

        return Scaffold(
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
                child: Text("SEARCH",style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),)),),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Container(
                      width: double.infinity,
                      height: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          onChanged: (String? value){
                            appCubitSearchObj.searchDatabase(title: value.toString());
                          },

                          keyboardType: TextInputType.text,
                          controller: searchController,
                          decoration: InputDecoration(
                              labelText: "Search",
                              suffixIcon: IconButton(onPressed: (){
                                appCubitSearchObj.searchDatabase(title: searchController.text);

                              },icon: Icon(Icons.search)),
                              border: OutlineInputBorder(

                              )
                          ),


                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    ConditionalBuilder(
                      condition: appCubitSearchObj.searchList.length>0,
                      builder: (BuildContext context) { return ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => noteItemShadow(
                              title: appCubitSearchObj.searchList[index]['title'],
                              time: appCubitSearchObj.searchList[index]['time'],
                              date: appCubitSearchObj.searchList[index]['date'],
                              body: appCubitSearchObj.searchList[index]['body'],
                              status: appCubitSearchObj.searchList[index]['status'],
                              color: appCubitSearchObj.searchList[index]['color'],
                              id: appCubitSearchObj.searchList[index]['id']),
                          separatorBuilder: (context, index) => SizedBox(height: 20,),
                          itemCount: appCubitSearchObj.searchList.length); },
                      fallback: (BuildContext context) { return Center(child: CircularProgressIndicator()); },


                    )

                  ],
                ),
              ),
            ),

          ),



        );

      },
      listener: (BuildContext context, appStates state) {  },

    );

  }

}