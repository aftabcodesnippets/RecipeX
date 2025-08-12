import 'dart:developer' as developer;
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:recipe/themeprovider.dart';
import 'package:recipe/username.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    loadimage();
    getUser();
  }

  String? imagepath;
  String? namevalue;

  TextStyle ab = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.orange.shade400,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                pickimage();
              },
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.orange.shade400,

                backgroundImage: imagepath != null
                    ? FileImage(File(imagepath!))
                    : null,
                child: imagepath == null ? Icon(Icons.person, size: 70) : null,
              ),
            ),
            SizedBox(height: 20),

            Center(
              child: Text(
                'Hi $namevalue',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade400,
                ),
              ),
            ),
            SizedBox(height: 40),

            Consumer<Themeprovider>(
              builder: (ctx, pro, __) {
                return Card(
                  elevation: 4,
                  child: SwitchListTile.adaptive(
                    activeColor: Colors.orange.shade400,
                    title: Text('Dark Theme', style: ab),

                    value: pro.dark,
                    onChanged: (value) {
                      pro.updateTheme(value);
                    },
                  ),
                );
              },
            ),
            Card(
              elevation: 4,
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: Text('Terms & Conditions', style: ab),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '''By using RecipeX app, you agree to use it responsibly for personal cooking purposes only.
                       All recipes and content are provided “as is” without guarantees. 
                      We are not liable for any damages or issues caused by following recipes.
                       Please respect copyrights and do not misuse the app.
                        By continuing to use the app, you accept these terms.''',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 4,
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: Text('About Us', style: ab),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ''' We are a dedicated team committed to providing high-quality services and solutions to our users. Our mission is to deliv  exceptional experiences with a focus on reliability, innovation, and customer satisfaction. 
                        Thank you for choosing our app!''',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 4,
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: Text('Contact Us', style: ab),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Email: aftabliaqat933@gmail.com\n\n'
                        'For any inquiries, support, or feedback, please feel free to reach out to us via email. '
                        'We are always available to assist you and ensure you have the best experience with our app.'
                        '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),

            TextButton(
              onPressed: () async {
                var pref = await SharedPreferences.getInstance();
                await pref.clear();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Username()),
                  (route) => false,
                );
              },
              child: Text('Log Out', style: ab),
            ),
          ],
        ),
      ),
    );
  }

  Future<int> version() async {
    DeviceInfoPlugin deviceinfo = DeviceInfoPlugin();
    AndroidDeviceInfo info = await deviceinfo.androidInfo;
    return info.version.sdkInt;
  }

  Future<void> pickimage() async {
    PermissionStatus status;
    int sdkversion = await version();
    if (Platform.isAndroid) {
      if (sdkversion >= 33) {
        status = await Permission.photos.status;
        if (!status.isGranted) {
          status = await Permission.photos.request();
        }
      } else {
        status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
        }
      }
    } else {
      status = await Permission.photos.status;
      if (!status.isGranted) {
        status = await Permission.photos.request();
      }
    }

    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Center(child: Text('Permission is required!'))),
      );
    } else {
      try {
        final pickedimage = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (pickedimage != null) {
          CroppedFile? cropedimg = await ImageCropper().cropImage(
            sourcePath: pickedimage.path,

            uiSettings: [
              AndroidUiSettings(
                toolbarTitle: 'Crop Image',
                toolbarColor: Colors.orange.shade400,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: false,
                aspectRatioPresets: [
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.original,
                ],
              ),
              IOSUiSettings(title: 'Crop Image'),
            ],
          );
          if (cropedimg != null) {
            var pref = await SharedPreferences.getInstance();
            await pref.setString('key', cropedimg.path);
            imagepath = cropedimg.path;
            setState(() {});
          }
        }
      } catch (ex) {
        developer.log('error is :$ex');
      }
    }
  }

  Future<void> loadimage() async {
    var pref = await SharedPreferences.getInstance();
    imagepath = await pref.getString('key');
    setState(() {});
  }

    Future  <void> getUser() async {
    var pref = await SharedPreferences.getInstance();
    namevalue = await pref.getString('username');
    setState(() {});
  }
}
