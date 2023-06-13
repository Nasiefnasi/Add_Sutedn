import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_list/controller/provider/student_provider.dart';
import 'package:student_list/core/heights.dart';
import 'package:student_list/models/model.dart';
import 'package:student_list/presentation/screens/add_screen/widgets/text_formwidget.dart';
import 'package:student_list/widgets/snackbar_widget.dart';

class Addstudent extends StatelessWidget {
  const Addstudent({super.key});

  @override
  Widget build(BuildContext context) {
    final studentprovider =
        Provider.of<Studentprovider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: const Align(
            alignment: Alignment.center,
            child: Text(
              'Add Student',
              style: TextStyle(color: Colors.black),
            )),
      ),
      body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(child: Consumer<Studentprovider>(
            builder: (context, value, _) {
              return Form(
                key: value.formkey,
                child: Column(
                  children: [
                    kheight20,
                    TextformWidget(
                      hintText: "Name",
                      labelText: "Username",
                      ctrl: value.namecontroller,
                      keyboardType: TextInputType.name,
                      message: 'Enter Your Name',
                    ),
                    kheight20,
                    TextformWidget(
                      hintText: "Age",
                      labelText: "Age",
                      ctrl: value.agecontroller,
                      keyboardType: TextInputType.number,
                      message: 'Enter Your Age',
                    ),
                    kheight20,
                    TextformWidget(
                      hintText: "Phone Number",
                      labelText: "Phone ",
                      ctrl: value.phonevontroller,
                      keyboardType: TextInputType.phone,
                      message: 'Enter Your Phone Number',
                    ),
                    kheight20,
                    TextformWidget(
                      hintText: "Enter place",
                      labelText: "Place",
                      ctrl: value.placecontroller,
                      keyboardType: TextInputType.name,
                      message: 'Enter Your place',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shadowColor: Colors.black,
                            elevation: 20),
                        onPressed: () {
                          if (value.formkey.currentState!.validate()) {
                            onAddstudentbuttonclicked(
                                context,
                                value.namecontroller,
                                value.agecontroller,
                                value.phonevontroller,
                                value.placecontroller);
                            Navigator.of(context).pop();
                            value.namecontroller.clear();
                            value.agecontroller.clear();
                            value.phonevontroller.clear();
                            value.placecontroller.clear();
                          }
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ))
                  ],
                ),
              );
            },
          ))),
    );
  }
}

Future<void> onAddstudentbuttonclicked(
  context,
  TextEditingController namectrl,
  TextEditingController agectrl,
  TextEditingController phnctrl,
  TextEditingController placectrl,
) async {
  final name = namectrl.text.trim();
  final age = agectrl.text.trim();
  final phonenumber = phnctrl.text.trim();
  final place = placectrl.text.trim();

  if (name.isEmpty || age.isEmpty || phonenumber.isEmpty || place.isEmpty) {
    return;
  } else {
    snackBarwidget(ctx: context, title: "New student added", clr: Colors.green);
  }
  final student = studentmodel(
    name: name,
    age: age,
    phonenumber: phonenumber,
    place: place,
  );
  Provider.of<Studentprovider>(context, listen: false).addstudent(student);
  Provider.of<Studentprovider>(context, listen: false).getAlldtudents();
}

