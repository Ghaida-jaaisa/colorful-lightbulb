// Importing the Flutter material library
import 'package:flutter/material.dart';

// Enumerations for search types and locations
enum SearchType { web, image, news, shopping }
enum SearchLocation { anywhere, title, text }

// Main function to run the Flutter app
void main() => runApp(MyApp());

// MyApp class, a stateless widget representing the main app structure
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ch 4 Value Widgets',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('My Proper Form')),
        body: ProperForm(),
      ),
    );
  }
}

// ProperForm class, a stateful widget for building the form
class ProperForm extends StatefulWidget {
  @override
  _ProperFormState createState() => _ProperFormState();
}

// _ProperFormState class, the state for the ProperForm widget
class _ProperFormState extends State<ProperForm> {
  // Map to hold form data
  final Map<String, dynamic> _searchForm = <String, dynamic>{
    'searchTerm': '',
    'email': '',
    'numberOfResults': 100,
    'searchType': SearchType.web,
    'safeSearchOn': true,
    'searchLocation': SearchLocation.anywhere,
  };

  // GlobalKey to reference the form
  final GlobalKey<FormState> _key = GlobalKey();
  // TextEditingController for the email field
  // Allows us to have an initial value for Email if we wanted it.
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = _searchForm['email'];
  }

  @override
  Widget build(BuildContext context) {
    // Text style for labels
    final TextStyle _labelStyle =
    Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.deepPurple);

    return Form(
      key: _key,
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Text(
            'Advanced search - With Form',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'What are you searching for?',
            style: _labelStyle,
          ),
          // Text Field for Search Terms
          TextFormField(
            initialValue: _searchForm['searchTerm'],
            decoration: InputDecoration(
              labelText: 'Search terms',
            ),
            onChanged: (String val) {
              setState(() => _searchForm['searchTerm'] = val);
            },
            onSaved: (String? val) {
              print('Form saved: Search Term TextFormField: $val ${_searchForm['searchTerm']}');
              setState(() {
                _searchForm['searchTerm'] = val;
              });
            },
            validator: (String? val) {
              if (val!.isEmpty) {
                return 'We need something to search for';
              }
              return null;
            },
          ),
          Text("SearchTerm is ${_searchForm['searchTerm']}"),

          // Text Field for Email
          Text('Email (if you want results sent to you)', style: _labelStyle),
          FormField<String>(
            initialValue: _searchForm['email'],
            builder: (FormFieldState<String> state) {
              return TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'you@email.com',
                  icon: Icon(Icons.contact_mail),
                  errorText: RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                      .hasMatch(_emailController.text)
                      ? null
                      : "That's not an email address",
                ),
                onChanged: (String val) {
                  setState(() => _searchForm['email'] = val);
                },
              );
            },
            onSaved: (String? initialValue) {
              print('Form saved: Email TextField: ${_searchForm['email']}');
            },
            validator: (String? val) {
              if (RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(val!)) {
                return null;
              } else {
                return "That's not an email address";
              }
            },
          ),
          Text("Email is ${_searchForm['email']}"),

          // Slider for Number of Results
          Text('Number of results', style: _labelStyle),
          FormField<double>(
            builder: (FormFieldState<double> num) {
              return Slider(
                label: _searchForm['numberOfResults'].round().toString(),
                min: 0.0,
                max: 100.0,
                divisions: 100,
                value: _searchForm['numberOfResults'].toDouble(),
                onChanged: (double val) {
                  setState(() => _searchForm['numberOfResults'] = val.round());
                },
              );
            },
            onSaved: (double? initialValue) {
              print('Form saved: # of Results slider: ${_searchForm['numberOfResults']}');
            },
          ),
          Text("Slider value ${_searchForm['numberOfResults'].toString()}"),

          // DropdownButton for Type of Search
          Text('Type of search', style: _labelStyle),
          FormField<SearchType>(
            builder: (FormFieldState<SearchType> state) {
              return DropdownButton<SearchType>(
                value: _searchForm['searchType'],
                items: const <DropdownMenuItem<SearchType>>[
                  DropdownMenuItem<SearchType>(
                    child: Text('Web'),
                    value: SearchType.web,
                  ),
                  DropdownMenuItem<SearchType>(
                    child: Text('Image'),
                    value: SearchType.image,
                  ),
                  DropdownMenuItem<SearchType>(
                    child: Text('News'),
                    value: SearchType.news,
                  ),
                  DropdownMenuItem<SearchType>(
                    child: Text('Shopping'),
                    value: SearchType.shopping,
                  ),
                ],
                onChanged: (SearchType? val) {
                  setState(() => _searchForm['searchType'] = val);
                },
              );
            },
            onSaved: (SearchType? initialValue) {
              print('Form saved: searchType dropdown: ${_searchForm['searchType']}');
            },
          ),

          // Checkbox for SafeSearch
          Text('SafeSearch', style: _labelStyle),
          // Wrapping the Checkbox in a FormField so we can have an
          // onSaved and a validator
          FormField<bool>(
            builder: (FormFieldState<bool> state) {
              return Row(
                children: <Widget>[
                  Checkbox(
                    value: _searchForm['safeSearchOn'],
                    onChanged: (bool? val) {
                      setState(() => _searchForm['safeSearchOn'] = val);
                    },
                  ),
                  const Text('Safesearch on'),
                ],
              );
            },
            onSaved: (bool? initialValue) {
              print('Form saved: safeSearch Checkbox: ${_searchForm['safeSearchOn']}');
            },
          ),

          // Radio buttons for Search Location
          Text('Terms appearing ...', style: _labelStyle),
          FormField<SearchLocation>(
            builder: (FormFieldState<SearchLocation> state) {
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio<SearchLocation>(
                        groupValue: _searchForm['searchLocation'],
                        value: SearchLocation.anywhere,
                        onChanged: (SearchLocation? val) {
                          setState(() => _searchForm['searchLocation'] = val);
                        },
                      ),
                      const Text('Search anywhere'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio<SearchLocation>(
                        groupValue: _searchForm['searchLocation'],
                        value: SearchLocation.text,
                        onChanged: (SearchLocation? val) {
                          setState(() => _searchForm['searchLocation'] = val);
                        },
                      ),
                      const Text('Search page text'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio<SearchLocation>(
                        groupValue: _searchForm['searchLocation'],
                        value: SearchLocation.title,
                        onChanged: (SearchLocation? val) {
                          setState(() => _searchForm['searchLocation'] = val);
                        },
                      ),
                      const Text('Search page title'),
                    ],
                  ),
                  Text(_searchForm['searchLocation'].toString()),
                ],
              );
            },
            onSaved: (SearchLocation? initialValue) {
              print('Form saved: searchLocation Radio group: ${_searchForm['searchLocation']}');
            },
          ),

          // Submit Button
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () {
              if (_key.currentState!.validate()) {
                _key.currentState!.save();
                print('Successfully saved the state.');

                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      children: <Widget>[
                        const Text("You submitted the form. Here's the form state"),
                        ..._searchForm.keys.map<Text>((String key) =>
                            Text('$key = ${_searchForm[key]}')),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}