import '../homePage/ui/widget/form.dart';

List<Map<String,dynamic>>savedList = [];


class SaveModel{
  final String label;
  final String info;
  final List<String>settings;

  SaveModel({required this.label, required this.info,required this.settings});

}

List<FormModel> forms = [];