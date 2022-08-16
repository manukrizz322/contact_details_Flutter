import 'package:contact_details/services/userApi.dart';
import 'package:contact_details/view/addUserForm.dart';
import 'package:contact_details/view/updateUserForm.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User>? users;
  var isLoaded = false;

  @override
  void initState() {
    getRecord();
  }

  getRecord() async {
    users = await UserApi().getAllUsers();

    if (users != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  Future<void> showMessageDialog(String title, String msg) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Text(
                msg,
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 10.0,
        title: const Center(child: Text("Contact Details")),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
            itemCount: users?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(users![index].name),
                subtitle: Text(users![index].contact),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UpdateUserForm(users![index])),
                        ).then((data) {
                          if (data != null) {
                            showMessageDialog(
                                "Success", "$data Detail Updated Success");
                            getRecord();
                          }
                        });
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () async {
                        User user =
                            await UserApi().deleteUser(users![index].id);
                        showMessageDialog(
                            "Success", "$user Detail Deleted Success");
                        getRecord();
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddUserForm(),
            ),
          ).then((data) {
            if (data != null) {
              showMessageDialog("Success", "$data Detail Added Success");
              getRecord();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
