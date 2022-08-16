import 'package:flutter/material.dart';

import '../services/userApi.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({Key? key}) : super(key: key);

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final _userNameController = TextEditingController();
  final _contactController = TextEditingController();

  bool _validateName = false;
  bool _validateContact = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New User'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Add New User Details',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Name',
                  labelText: 'Name',
                  errorText:
                      _validateName ? 'Name Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _contactController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Contact Number',
                  labelText: 'Contact No',
                  errorText:
                      _validateName ? 'Contact Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        _userNameController.text.isEmpty
                            ? _validateName = true
                            : _validateName = false;
                        _contactController.text.isEmpty
                            ? _validateContact = true
                            : _validateContact = false;
                      });
                      if (_validateName == false && _validateContact == false) {
                        var result = await UserApi().addUser(
                            _userNameController.text, _contactController.text);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context, result);
                      }
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Save details'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      _userNameController.text = "";
                      _contactController.text = "";
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    child: const Text('Clear Details'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
