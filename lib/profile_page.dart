import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final storage = FlutterSecureStorage();

  // Controllers for form fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController birthplaceController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController collegeNameController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController passingYearController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  bool _isEditing = false;
  bool _isLoading = true; // Loading state for progress indicator
  String? _userToken; // Token for authentication

  @override
  void initState() {
    super.initState();
    _getUserToken(); // Retrieve token on initialization
  }

  Future<void> _getUserToken() async {
    try {
      _userToken = await storage.read(key: 'user_token'); // Retrieve token
      if (_userToken != null) {
        await fetchProfileData(); // Fetch profile data if token is found
      } else {
        print('No user token found');
        setState(() {
          _isLoading = false; // Stop loading if no token is found
        });
      }
    } catch (e) {
      print('Error retrieving token: $e');
      setState(() {
        _isLoading = false; // Stop loading in case of error
      });
    }
  }

  Future<void> fetchProfileData() async {
    final url = Uri.parse(
        'http://13.127.246.196:8000/api/registers/'); // Adjust the endpoint if necessary

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_userToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data); //
        if (data is Map<String, dynamic>) {
          setState(() {
            fullNameController.text = data['name'] ?? '';
            fatherNameController.text = data["father_name"] ?? '';
            emailController.text = data['email'] ?? '';
            phoneController.text = data['mobile'] ?? '';
            whatsappController.text = data["whatsapp_number"] ?? '';
            dobController.text = data['dob'] ?? '';
            birthplaceController.text = data["birth_place"] ?? '';
            genderController.text = data['gender'] ?? '';
            degreeController.text = data['degree'] ?? '';
            collegeNameController.text = data['college'] ?? '';
            passingYearController.text = data['passing_year'] ?? '';
            stateController.text = data['state'] ?? '';
            _isLoading = false; // Stop loading once data is fetched
          });
        } else {
          print('Unexpected response format: $data');
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          _isLoading = false; // Stop loading if request fails
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false; // Stop loading in case of error
      });
    }
  }

  Future<void> saveProfile() async {
    final data = {
      'name': fullNameController.text,
      'father_name': fatherNameController.text,
      'email': emailController.text,
      'mobile': phoneController.text,
      'whatsapp_number': whatsappController.text,
      'dob': dobController.text,
      'birth_place': birthplaceController.text,
      'gender': genderController.text,
      'degree': degreeController.text,
      'college': collegeNameController.text,
      'passing_year': passingYearController.text,
      'state': stateController.text,
    };

    final url = Uri.parse(
        'http://13.127.246.196:8000/registers'); // Adjust the endpoint if necessary

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $_userToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully');
        setState(() {
          _isEditing = false; // Stop editing mode
        });
      } else {
        print('Failed to update profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                saveProfile();
              } else {
                setState(() {
                  _isEditing = true;
                });
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while data is fetched
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Personal Information',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    _buildTextField(fullNameController, 'Name'),
                    _buildTextField(fatherNameController, 'Father Name'),
                    _buildTextField(emailController, 'Email'),
                    _buildTextField(phoneController, 'Mobile Number'),
                    _buildTextField(
                        dobController, 'Date of Birth (YYYY-MM-DD)'),
                    _buildTextField(birthplaceController, 'Birth Place'),
                    _buildTextField(genderController, 'Gender'),
                    SizedBox(height: 20),
                    Text('Educational Information',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    _buildTextField(collegeNameController, 'College Name'),
                    _buildTextField(degreeController, 'Degree'),
                    _buildTextField(passingYearController, 'Passing Year'),
                    _buildTextField(stateController, 'State'),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(),
      ),
      enabled: _isEditing,
    );
  }
}
