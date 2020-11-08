import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

enum ContactChoice { email, phone }

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  bool _lodging = false,
      _dining = false,
      _todo = false,
      _moving = false,
      _joining = false,
      _volunteer = false;
  ContactChoice _choice = ContactChoice.email;

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
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('This field and button works')));
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
