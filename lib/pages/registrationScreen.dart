import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/fun/imagePicker.dart';
import 'package:time_tracker/fun/textfield.dart';

import '../constants.dart';
import '../fun/navigation.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isVisible = false;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          const ImagePickerScreen(),
          SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                kTextFormField(
                  icon: const Icon(Icons.person),
                  lable: 'Name',
                  kController: name,
                  validator: (val) {
                    if (val == null || val == "") {
                      if (kDebugMode) {
                        print("null name");
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                kTextFormField(
                  icon: const Icon(Icons.email),
                  lable: 'Email',
                  kController: email,
                  validator: (val) {
                    if (val == null || val == "") {
                      if (kDebugMode) {
                        print("null name");
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                kTextFormField(
                  suffixIcon: IconButton(
                    icon: isVisible
                        ? const Icon(
                      Icons.remove_red_eye_outlined,
                      size: 25,
                      semanticLabel: 'show password',
                    )
                        : const Icon(Icons.visibility_off,
                        size: 25, semanticLabel: 'Hide password'),
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                  ),
                  lable: 'Password',
                  kController: password,
                  obscure: true,
                  icon: const Icon(Icons.key),
                  validator: (val) {
                    if (val == null || val == "") {
                      return 'Please Enter your Password';
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Kname = name.text.trim();
                      Kemail =email.text.trim();
                    });
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => BottomNavigation(
                          currentIndex: 1,
                        )));
                  },
                  child: Container(
                    width: size.width *60,
                    decoration: BoxDecoration(
                        color: kNButtonColor,
                        borderRadius: BorderRadius.circular(10)
                    ),

                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Center(child: Text('Register',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
