import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/userApi.dart';

class UpdateUserForm extends StatefulWidget {
  final User user;
  const UpdateUserForm(this.user, {Key? key}) : super(key: key);

  @override
  State<UpdateUserForm> createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  final _userNameController = TextEditingController();
  final _contactController = TextEditingController();

  bool _validateName = false;
  bool _validateContact = false;

  @override
  void initState() {
    _userNameController.text = widget.user.name;
    _contactController.text = widget.user.contact;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Edit user Details',
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
                        var result = await UserApi().updateUser(
                            _userNameController.text,
                            _contactController.text,
                            widget.user.id);

                        Navigator.pop(context, result);
                      }
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('update details'),
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
