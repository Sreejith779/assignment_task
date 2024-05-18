import 'package:assignment_task/features/homePage/ui/widget/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, });



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();
  TextEditingController labelController = TextEditingController();
  TextEditingController infoController = TextEditingController();


  @override
  void initState() {
 homeBloc.add(HomeInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: const Text(
                "Form"
            ),
            actions: [
              ElevatedButton(onPressed: (){

              }, child: const Text("Save"))
            ],
          ),
          body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Forms(labelController,infoController, homeBloc: homeBloc,),



                ElevatedButton(onPressed: () {
            homeBloc.add(HomeAddEvent());
                }, child: Text("Add"))
              ],
            ),
          ),
        );
      },
    );
  }


}
