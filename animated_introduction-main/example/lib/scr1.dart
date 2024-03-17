import 'package:flutter/material.dart';
import 'package:camera/camera.dart';


import 'imagePicker.dart';
class scr extends StatefulWidget {
  const scr({super.key});

  @override
  State<scr> createState() => _scrState();
}

class _scrState extends State<scr> {
  late CameraController _controller;
  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    await _controller.initialize();
  }



  void _showButtonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: SizedBox(
              height: 90,
              width: 100,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _initializeCamera();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen(controller: _controller),),
                      );
                    },
                    child: Text('Take Photo'),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GalleryImagePicker()));
                    },
                    child: Text('Choose from gallery'),
                  ),
                ],
              ),
            )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image(
            image: AssetImage("assets/scan.jpg"),
          ),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: (){
            _showButtonDialog(context);
          }, child:Text("Get Started")),
        ],
      ),
    );
  }
}


class CameraScreen extends StatelessWidget {
  final CameraController controller;

  const CameraScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: CameraPreview(controller),
    );
  }
}


