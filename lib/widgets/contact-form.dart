import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/contact_info.dart';
import '../screens/home_page.dart';

Future<String> sendData(ContactInfo infoBody) async {
  String jsonInfoBody = jsonEncode(infoBody);
  final http.Response response = await http.post('http://10.0.2.2:8080',
      headers: {"content-type": "application/json"}, body: jsonInfoBody);

  return response.statusCode.toString();
}

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

enum ContactChoice { email, phone }

class _ContactFormState extends State<ContactForm> {
  ContactInfo infoCollector;
  final _formKey = GlobalKey<FormState>();
  bool _lodging = false,
      _dining = false,
      _todo = false,
      _moving = false,
      _joining = false,
      _volunteer = false;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _businessController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  static String _choiceString = "email";
  static String statusCode;
  ContactChoice _choice = ContactChoice.email;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field is required.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'First Name'),
                      controller: _firstNameController,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field is required.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Last Name'),
                      controller: _lastNameController,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Email'),
                controller: _emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Daytime Phone'),
                controller: _phoneController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return null;
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Business (Optional)'),
                controller: _businessController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return null;
                  }
                  return null;
                },
                decoration:
                    InputDecoration(labelText: 'Street Address (Optional)'),
                controller: _address1Controller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return null;
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Address Line 2'),
                controller: _address2Controller,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return null;
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'City'),
                      controller: _cityController,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return null;
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(labelText: 'State/Province/Region'),
                      controller: _stateController,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return null;
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Zip/Postal Code'),
                      controller: _zipController,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return null;
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Country'),
                      controller: _countryController,
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text('I\'d like more information about:'),
            ),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: Text('Lodging'),
                    value: _lodging,
                    onChanged: (val) {
                      setState(() {
                        _lodging = val;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: Text('Dining'),
                    value: _dining,
                    onChanged: (val) {
                      setState(() {
                        _dining = val;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: Text('Things to Do & Events'),
                    value: _todo,
                    onChanged: (val) {
                      setState(() {
                        _todo = val;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: Text('Moving to Bandon'),
                    value: _moving,
                    onChanged: (val) {
                      setState(() {
                        _moving = val;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: Text('Joining the Bandon Chamber'),
                    value: _joining,
                    onChanged: (val) {
                      setState(() {
                        _joining = val;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: Text('Volunteering'),
                    value: _volunteer,
                    onChanged: (val) {
                      setState(() {
                        _volunteer = val;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return null;
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Message (Optional)'),
                controller: _messageController,
              ),
            ),
            ListTile(
              title: Text('Please contact me by:'),
            ),
            RadioListTile(
                title: Text('email'),
                value: ContactChoice.email,
                groupValue: _choice,
                onChanged: (ContactChoice value) {
                  setState(() {
                    _choice = value;
                  });
                }),
            RadioListTile(
                title: Text('phone'),
                value: ContactChoice.phone,
                groupValue: _choice,
                onChanged: (ContactChoice value) {
                  setState(() {
                    _choice = value;
                  });
                }),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _choice == ContactChoice.email
                      ? _choiceString = "email"
                      : _choiceString = "phone";
                  infoCollector = ContactInfo(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      business: _businessController.text,
                      address1: _address1Controller.text,
                      address2: _address2Controller.text,
                      city: _cityController.text,
                      state: _stateController.text,
                      zip: int.parse(_zipController.text),
                      country: _countryController.text,
                      lodging: _lodging,
                      dining: _dining,
                      todo: _todo,
                      moving: _moving,
                      joining: _joining,
                      volunteer: _volunteer,
                      contactBy: _choiceString,
                      message: _messageController.text);

                  _firstNameController.clear();
                  _lastNameController.clear();
                  _emailController.clear();
                  _phoneController.clear();
                  _businessController.clear();
                  _address1Controller.clear();
                  _address2Controller.clear();
                  _cityController.clear();
                  _stateController.clear();
                  _zipController.clear();
                  _countryController.clear();
                  _messageController.clear();

                  statusCode = await sendData(infoCollector);
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Thank you for your interest in Bandon!")));
                  Future.delayed(const Duration(milliseconds: 2000), () {
                    Navigator.of(context).pushNamed(HomePage.routeName);
                  });
                }
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
