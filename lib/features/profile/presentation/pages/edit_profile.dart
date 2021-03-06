import 'dart:io';

import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:crossfit_kabod_app/core/presentation/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crossfit_kabod_app/core/data/res/data_constants.dart';
import 'package:crossfit_kabod_app/features/profile/data/model/user.dart';
import 'package:crossfit_kabod_app/features/profile/data/model/user_field.dart';
import 'package:crossfit_kabod_app/features/profile/data/service/user_db_service.dart';
import 'package:crossfit_kabod_app/features/profile/presentation/widgets/avatar.dart';
import 'package:crossfit_kabod_app/generated/l10n.dart';
import 'package:path/path.dart' as Path;

class EditProfile extends StatefulWidget {
  final UserModel user;

  const EditProfile({Key key, this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _addressController;
  bool _processing;
  AppState state;
  File _image;
  String _uploadedFileURL;

  @override
  void initState() {
    super.initState();
    _processing = false;
    state = AppState.free;
    _nameController = TextEditingController(text: widget.user.name);
    _phoneController = TextEditingController(text: widget.user.phone);
    _addressController = TextEditingController(text: widget.user.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).editProfile),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          Center(
            child: Avatar(
              showButton: true,
              onButtonPressed: _pickImageButtonPressed,
              radius: 50,
              image: state == AppState.cropped && _image != null
                  ? FileImage(_image)
                  : widget.user.photoUrl != null
                      ? NetworkImage(widget.user.photoUrl)
                      : AssetImage('images/profile_image.jpg'),
            ),
          ),
          const SizedBox(height: 10.0),
          Center(
              child: Text(
            widget.user.email,
            style: TextStyle(color: AppColors.textColor, fontSize: 18),
          )),
          const SizedBox(height: 10.0),
          TextField(
            style: TextStyle(color: AppColors.textColor, fontSize: 18),
            controller: _nameController,
            decoration: InputDecoration(
                labelText: S.of(context).nameFieldLabel,
                labelStyle: TextStyle(color: AppColors.primaryColor)),
          ),
          const SizedBox(height: 10.0),
          TextField(
            style: TextStyle(color: AppColors.textColor, fontSize: 18),
            controller: _phoneController,
            decoration: InputDecoration(
                labelText: S.of(context).phoneFieldLabel,
                labelStyle: TextStyle(color: AppColors.primaryColor)),
          ),
          const SizedBox(height: 10.0),
          TextField(
            style: TextStyle(color: AppColors.textColor, fontSize: 18),
            controller: _addressController,
            decoration: InputDecoration(
                labelText: S.of(context).addressFieldLabel,
                labelStyle: TextStyle(color: AppColors.primaryColor)),
          ),
          const SizedBox(height: 10.0),
          Center(
            child: RaisedButton(
              child: _processing
                  ? CircularProgressIndicator()
                  : Text(S.of(context).saveButtonLabel),
              onPressed: _processing
                  ? null
                  : () async {
                      //save name
                      if (_nameController.text.isEmpty &&
                          (_image == null || state != AppState.cropped)) return;
                      setState(() {
                        _processing = true;
                      });
                      if (_image != null && state == AppState.cropped) {
                        await uploadImage();
                      }
                      Map<String, dynamic> data = {};
                      if (_nameController.text.isNotEmpty)
                        data[UserFields.name] = _nameController.text;
                      if (_phoneController.text.isNotEmpty)
                        data[UserFields.phone] = _phoneController.text;
                      if (_addressController.text.isNotEmpty)
                        data[UserFields.address] = _addressController.text;
                      if (_uploadedFileURL != null)
                        data[UserFields.photoUrl] = _uploadedFileURL;
                      if (data.isNotEmpty) {
                        await userDBS.updateData(widget.user.id, data);
                      }
                      if (mounted) {
                        setState(() {
                          _processing = false;
                        });
                        Navigator.pop(context);
                      }
                    },
            ),
          )
        ],
      ),
    );
  }

  void _pickImageButtonPressed() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              S.of(context).pickImageDialogTitle,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ...ListTile.divideTiles(
                  color: Theme.of(context).dividerColor,
                  tiles: [
                    ListTile(
                      onTap: () {
                        getImage(ImageSource.camera);
                      },
                      title: Text(S.of(context).pickFromCameraButtonLabel),
                    ),
                    ListTile(
                      onTap: () {
                        getImage(ImageSource.gallery);
                      },
                      title: Text(S.of(context).pickFromGalleryButtonLabel),
                    ),
                  ],
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    S.of(context).cancelButtonLabel,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future getImage(ImageSource source) async {
    PickedFile image = await ImagePicker().getImage(source: source);
    if (image == null) return;
    setState(() {
      _image = File(image.path);
      _cropImage(_image);
      Navigator.pop(context);
    });
  }

  Future<Null> _cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: _image.path,
      maxWidth: 800,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  Future uploadImage() async {
    String path =
        '${AppDBConstants.usersStorageBucket}/${widget.user.id}/${Path.basename(_image.path)}';
    String url = await StorageService.instance.uploadFile(path, _image);
    setState(() {
      _uploadedFileURL = url;
    });
  }
}
