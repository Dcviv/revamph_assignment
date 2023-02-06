import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revamph_assignment/components/dropdown.dart';
import 'package:revamph_assignment/screens/home_screen.dart';
import 'package:revamph_assignment/widgets/buttons.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  int currentStep = 0;
  bool isCompleted = false; //check completeness of inputs
  final formKey =
      GlobalKey<FormState>(); //form object to be used for form validation

  final name = TextEditingController();
  final email = TextEditingController();
  final mobile = TextEditingController();
  final password = TextEditingController();
  final collegeName = TextEditingController();
  final year = TextEditingController();
  final studenTypeController = TextEditingController();
  String studentType = '';
  String yearType = '';

  final profilePic = TextEditingController();
  final resume = TextEditingController();

  File? imageFile;
  String? imageUrl;
  String? myImage;

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Please choose an option"),
            content: Column(
              children: [
                InkWell(
                  onTap: () {
                    _getFromCamera(context);
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.camera,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    //open gallery
                    _getFromGallery(context);
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.image,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Gallery",
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  void _getFromCamera(BuildContext context) async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
    _cropImage(pickedImage!.path);
    //Navigator.pop(context);
  }

  void _getFromGallery(BuildContext context) async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
    _cropImage(pickedImage!.path);
    //Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Theme(
        data: Theme.of(context)
            .copyWith(colorScheme: ColorScheme.light(primary: Colors.blue)),
        child: Form(
          key: formKey,
          child: Stepper(
            steps: getSteps(),
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepTapped: (step) {
              formKey.currentState!.validate(); //this will trigger validation
              setState(() {
                currentStep = step;
              });
            },
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;
              formKey.currentState!.validate();
              bool isDetailValid =
                  isDetailComplete(); //this check if ok to move on to next screen

              if (isDetailValid) {
                if (isLastStep) {
                  setState(() {
                    isCompleted = true;
                  });
                } else {
                  setState(() {
                    currentStep += 1;
                  });
                }
              }
            },
            onStepCancel: () {
              if (currentStep == 0) {
                null;
              } else {
                setState(() {
                  currentStep -= 1;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  bool isDetailComplete() {
    if (currentStep == 1) {
      if (name.text.isEmpty ||
          email.text.isEmpty ||
          password.text.isEmpty ||
          mobile.text.isEmpty) {
        return false;
      } else {
        return true;
      }
    } else if (currentStep == 2) {
      if (collegeName.text.isEmpty || year.text.isEmpty) {
        return false;
      } else {
        return true;
      }
    } else if (currentStep == 3) {
      return true;
    }
    return false;
  }

  List<Step> getSteps() => [
        Step(
            title: const Text('1'),
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            content: Column(children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Student/ Alumni/ Faculty'),
                controller: studenTypeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "*Required";
                  }

                  return null;
                },
              ),
            ])
            // content: DropdownButton(
            //     value: studentType,
            //     hint: Text("Choose an item"),
            //     items: [
            //       DropdownMenuItem(
            //         child: Text("Student"),
            //         value: "Student",
            //       ),
            //       DropdownMenuItem(
            //         child: Text("Alumni"),
            //         value: "Alumni",
            //       ),
            //       DropdownMenuItem(
            //         child: Text("Faculty"),
            //         value: "Faculty",
            //       )
            //     ],
            //     onChanged: (newValue) {
            //       //print(newValue);
            //       setState(() {
            //         studentType = newValue.toString();
            //         yearType = studentType == 'Student'
            //             ? 'Admission Year'
            //             : 'Passout Year';
            //       });
            //     }),
            ),
        Step(
            title: const Text('2'),
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            content: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  controller: name,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return "*Enter correct name.";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  controller: email,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                      return "*Enter correct email.";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Mobile'),
                  controller: mobile,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
                            .hasMatch(value)) {
                      return "*Enter correct mobile.";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  controller: password,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)")
                            .hasMatch(value)) {
                      return "*Password should contain capital letter (A-Z), small letter(a-z) ,number(0-9) and special character.";
                    }

                    return null;
                  },
                ),
              ],
            )),
        Step(
            title: const Text('3'),
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 2,
            content: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'College Name'),
                  controller: collegeName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "*Required.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Passout Year'),
                  controller: year,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r'^(19|20)\d{2}$').hasMatch(value)) {
                      return "*Year should be between 1900-2099.";
                    }
                    return null;
                  },
                ),
              ],
            )),
        Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: const Text('4'),
          content: Column(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Profile Picture'),
              controller: profilePic,
              onTap: () {
                _showImageDialog();
              },
              validator: (imageFile) {
                if (imageFile == null) {
                  return "*Required.";
                }
                return null;
              },
            ),
            //ImageFormField(),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Resume'),
              controller: resume,
              validator: (value) {
                if (true) {
                  return null;
                }
                return null;
              },
            ),
            Button(
              text: "Submit",
              press: () async {
                if (imageFile == null) {
                  Fluttertoast.showToast(msg: "Please pick an image.");
                  return;
                }
                try {
                  //sign up user with credentials and storing user image in storage
                  final ref = FirebaseStorage.instance
                      .ref()
                      .child("userImages")
                      .child(DateTime.now().toString() + ".jpg");
                  await ref.putFile(imageFile!);
                  imageUrl = await ref.getDownloadURL();
                  await _auth.createUserWithEmailAndPassword(
                      email: email.text.trim().toLowerCase(),
                      password: password.text.trim());

                  //Adding user info to firestore
                  final User? user =
                      _auth.currentUser; //User is from firebase user
                  final _uid = user!.uid;
                  FirebaseFirestore.instance.collection("users").doc(_uid).set({
                    'id': _uid,
                    'userImage': imageUrl,
                    'name': name.text,
                    'email': email.text.trim(),
                    'password': password.text,
                    'phoneNo.': mobile.text,
                    'collegeName': collegeName.text,
                    'year': year.text
                  });

                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                } catch (error) {
                  Fluttertoast.showToast(msg: error.toString());
                }
                //move to home page

                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              },
            ),
          ]),
        )
      ];
}
