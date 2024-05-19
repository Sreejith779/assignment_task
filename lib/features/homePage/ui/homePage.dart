import 'package:assignment_task/features/homePage/ui/widget/form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/saveList.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();


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
        switch(state.runtimeType){
          case HomeSaveActionState:
            final loadedState  = state as HomeSaveActionState;
              showDialog(context: context, builder: (contextIndex){
                return AlertDialog(
                  title: Text("Saved!"),
                  actions: [
                    Column(
                     children: state.saved.map((e){
                       return ListTile(
                         title: Text(e['label']??"No label"),
                         subtitle:  Column(
                           children: [
                             Text(e['info']),

                           ],
                         )
                       );
                     }).toList(),
                    )
                  ],
                );
              });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: const Text("Form"),
            actions: [
              ElevatedButton(onPressed: saveAllForms, child: const Text("Save"))
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  ...forms.map((e) => formWidget(e, forms.indexOf(e))).toList(),
                  ElevatedButton(
                    onPressed: (){
                      homeBloc.add(HomeAddEvent());
                    },
                    child: Text("Add"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget formWidget(FormModel form,int index) {
    return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.grey.withOpacity(0.2),
    ),
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(onPressed: (){
                  homeBloc.add(HomeDeleteEvent(index:index));
                }, child: const Text("Remove"))),
            const Text(
              "Label*",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: form.labelController,
              decoration: InputDecoration(
                hintText: "text here",
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Info-Text*",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: form.infoController,
              decoration: InputDecoration(
                hintText: "text here",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: form.checkBox.map((e) {
                return Expanded(
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(e['title']),
                    value: e['isChecked'],
                    onChanged: (value) {
                      setState(() {
                        e['isChecked'] = value;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }


  void saveAllForms() {
    for (var form in  forms) {
      final label = form.labelController.text;
      final info = form.infoController.text;
      final settings = form.checkBox
          .where((element) => element['isChecked'] == true)
          .map((e) => e['title'].toString())
          .toList();
      homeBloc.add(HomeSaveEvent(
        label: label.isEmpty ? 'No Label' : label,
        info: info.isEmpty ? 'No Info' : info,
        settings: settings,
      ));
      form.labelController.clear();
      form.infoController.clear();
    }
    print("All forms have been saved");
  }

}


