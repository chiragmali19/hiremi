import 'package:flutter/material.dart';
import 'package:hiremi/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  TextEditingController fullNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController birthplaceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController collegeNameController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController passingYearController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String? gender;
  String? branch;
  String? passingYear;
  String? collegeState;
  String? degree;

  // Engineering degrees
  final List<String> engineeringDegrees = [
    'B.E.',
    'B.Tech',
    'M.E.',
    'M.Tech',
    'Diploma in Engineering',
    'PhD in Engineering',
    'Integrated M.Tech',
  ];

  // Engineering branches
  final List<String> engineeringBranches = [
    'Computer Science and Engineering',
    'Information Technology',
    'Mechanical Engineering',
    'Civil Engineering',
    'Electrical Engineering',
    'Electronics and Communication Engineering',
    'Chemical Engineering',
    'Aerospace Engineering',
    'Biomedical Engineering',
    'Automobile Engineering',
    'Environmental Engineering',
    'Agricultural Engineering',
    'Marine Engineering',
    'Petroleum Engineering',
  ];

  // Indian states
  final List<String> indianStates = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Lakshadweep',
    'Delhi',
    'Puducherry',
    'Ladakh',
    'Jammu and Kashmir',
  ];

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      final response = await http.post(
        Uri.parse('http://13.127.246.196:8000/api/registers/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'full_name': fullNameController.text,
          'father_name': fatherNameController.text,
          'email': emailController.text,
          'date_of_birth': DateFormat('yyyy-MM-dd')
              .format(DateFormat('dd/MM/yyyy').parse(dobController.text)),
          'phone_number': phoneController.text,
          'whatsapp_number': whatsappController.text,
          'gender': gender,
          'college_state': collegeState,
          'college_name': collegeNameController.text,
          'branch_name': branch,
          'degree_name': degree,
          'passing_year': passingYear,
          'password': passwordController.text,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        // Check for successful creation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful! Please log in.')),
        );
        // Navigate to login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInPage()),
        );
      } else {
        final responseJson = jsonDecode(response.body);
        final errorMessage =
            responseJson['error'] ?? 'Registration failed. Please try again.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              Text(
                "Register to Get Started",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                      width: 1.0,
                      color: Colors.black,
                      style: BorderStyle.solid),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          "Personal Information",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 40),
                      // Full Name Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Full Name*'),
                          TextFormField(
                            controller: fullNameController,
                            decoration: InputDecoration(
                              hintText: 'John Doe',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your full name';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Father's Full Name Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Father\'s Full Name*'),
                          TextFormField(
                            controller: fatherNameController,
                            decoration: InputDecoration(
                              hintText: 'Robert Doe',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter father\'s full name';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Gender Field (in a Row)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Gender*'),

                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Male',
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value;
                                          genderController.text = value ?? '';
                                        });
                                      },
                                    ),
                                    Text('Male'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Female',
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value;
                                          genderController.text = value ?? '';
                                        });
                                      },
                                    ),
                                    Text('Female'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Other',
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value;
                                          genderController.text = value ?? '';
                                        });
                                      },
                                    ),
                                    Text('Other'),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // TextFormField that reflects the selected gender
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Email Address Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email Address*'),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'example123@gmail.com',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email address';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Date of Birth Field with Calendar Icon
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date of Birth*'),
                          TextFormField(
                            controller: dobController,
                            readOnly: true, // Prevent typing
                            decoration: InputDecoration(
                              hintText: 'DD/MM/YYYY',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.calendar_month),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  dobController.text = DateFormat('dd/MM/yyyy')
                                      .format(pickedDate);
                                });
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter date of birth';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text('Birth Place*'),
                      DropdownButtonFormField<String>(
                        isDense: true,
                        isExpanded: true,
                        value: collegeState,
                        decoration: InputDecoration(
                          hintText: 'Select State',
                          border: OutlineInputBorder(),
                        ),
                        items: indianStates.map((state) {
                          return DropdownMenuItem<String>(
                            value: state,
                            child: FittedBox(
                              fit: BoxFit.fill, // Shrinks text to fit
                              child: Text(
                                state,
                                overflow: TextOverflow
                                    .ellipsis, // Ensure ellipsis for long text
                              ),
                            ),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your Birth place';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            collegeState = value;
                          });
                        },
                      ),

                      SizedBox(height: 30),
                      // Phone Number Field
                      Column(
                        children: [
                          Text(
                            "Contact Information",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 40),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Phone Number*'),
                              TextFormField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  hintText: '+91',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter phone number';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Whatsapp Number*'),
                              TextFormField(
                                controller: whatsappController,
                                decoration: InputDecoration(
                                  hintText: '+91',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter WhatsApp number';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Text(
                          "Educational Information",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("College Name*"),
                          TextFormField(
                            controller: collegeNameController,
                            decoration: InputDecoration(
                              hintText: 'College Name Here',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your college name';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                      // College State Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("College State*"),
                          DropdownButtonFormField<String>(
                            isDense: true,
                            isExpanded: true,
                            value: collegeState,
                            decoration: InputDecoration(
                              hintText: 'College State',
                              border: OutlineInputBorder(),
                            ),
                            items: indianStates.map((state) {
                              return DropdownMenuItem<String>(
                                value: state,
                                child: Text(state),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select your college state';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                collegeState = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Branch*"),
                          DropdownButtonFormField<String>(
                            isDense: true,
                            isExpanded: true,
                            value: branch,
                            decoration: InputDecoration(
                              hintText: 'Branch',
                              border: OutlineInputBorder(),
                            ),
                            items: engineeringBranches.map((branch) {
                              return DropdownMenuItem<String>(
                                value: branch,
                                child: Text(branch),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                branch = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select your branch';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Degree Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Degree*"),
                          DropdownButtonFormField<String>(
                            isDense: true,
                            isExpanded: true,
                            value: degree,
                            decoration: InputDecoration(
                              hintText: 'Degree',
                              border: OutlineInputBorder(),
                            ),
                            items: engineeringDegrees.map((degree) {
                              return DropdownMenuItem<String>(
                                value: degree,
                                child: Text(degree),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                degree = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select your degree';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Passing Year Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Passout Year*"),
                          DropdownButtonFormField<String>(
                            isDense: true,
                            isExpanded: true,
                            value: passingYear,
                            decoration: InputDecoration(
                              hintText: 'Select year',
                              border: OutlineInputBorder(),
                            ),
                            items: List.generate(20, (index) {
                              final year = DateTime.now().year - index;
                              return DropdownMenuItem<String>(
                                value: year.toString(),
                                child: Text(year.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                passingYear = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select your passing year';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      Center(
                        child: Text(
                          "Let's Create Password",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),

                      // Password Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Password*"),
                          TextFormField(
                            controller: passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: '**********',
                              border: OutlineInputBorder(),
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // Prevents it from taking full width
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Icon(Icons.lock_outline),
                                  ), // Your original icon
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            10.0), // Adds space around the line
                                    height:
                                        55, // Adjust this for your desired height
                                    width: 1, // Thin vertical line
                                    color: Colors.grey, // Set line color
                                  ),
                                ],
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Confirm Password Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Confirm Password*"),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              controller: confirmPasswordController,
                              obscureText: !_isConfirmPasswordVisible,
                              decoration: InputDecoration(
                                hintText: '**********',
                                border: OutlineInputBorder(),
                                // Custom prefixIcon with vertical line
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize
                                      .min, // Prevents it from taking full width
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Icon(Icons.lock_outline),
                                    ), // Your original icon
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal:
                                              10.0), // Adds space around the line
                                      height:
                                          55, // Adjust this for your desired height
                                      width: 1, // Thin vertical line
                                      color: Colors.grey, // Set line color
                                    ),
                                  ],
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isConfirmPasswordVisible =
                                          !_isConfirmPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                      // Register Button
                      Center(
                        child: ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 134, 17, 8), // Button color
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            'Register Now',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
