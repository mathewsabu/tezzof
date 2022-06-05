import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AddImages extends StatefulWidget {
  ///The Widget takes height and width of the image add box as parameters
  const AddImages({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;
  static List<XFile> images = [];
  static List<File> compressedImageFiles = [];

  @override
  State<AddImages> createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  //List<XFile>? images = [];   /// List of XFile type objects to store the path of the image picked
  final ImagePicker _picker = ImagePicker();

  ///Image Picker instance
  List<Widget>? image = [];

  ///list of widgets used for children

  ///Function to build Children List Containg Images from XFile List and also adds a close button to deselect the image
  List<Widget>? takeImages() {
    List<XFile>? templist = AddImages.images;
    String path;
    Widget gridChild;
    List<Widget>? tempImage = [];
    for (int i = 0; i < templist!.length; i++) {
      path = templist[i].path;
      gridChild = Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ///Image Display widget
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                key: Key('$i'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                      image: Image.file(
                        File(path),
                      ).image,
                      fit: BoxFit.fitWidth),
                ),
                height: 200.0,
              ),
            ),
          ),

          ///close button widget
          GestureDetector(
            child: const Icon(
              Icons.close,
              size: 30,
            ),
            onTap: () {
              ///Here the Xfile object at the location where the close button is clicked is removed
              setState(() {
                AddImages.images.removeAt(i);
              });
            },
          ),
        ],
      );
      setState(() {
        ///Here the widgets are added to the Widget List intended to be used as children
        tempImage.add(gridChild);
      });
    }
    return tempImage;
  }

    Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 88,
        rotate: 180,
      );

    print(file.lengthSync());
    print(result!.lengthSync());

    return result;
  }

  @override
  Widget build(BuildContext context) {
    image = takeImages();
    image!.add(
      DottedBorder(
        color: Colors.blue,
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        padding: const EdgeInsets.all(6),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: GestureDetector(
            onTap: () async {
              var imageTemp = await _picker.pickMultiImage();
              for (int i = 0; i < imageTemp!.length; i++) {
                
              }
              setState(() {
                AddImages.images.addAll(imageTemp);
              });
            },
            child: Container(
              height: widget.height,
              width: widget.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add_a_photo, size: 50.0, color: Colors.blue)
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return Column(
      children: image!,
    );

    // return GridView.count(
    //   crossAxisCount: 2,
    //   padding: const EdgeInsets.all(20.0),
    //   crossAxisSpacing: 10,
    //   mainAxisSpacing: 10,
    //   children: [Image(image: AssetImage('images/cupcakes.jpg'))],
    // );
  }
}
