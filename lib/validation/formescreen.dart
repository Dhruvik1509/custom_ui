import 'package:custom_ui/validation/validation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Formescreen extends StatefulWidget {
  const Formescreen({super.key});

  @override
  State<Formescreen> createState() => _FormescreenState();
}

class _FormescreenState extends State<Formescreen> {
  final _FnameController = TextEditingController();
  final _LnameController = TextEditingController();
  final _BirthController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cPasswordController = TextEditingController();

  Validators validators = Validators();
  final _formkey = GlobalKey<FormState>();
  DateTime? _selectedDate;


  String? gender = null;
  String? sexuality = null;
  String? languages = null;

  List<String> Gender = [
    'Agender',
    'Aliagender',
    'man',
    'Multigender',
    'Woman',
    'Non-Binary',
    'Female',
    'Libragender',
    'Transgender',
    'Prefer Not to say',
    'Bigender',
  ];

  List<String> Sexuality = [
    'Abrosexual',
    'Queer',
    'Asexual',
    'Fraysexual',
    'Gyneosexual',
    'Pansexual',
    'Lesbian',
    'Homoromantic',
    'Panromantic',
    'Demiroamantic',
  ];

  final List<String> Languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Hindi',
    'Japanese',
    'Russian',
    'Arabic',
    'Portuguese',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _FnameController,
                          validator: Validators.validateFirstName,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _LnameController,
                          validator: Validators.validateLastName,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _BirthController,
                    validator: (value) {
                      // Validate if the _selectedDate is not null before calling the validation function
                      if (_selectedDate == null) {
                        return 'Date of birth is required';
                      }
                      return Validators.validateDateOfBirth(_selectedDate);
                    },
                    decoration: InputDecoration(
                      hintText: 'Date of Birth',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          _selectedDate = date;
                          _BirthController.text = DateFormat('MM/dd/yyyy').format(date); // Format the date to MM/dd/yyyy
                        });
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _usernameController,
                    validator: Validators.validateUsername,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    validator: Validators.validatePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _cPasswordController,
                    validator:
                        (value) => Validators.validateConfirmPassword(
                          _passwordController.text,
                          value,
                        ),
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
                    value: gender,
                    items: List.generate(
                      Gender.length,
                      (index) => DropdownMenuItem(
                        child: Text('${Gender[index]}'),
                        value: Gender[index],
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Select Gender',
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
                    value: sexuality,
                    items: List.generate(
                      Sexuality.length,
                      (index) => DropdownMenuItem(
                        child: Text('${Sexuality[index]}'),
                        value: Sexuality[index],
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        sexuality = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Select Sexuality',
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
                    value: languages,
                    items: List.generate(
                      Languages.length,
                      (index) => DropdownMenuItem(
                        child: Text('${Languages[index]}'),
                        value: Languages[index],
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        languages = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Select Languages',
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();


                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.black),
                      child: Center(
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
