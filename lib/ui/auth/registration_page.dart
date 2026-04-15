import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  File? _image;
  bool _isLoading = false;
  double _uploadProgress = 0;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Image selected")));
    }
  }

  Future<void> _registerUser() async {
    final String nickname = _nicknameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (nickname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        _image == null) {
      _showToast("Please fill all fields and select and avatar");
      return;
    }

    if (password != _confirmPasswordController.text) {
      _showToast("Passwords do not match");
      return;
    }
    setState(() => _isLoading = true);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      Reference storageRef = FirebaseStorage.instance.ref().child(
        'user_persons/$uid/avatar.png',
      );
      UploadTask uploadTask = storageRef.putFile(_image!);
      uploadTask.snapshotEvents.listen((event) {
        setState(() {
          _uploadProgress = event.bytesTransferred / event.totalBytes;
        });
      });

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('user_persons').doc(uid).set({
        'nickname': nickname,
        'email': email,
        'avatar': downloadUrl,
        'coins': 0,
        'buying': 0,
        'sales': 0,
        'message': 'Hello everynyan',
      });

      Navigator.pop(context);
      _showToast("Registration successful");
    } catch (e) {
      _showToast("Error during registration: ${e.toString()}");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( 
        padding: EdgeInsets.all(24), 
        child: Column(
          children: [
              SizedBox(height: 100),
              Text("Registration Page", 
              style: TextStyle(fontSize: 22, 
              fontWeight: FontWeight.bold,
              color: Colors.green
              ),
              ),
              TextField(
                controller: _nicknameController,
                decoration: InputDecoration(hintText: "Nickname")
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(hintText: "Email")
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "Password")
              ),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "Confirm Password")
              ),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Select Avatar ->", style: TextStyle(fontSize: 18)),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null ? Icon(Icons.add_a_photo, color: Colors.green) : null,
                  )
                )
              ]),
              if (_isLoading) ...[
                SizedBox(height: 20),
                LinearProgressIndicator(
                  value: _uploadProgress,
                ),
              ],
              SizedBox(height: 30),
              IconButton(
                iconSize: 60,
                icon: Icon(Icons.check_circle, color: Colors.green),
                onPressed: _isLoading ? null : _registerUser,
              )
            ],
        )),
    );
  }
}
