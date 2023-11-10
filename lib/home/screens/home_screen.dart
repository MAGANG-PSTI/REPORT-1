// ignore_for_file: use_build_context_synchronously

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pkl_demeter_mobile/auth/screens/login_page.dart';
import 'package:pkl_demeter_mobile/auth/services/auth_service.dart';
import 'package:pkl_demeter_mobile/constants/utils/tools.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:pkl_demeter_mobile/home/widgets/dialog_box.dart';
import 'package:pkl_demeter_mobile/provider/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    UserProvider propider = Provider.of<UserProvider>(context, listen: false); // Provider from UserProvider
    double width = MediaQuery.of(context).size.width; // Calculating the size of MediaQuery's width.
    
  
 // Prompting the user TO EITHER accept permission's storage.
    Future<bool> askForPermissionStorage(Permission permission) async {
   AndroidDeviceInfo deviceInfo = await DeviceInfoPlugin().androidInfo;
   
   // If Device version is Higher OR Equal to 30 (Android API 10), ask for Permission Storage.
if(deviceInfo.version.sdkInt >= 30) {
var re = await Permission.storage.request();

if(re.isGranted) {
return true;
} else {
  return false;
}

} else {
  if(await permission.isGranted) {
 return true;
  } else 
  {
    return false;
  }
}

   }
     // Checking IF the STORAGE permission is accepted or NOT.
     void onWarnPermissionStorage(BuildContext context) async {
bool isAccepted = await askForPermissionStorage(Permission.storage);

   if(!isAccepted) {
DialogBox.dialogWarning(context, "Oops. Looks like you haven't accepted the storage permission just yet.", () { askForPermissionStorage(Permission.storage);}, (){});
   } else {
    
   }
    }

// Displaying Bottom Sheet for Settings.
// void showBottomSheetSettings() async {

//   showFlexibleBottomSheet(maxHeight: 1,minHeight: 100,initHeight: 0.5,context: context, builder: builderBody, isDismissible: true,);

//   Widget builderBody() {
//   }
// }
    
    @override
void initState() {
  super.initState();
  onWarnPermissionStorage(context);
}

   

    return Scaffold(
        // ignore: unnecessary_null_comparison
        body: propider != null
            ? SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${propider.user.name}'s",
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("Homepage",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))
                              ],
                            ),
                            GestureDetector(
                                onTap: () {
                                  authService.signOut(context);
                                },
                                child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color:
                                            Tools.primaryColor.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Center(
                                        child:
                                            Icon(LineIcons.alternateSignOut))))
                          ],
                        ),
                        const SizedBox(height: 35),
                        Container(
                            width: double.infinity,
                            height: 145,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 0,
                                      spreadRadius: 0,
                                      offset: Offset(0, 0))
                                ],
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(207, 10, 255, 71)),
                            child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Row(children: <Widget>[
                                  Flexible(
                                    child: SizedBox(
                                        width: (width),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text("Account's Settings",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Tools.white)),
                                              Text("Version 1.0",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Tools.white)),
                                              GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                      width: 100,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                          color: Tools.black,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Center(
                                                        child: Text(
                                                            "View Settings",
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .white)),
                                                      )))
                                            ])),
                                  ),
                                  const SizedBox(width: 20),
                                  Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Tools.black),
                                      child: Center(
                                        child: Icon(Icons.settings,
                                            color: Tools.white,
                                            weight: 5.0,
                                            size: 30),
                                      ))
                                ]))),
                        const SizedBox(height: 30),
                        Container(
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Tools.shadow, offset: Offset(0, 3))
                                ],
                                color: Tools.white,
                                borderRadius: BorderRadius.circular(20)),
                            width: double.infinity,
                            height: 60,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Take Attendance",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Tools.black,
                                              fontWeight: FontWeight.w600)),
                                      InkWell(
                                          onTap: () {},
                                          child: Container(
                                              width: 70,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: Tools.secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Center(
                                                  child: Icon(LineIcons.plus,
                                                      color: Colors.white)))),
                                    ]))),
                        const SizedBox(height: 10),
                        Container(
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Tools.shadow, offset: Offset(0, 3))
                                ],
                                color: Tools.white,
                                borderRadius: BorderRadius.circular(20)),
                            width: double.infinity,
                            height: 60,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Gallery List",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Tools.black,
                                              fontWeight: FontWeight.w600)),
                                      InkWell(
                                          onTap: () {},
                                          child: Container(
                                              width: 70,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  color: Tools.secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Center(
                                                  child: Icon(
                                                      LineIcons.arrowRight,
                                                      color: Colors.white))))
                                    ]))),
                        const SizedBox(height: 25),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      width: (width / 2.5),
                                      height: (width / 2.5),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Tools.shadow,
                                                offset: Offset(0, 1),
                                                spreadRadius: 1)
                                          ],
                                          color: Tools.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(height: 1),
                                            Icon(LineIcons.chevronUp,
                                                size: 50,
                                                color: Tools.primaryColor),
                                            Text("Upload",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    color: Tools.black))
                                          ]))),
                              GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      width: (width / 2.5),
                                      height: (width / 2.5),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Tools.shadow,
                                                offset: Offset(0, 1),
                                                spreadRadius: 1)
                                          ],
                                          color: Tools.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(height: 1),
                                            Icon(LineIcons.questionCircleAlt,
                                                size: 50,
                                                color: Tools.primaryColor),
                                            Text("QnA",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    color: Tools.black))
                                          ])))
                            ])
                      ]),
                )),
              )
            : const LoginPage());
  }
}
