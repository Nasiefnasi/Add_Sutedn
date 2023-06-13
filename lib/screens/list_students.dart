import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_list/controller/provider/student_provider.dart';
import 'package:student_list/presentation/screens/Details_screen/Details.dart';
import 'package:student_list/presentation/screens/edit_screen/Editstudent.dart';

class Liststudents extends StatelessWidget {
  const Liststudents({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Studentprovider>(
      builder: (context, stdnotifier, _) {
        return SizedBox(
          height: 900,
          child: ListView.separated(
            itemBuilder: (ctx, index) {
              final data = stdnotifier.foundeduser[index];
              return ListTile(
                title: Text(
                  data.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                subtitle: Text(data.age),
                // onTap: () {
                //   Navigator.of(context).push(MaterialPageRoute(
                //       builder: (ctx) => StudentDetails(
                //             name: data.name,
                //             age: data.age,
                //             phonenumber: data.phonenumber,
                //             place: data.place,
                //           )));
                // },
                trailing: Wrap(
                  spacing: 12,
                  children: <Widget>[
                    IconButton(
                      onPressed: (() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) {
                              return Editstudent(
                                name: data.name,
                                age: data.age,
                                phone: data.phonenumber,
                                place: data.place,
                                index: index,
                              );
                            }),
                          ),
                        );
                      }),
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      tooltip: 'Edit',
                    ),
                    IconButton(
                      onPressed: (() {
                        showDialog(
                          context: context,
                          builder: ((context) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: AlertDialog(
                                title: const Text(
                                  'Alert!',
                                  style: TextStyle(),
                                ),
                                content: const Text(
                                  "Do you want to delete this student",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: (() {
                                      stdnotifier.deletestudent(index);
                                      Navigator.pop(context);
                                    }),
                                    child: const Text('Yes'),
                                  ),
                                  TextButton(
                                      onPressed: (() {
                                        Navigator.pop(context);
                                      }),
                                      child: const Text('No'))
                                ],
                              ),
                            );
                          }),
                        );
                      }),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.black,
                      ),
                      tooltip: 'delete',
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider();
            },
            itemCount: stdnotifier.foundeduser.length,
          ),
        );
      },
    );
  }
}
