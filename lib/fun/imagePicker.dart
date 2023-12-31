import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? selectedImage;
  String base64Image = "";

  Future<void> chooseImage(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        // won't have any error now
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Expanded(
            child: CircleAvatar(
              radius: 100,
              child: selectedImage != null
                  ? Image.file(
                      selectedImage!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/default_image.png',fit: BoxFit.fill,),
            ),
          ),
          Positioned(
            top: 130,
            left: 150,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(40)
              ),
              child: IconButton(
                  onPressed: () {
                  showBottomSheet(context: (context), builder: (context)=>BottomSheet());
                  }, icon: const Icon(Icons.add_a_photo,size: 25,)),
            ),
          ),

          // Expanded(
          //   child: SizedBox(
          //     height: 30,
          //     child: Card(
          //
          //       color: Colors.red,
          //       margin: EdgeInsets.zero,
          //       child:InkWell(
          //         onTap: (){
          //
          //         },
          //         child: const Text(
          //           "Add Image",
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //               fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          //
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget BottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Select Image'),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(

                onPressed: () async {
                  chooseImage("camera");
                  Navigator.of(context).pop();
                },
                child: const Text("Open Camera"),
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    chooseImage("gallery");
                    Navigator.of(context).pop();
                  },
                  child: const Text("Open Gallery"))
            ],
          )
        ],
      ),
    );
  }
}
