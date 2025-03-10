import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class EditDoctorProfile extends StatefulWidget {
  const EditDoctorProfile({Key? key}) : super(key: key);

  @override
  State<EditDoctorProfile> createState() => _EditDoctorProfileState();
}

class _EditDoctorProfileState extends State<EditDoctorProfile> {
  final currentUser = FirebaseAuth.instance.currentUser;
  bool _isEnabled = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nmcNo = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _qualifications = TextEditingController();
  final TextEditingController _affiliations = TextEditingController();
  final TextEditingController _experience = TextEditingController();
  final TextEditingController _specialization = TextEditingController();
  final TextEditingController _cost = TextEditingController();
  Uint8List? _profileImage;
  String _imgUrl = '';

  //get user details form firebase
  Future<DocumentSnapshot<Map<String, dynamic>>?> fetchUserDetails() async {
    print(currentUser!.uid+'dafasdfadfsa');

    if(currentUser!=null){
      final userDoc =
      FirebaseFirestore.instance.collection('doctors').doc(currentUser!.uid);

      DocumentSnapshot<Map<String, dynamic>> snapshot = await userDoc.get();

      if(snapshot.exists){
        Map<String, dynamic> data = snapshot.data()!;
        if(data['nmc no']!=null){
          _nmcNo.text = data['nmc no'];
        }

        if(data['contact']!=null){
          _contact.text = data['contact'];
        }

        if(data['qualifications']!=null){
          _qualifications.text = data['qualifications'];
        }

        if(data['affiliations']!=null){
          _affiliations.text = data['affiliations'];
        }

        if(data['experience']!=null){
          _experience.text = data['experience'];
        }

        if(data['specialization']!=null){
          _specialization.text = data['specialization'];
        }

        if(data['Cost']!=null){
          _cost.text = data['Cost'].toString();
        }

        if(data['img url']!=null){
          _imgUrl = data['img url'];
        }
      }

      return await userDoc.get();
    }
    return null;
  }

