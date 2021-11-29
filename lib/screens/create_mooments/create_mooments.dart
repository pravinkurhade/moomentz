import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:moomentz/screens/profile/profile.dart';
import '../../blocks/moomentz/moomentz_bloc.dart';
import '../../models/creratemoment/createmoment_request.dart';
import '../../models/moment.dart';
import '../../common/common/constants.dart';

class CreateMomentScreen extends StatefulWidget {
  static String routeName = 'create_screen';
  const CreateMomentScreen({Key? key}) : super(key: key);

  @override
  _CreateMomentScreenState createState() => _CreateMomentScreenState();
}

class _CreateMomentScreenState extends State<CreateMomentScreen> {
  final TextEditingController _controllerCategory = TextEditingController();
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _controllerTime = TextEditingController();

  File? _image;
  String photoBase64 = '';

  @override
  Widget build(BuildContext context) {
    var dialog = SimpleDialog(
      title: const Text('Choose Category'),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () {
            _controllerCategory.text = 'International';
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('International'),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            _controllerCategory.text = 'Sports';
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Sports'),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            _controllerCategory.text = 'Trending';
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Trending'),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            _controllerCategory.text = 'Popular';
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Popular'),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            _controllerCategory.text = 'Tour Plan';
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Tour Plan'),
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            _controllerCategory.text = 'Nature';
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Nature'),
          ),
        ),
      ],
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocConsumer<MoomentzBloc, MoomentzState>(
            listener: (context, state) {
              if (state is CreateMomentLoaded) {
                _controllerCategory.text = '';
                _controllerTitle.text = '';
                _controllerDescription.text = '';
                _controllerAddress.text = '';
                _controllerDate.text = '';
                _controllerTime.text = '';
                _image = null;
                photoBase64 = '';
                const snackBar =
                    SnackBar(content: Text('Moment Created Successfully'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              return SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Add Mooment',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    ProfileScreen.routeName,
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  alignment:
                                      Alignment.centerLeft, // This is needed
                                  child: Image.asset(
                                    'images/user.png',
                                    fit: BoxFit.contain,
                                    width: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Category',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextFormField(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return dialog;
                                      },
                                    );
                                  },
                                  readOnly: true,
                                  controller: _controllerCategory,
                                  decoration: InputDecoration(
                                    enabledBorder: border,
                                    disabledBorder: border,
                                    suffixIcon:
                                        Icon(Icons.arrow_drop_down_outlined),
                                    border: border,
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Sports',
                                    contentPadding: const EdgeInsets.all(16.0),
                                  ),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enter Title',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextFormField(
                                  controller: _controllerTitle,
                                  decoration: InputDecoration(
                                    enabledBorder: border,
                                    disabledBorder: border,
                                    border: border,
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Enter Title Here',
                                    contentPadding: const EdgeInsets.all(16.0),
                                  ),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add Image',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _showPicker(context);
                                  },
                                  child: _image != null
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Container(
                                              height: 150,
                                              alignment: Alignment
                                                  .center, // This is needed
                                              child: Image.file(
                                                _image!,
                                                width: double.infinity,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            height: 160,
                                            alignment: Alignment
                                                .center, // This is needed
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Image.asset(
                                                'images/imageplaceholder.png',
                                                fit: BoxFit.fill,
                                                width: 130,
                                                height: 100,
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enter Description',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextFormField(
                                  controller: _controllerDescription,
                                  decoration: InputDecoration(
                                    enabledBorder: border,
                                    disabledBorder: border,
                                    border: border,
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Enter Description Here',
                                    contentPadding: const EdgeInsets.all(16.0),
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  minLines:
                                      3, //Normal textInputField will be displayed
                                  maxLines: 5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Address',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextFormField(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlacePicker(
                                          apiKey:
                                              'AIzaSyBTLOXcA8rPmWaMdG18qFbltZOz1tMrOc0', // Put YOUR OWN KEY here.
                                          onPlacePicked: (result) {
                                            print(result.formattedAddress);
                                            print(
                                                result.geometry!.location.lat);
                                            print(
                                                result.geometry!.location.lng);
                                            _controllerAddress.text =
                                                result.formattedAddress!;
                                            Navigator.of(context).pop();
                                          },
                                          initialPosition: const LatLng(
                                              -33.8567844, 151.213108),
                                          useCurrentLocation: true,
                                        ),
                                      ),
                                    );
                                  },
                                  controller: _controllerAddress,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    enabledBorder: border,
                                    disabledBorder: border,
                                    border: border,
                                    filled: true,
                                    prefixIcon:
                                        Icon(Icons.location_on_outlined),
                                    fillColor: Colors.white,
                                    hintText: 'Address',
                                    contentPadding: const EdgeInsets.all(16.0),
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  minLines:
                                      2, //Normal textInputField will be displayed
                                  maxLines: 5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: TextFormField(
                                        onTap: () async {
                                          DateTime? date = DateTime(1900);
                                          date = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2100));
                                          print(date!.toIso8601String());
                                          var formatter =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(date);
                                          _controllerDate.text = formatter;
                                        },
                                        readOnly: true,
                                        controller: _controllerDate,
                                        decoration: InputDecoration(
                                          enabledBorder: border,
                                          disabledBorder: border,
                                          border: border,
                                          filled: true,
                                          prefixIcon: Icon(
                                              Icons.calendar_today_outlined),
                                          fillColor: Colors.white,
                                          hintText: 'Select Date',
                                          contentPadding:
                                              const EdgeInsets.all(16.0),
                                        ),
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Time',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: TextFormField(
                                        onTap: () async {
                                          var initialTime = TimeOfDay.now();
                                          var pickedTime = await showTimePicker(
                                            context: context,
                                            initialTime: initialTime,
                                          );
                                          print(pickedTime);
                                          _controllerTime.text =
                                              pickedTime!.format(context);
                                        },
                                        readOnly: true,
                                        controller: _controllerTime,
                                        decoration: InputDecoration(
                                          enabledBorder: border,
                                          disabledBorder: border,
                                          border: border,
                                          filled: true,
                                          prefixIcon: Icon(
                                              Icons.calendar_today_outlined),
                                          fillColor: Colors.white,
                                          hintText: 'Select Time',
                                          contentPadding:
                                              const EdgeInsets.all(16.0),
                                        ),
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextButton(
                            style: raisedButtonStyle,
                            onPressed: createMoment,
                            child: const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _imgFromCamera() async {
    final _picker = ImagePicker();
    var pickedFile = await _picker.getImage(
      maxWidth: 200,
      maxHeight: 100,
      imageQuality: 100,
      source: ImageSource.camera,
    );
    setState(() {
      List<int> imageBytes = File(pickedFile!.path).readAsBytesSync();
      print(imageBytes);
      photoBase64 = base64Encode(imageBytes);
      print(photoBase64);
      _image = File(pickedFile.path);
    });
  }

  _imgFromGallery() async {
    final _picker = ImagePicker();
    var pickedFile = await _picker.getImage(
      maxWidth: 200,
      maxHeight: 100,
      imageQuality: 100,
      source: ImageSource.gallery,
    );
    setState(() {
      List<int> imageBytes = File(pickedFile!.path).readAsBytesSync();
      print(imageBytes);
      photoBase64 = base64Encode(imageBytes);
      print(photoBase64);
      _image = File(pickedFile.path);
    });
  }

  void createMoment() {
    var user = FirebaseAuth.instance.currentUser;
    print(user!.uid);
    var coordinates = <double>[];
    coordinates.add(-121.88633);
    coordinates.add(37.338207);
    var moment = CreateMoment(
        id: _controllerTitle.text,
        name: _controllerTitle.text,
        description: _controllerDescription.text,
        category: _controllerCategory.text,
        banner:
            'https://storage.googleapis.com/moomentz-moments/63bc5e8a-feb4-444a-b423-32341e5200a1/banner.jpeg',
        host_id: user.uid,
        address: _controllerAddress.text,
        start_time: 1631385000000,
        duration: 4542,
        invite_accept_auth: 'yes',
        invites: 40,
        images: [],
        tags: ['test'],
        location: LocationData(coordinates: coordinates, type: 'Point'),
        announcements: [],
        reviews: []);
    BlocProvider.of<MoomentzBloc>(context)
        .add(CreateMomentEvent(createMoment: moment));
  }
}
