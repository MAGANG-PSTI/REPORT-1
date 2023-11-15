import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pkl_demeter_mobile/constants/utils/logger.dart';
import 'package:pkl_demeter_mobile/home/screens/home_screen.dart';

import 'package:pkl_demeter_mobile/home/widgets/dialog_box.dart';



class CameraScreens extends StatefulWidget {
  const CameraScreens({super.key});

  @override
  State<CameraScreens> createState() => _CameraScreensState();
}

class _CameraScreensState extends State<CameraScreens> {
late CameraController _cameraController;
bool isCameraInitialized = false;
XFile? _capturedImage;
late Future<void> initializeController;
bool hasCaptured = false;

// Capturing the Image Function.
Future<void> takePicture() async {
if(hasCaptured) {
  return;
}

try {
  setState((){
    hasCaptured = true;
  });
if(_cameraController.value.isTakingPicture) {
AppLogger.logError("Error while taking the picture.", "Picture is currently being taken.");
return;
}
XFile? image = await _cameraController.takePicture();

if(image != null) {
  setState((){
    _capturedImage = image;
  });
}
saveImage(image);
} catch(e){
AppLogger.logError("Camera failed. See log: ", e);
}finally {
setState((){
  hasCaptured = false;
});
}
}

// Saving the Image into Application dependency function.
Future<void> saveImage(XFile image) async {
try{
  final directory = await getApplicationDocumentsDirectory();
  final dateTime = DateTime.now().millisecondsSinceEpoch;
  final imagePath = "${directory.path}/$dateTime.png";

  final directoryFile =  Directory(directory.path);

  if(!await directoryFile.exists()) {
AppLogger.logInfo("The corresponding directory doesn't exists, creating a new one..");
await directoryFile.create(recursive:true);

  }
final File imageFile = File(imagePath);
await imageFile.writeAsBytes(await image.readAsBytes());
AppLogger.logInfo("Succesfully saved image to $imagePath");

DialogBox.dialogSuccess(context, "Image is succesfully saved.", (){});
} catch(e) {
AppLogger.logError("Error found.", e);
}
}

// Initializing camera upon startup function.
Future<void> _initializeCamera() async {
  final cameras = await availableCameras();
  final frontCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
  _cameraController = CameraController(frontCamera, ResolutionPreset.medium);

  try {
    await _cameraController.initialize();
 if(mounted) {
  setState((){
isCameraInitialized = true;
  });
 }
  } catch(e) {
    AppLogger.logError("Camera log error: ", e);
  }
}

@override
void initState() {
  super.initState();
   initializeController = _initializeCamera();

}

void dispose() {
  super.dispose();
  _cameraController.dispose();

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: ElevatedButton(onPressed:(){
      final navigator = Navigator.of(context);
      navigator.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomeScreen()), (route)=> false);

    }, child: Icon(Icons.arrow_back))),body: 
    SafeArea(
      child: Column(children: [
        if(isCameraInitialized)Expanded(child: 
        Stack(children: [CameraPreview(_cameraController),
      Align(alignment: Alignment.bottomCenter, child: 
      Container(padding: const EdgeInsets.all(16.0), child: 
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children:<Widget>[
          ElevatedButton(onPressed:(){takePicture();}, 
          child: const CircleAvatar(child: Icon(Icons.camera_alt, size: 40, color: Colors.black))),
        ]), decoration:BoxDecoration(color: Colors.black.withOpacity(0.5))))])) else 
        const Center(child: CircularProgressIndicator()),])
    ));
  }
}