  //Update data to firebase
  Future<void> submitData() async{
      final db = FirebaseFirestore.instance;

      return db.collection('doctors').doc(currentUser!.uid).update(
          {
            'nmc no' : _nmcNo.text,
            'contact' : _contact.text,
            'qualifications' : _qualifications.text,
            'affiliations' : _affiliations.text,
            'experience' : _experience.text,
            'specialization' : _specialization.text,
            'validity' : true,
            'Cost' : int.parse(_cost.text),
            'img url' : _imgUrl
          }
          ).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      'Data updated successfully',
                    )
                )
            );

            Navigator.of(context).pop();
      }
      ).catchError((error) {
        print("Failed to update user: $error");
      });
  }

  //pick Image
  Future<void> pickImage() async{
    try{
      final ImagePicker imagePicker = ImagePicker();

      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

      if(file!=null){
        Uint8List img = await file.readAsBytes();

        setState(() {
          _profileImage = img;
        });
      }
    }

    catch(e){
      print('XXXXXXXXXXXXXXXX--$e--XXXXXXXXXXXX');
    }
  }

  // //pick Image
  // void selectImage() async {
  //   Uint8List img = await pickImage(ImageSource.gallery);
  //
  //   setState(() {
  //     _profileImage = img;
  //   });
  // }
  //
  // //pick image
  // pickImage(ImageSource imageSource) async{
  //   final ImagePicker imagePicker = ImagePicker();
  //   XFile? file = await imagePicker.pickImage(source: imageSource);
  //
  //   if(file!=null){
  //     return await file.readAsBytes();
  //   }
  //
  //   print('No image is selected');
  // }

  //upload image
  Future<void> uploadImage() async{

    if(_profileImage==null) return;

    final destination = 'profilePictures/doctors/${currentUser!.uid}';

    try{
      final ref = FirebaseStorage.instance.ref(destination);
      
      await ref.putData(_profileImage!);

      ref.getDownloadURL().then((value) {
        print('++++++++++$value====');
          // setState(() {
          _imgUrl = value;
       // });
      });
    }

    on FirebaseException catch(e){
      print('+++++$e');
      return;
    }
    // Reference reference = storage.ref().child('profilePictures').child('doctors').child(imageName);
    //
    // UploadTask uploadTask = reference.putData(image);
    // TaskSnapshot snapshot = await uploadTask;
    // snapshot.ref.getDownloadURL().then((value) {
    //   setState(() {
    //     imgUrl = value;
    //   });
    // });
  }

  // //store img in firebase storage
  // Future<void> uploadImage() async {
  //   String updatedImageUrl = await ImageUploader.uploadImage(currentUser!.uid, _profileImage!);
  //   print('===========$updatedImageUrl========');
  //   setState(() {
  //     imgUrl = updatedImageUrl;
  //   });
  //   print('===========$imgUrl========');
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _nmcNo.dispose();
    _contact.dispose();
    _qualifications.dispose();
    _affiliations.dispose();
    _experience.dispose();
    _specialization.dispose();
    _cost.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF5E1A84),
              Color(0xFF5E1A84),
              Color(0xFFD9D9D9),
              Color(0xFFD9D9D9),
            ],
            stops: [0.0, 0.25, 0.25, 1.0],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
              future: fetchUserDetails(),
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Align(
                    alignment: Alignment.center,
                      child: CircularProgressIndicator()
                  );
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Text('No user data found.');
                }

                final user = snapshot.data!.data();
                final name = user!['name'];
                final uid = currentUser!.uid;
                print(user!['name']);

                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),

                      //Back Button
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white
                              ),
                            ),
                          ),

                          const SizedBox(width: 60),

                          const Text(
                            'Doctor Details',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 30),

                      //Profile Container
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                width: 319,
                                height: 109,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //Image
                                    GestureDetector(
                                      onTap: _isEnabled? (){
                                        print('pressed-------------');

                                        pickImage();
                                        // selectImage();
                                        // updateProfileImage();
                                      } : null,
                                      // onTap : (){
                                      //   pickImage();
                                      //   // selectImage();
                                      // },
                                      child: Container(
                                        width: 77,
                                        height: 77,
                                        child: _imgUrl==''?  _profileImage!=null? ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Image.memory(
                                              _profileImage!,
                                          ),
                                        ) : ClipRRect(
                                            borderRadius: BorderRadius.circular(30),
                                          child : Image.asset(
                                            'assets/doctorImages/doctorPic.png'
                                          )
                                        )
                                        //Image.asset(
                                          // 'assets/doctorImages/doctorProfile.png',
                                          //fit: BoxFit.cover,
                                        //)
                                            : ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Image.network(
                                            _imgUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const Spacer(),


                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Dr. $name',
                                          style: const TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF5E1A84)
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        const Text(
                                          'User ID',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF5E1A84)
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        Text(
                                          uid,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF5E1A84)
                                          ),
                                        ),
                                      ],
                                    ),

                                    const Spacer()
                                  ],
                                )
                            ),

                            //Edit Button
                            Positioned(
                              right: 5,
                                child: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        _isEnabled = !_isEnabled;
                                      });
                                    }, 
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                    color: Color(0xFF5E1A84)
                                    )
                            )
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: 50),

                      Expanded(
                        child: Container(
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //NMC Number
                                  const Text(
                                    'NMC Number',
                                    style: TextStyle(
                                        color: Color(0xFF5E1A84),
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  //NMC Number
                                  Container(
                                    height: 43,
                                    child: TextFormField(
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "Enter NMC No.!!!";
                                        }

                                        else{
                                          return null;
                                        }
                                      },
                                      controller: _nmcNo,
                                      enabled: _isEnabled,
                                      decoration: InputDecoration(
                                        hintText: 'NMC Number',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF5E1A84)
                                            )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF5E1A84)
                                            )
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  //Contact Info
                                  const Text(
                                    'Contact Number',
                                    style: TextStyle(
                                        color: Color(0xFF5E1A84),
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  //Contact Info
                                  Container(
                                    height: 43,
                                    child: TextFormField(
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "Enter Contact Number!!!";
                                        }

                                        else if(value.length!=10){
                                          return "Contact number should be 10 digits!!!";
                                        }
                                        else{
                                          return null;
                                        }
                                      },
                                      controller: _contact,
                                      enabled: _isEnabled,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Contact Number',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF5E1A84)
                                            )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF5E1A84)
                                            )
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  //Qualifications
                                  const Text(
                                    'Qualifications',
                                    style: TextStyle(
                                        color: Color(0xFF5E1A84),
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  //Qualifications
                                  TextFormField(
                                    maxLines: 4,  // Adjust the number of lines as needed
                                    minLines: 2,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "Qualification Can't Be Empty";
                                      }

                                      else{
                                        return null;
                                      }
                                    },
                                    controller: _qualifications,
                                    enabled: _isEnabled,
                                    decoration: InputDecoration(
                                      hintText: 'Qualifications',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF5E1A84)
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF5E1A84)
                                          )
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  //Affiliated Hospitals
                                  const Text(
                                    'Affiliated Hospitals',
                                    style: TextStyle(
                                        color: Color(0xFF5E1A84),
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  //Affiliated Hospitals
                                  Container(
                                    height: 43,
                                    child: TextFormField(
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "Field Can't Be Empty!!";
                                        }

                                        else{
                                          return null;
                                        }
                                      },
                                      controller: _affiliations,
                                      enabled: _isEnabled,
                                      decoration: InputDecoration(
                                        hintText: 'Affiliated Hospitals',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF5E1A84)
                                            )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF5E1A84)
                                            )
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  //Experience
                                  const Text(
                                    'Experience',
                                    style: TextStyle(
                                        color: Color(0xFF5E1A84),
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  //Experience
                                  Container(
                                    height: 43,
                                    child: TextFormField(
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "Field Can't Be Empty!!";
                                        }

                                        else{
                                          return null;
                                        }
                                      },
                                      controller: _experience,
                                      enabled: _isEnabled,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(2),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Experience (in years)',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF5E1A84)
                                            )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF5E1A84)
                                            )
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  //Specialization
                                  const Text(
                                    'Specialization',
                                    style: TextStyle(
                                        color: Color(0xFF5E1A84),
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  //Specialization
                                  Container(
                                    height: 43,
                                    child: TextFormField(
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "Field Can't Be Empty!!";
                                        }

                                        else{
                                          return null;
                                        }
                                      },
                                      controller: _specialization,
                                      enabled: _isEnabled,
                                      decoration: InputDecoration(
                                        hintText: 'Specialization',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF5E1A84)
                                            )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF5E1A84)
                                            )
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  //Cost
                                  const Text(
                                    'Cost',
                                    style: TextStyle(
                                        color: Color(0xFF5E1A84),
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  //Cost
                                  Container(
                                    height: 43,
                                    child: TextFormField(
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "Enter NMC No.!!!";
                                        }

                                        else{
                                          return null;
                                        }
                                      },
                                      controller: _cost,
                                      enabled: _isEnabled,
                                      decoration: InputDecoration(
                                        hintText: 'NMC Number',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF5E1A84)
                                            )
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF5E1A84)
                                            )
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  //Submit Button
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 56,
                                    child: (_profileImage!=null)? FutureBuilder<void>(
                                        future: uploadImage(),
                                      builder: (context, snapshot){
                                          if(snapshot.connectionState==ConnectionState.waiting){
                                            return const Center(
                                                child: CircularProgressIndicator()
                                            );
                                          }
                                        return ElevatedButton(
                                          onPressed: ()async{
                                            if(_profileImage!=null){
                                              await uploadImage();
                                            }

                                            if(_formKey.currentState!.validate()){
                                              print('==========$_imgUrl');
                                              submitData();
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(0xFF5E1A84),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              )
                                          ),
                                          child: const Text(
                                            'Submit',
                                            style: TextStyle(
                                                fontSize: 18
                                            ),
                                          ),
                                        );
                                      },
                                    ) : ElevatedButton(
                                      onPressed: ()async{
                                        // if(_profileImage!=null){
                                        //   await uploadImage();
                                        // }

                                        if(_formKey.currentState!.validate()){
                                          print('==========$_imgUrl');
                                          submitData();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF5E1A84),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10)
                                          )
                                      ),
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                            fontSize: 18
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ]
                );
              },
            ),
        ),
      ),
    );
  }
}

// class MyCustomClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
//     // path.lineTo(size.width, 0);
//     // path.lineTo(size.width, size.height - 150);
//     // path.lineTo(0, size.height);
//     // path.lineTo(size.width, size.height);
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
