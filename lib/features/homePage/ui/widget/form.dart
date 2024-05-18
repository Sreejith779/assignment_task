 

import 'package:assignment_task/features/homePage/bloc/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Forms extends StatefulWidget {
  final TextEditingController labelController;
  final TextEditingController infoController;
  final HomeBloc homeBloc;

  Forms(this.labelController, this.infoController,{super.key, required this.homeBloc});

  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Label*",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: widget.labelController,
              decoration: InputDecoration(
                hintText: "text here",
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 10),
            const Text(
              "Info-Text*",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: widget.infoController,
              decoration: InputDecoration(
                hintText: "text here",
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 10),
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            Row(
              children: checkBox.map((e){
                return Expanded(child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                    title: Text(e['title']),
                    value: e['isChecked'], onChanged: (value){
                    setState(() {
                      e['isChecked'] = value;
                    });
                }));
              }).toList(),

            ),
            ElevatedButton(
              onPressed: saveForm,
              child: Text('Save'),
            ),
            

          ],
        ),
      ),
    );
  }

  List<Map<String,dynamic>>checkBox = [
    {"title":"Required", "isChecked":false},
    {"title":"Read only", "isChecked":false},
    {"title":"Hidden Field", "isChecked":false},
  ];

   void saveForm(){
    List<String> selectedSettings() {
      return checkBox
          .where((element) => element['isChecked'] == true)
          .map((e) => e['title'].toString())
          .toList();
    }
    final label = widget.labelController.text;
    final info = widget.infoController.text;
    final settings = selectedSettings();
    widget.homeBloc.add(HomeSaveEvent(label: label, info: info, settings: settings));

  }
 
}
