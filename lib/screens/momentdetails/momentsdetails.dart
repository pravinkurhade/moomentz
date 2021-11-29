import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:moomentz/common/common/constants.dart';
import 'package:moomentz/common/common/navigation.dart';
import 'package:moomentz/screens/messaging/messaging.dart';
import 'package:moomentz/screens/reviews/reviews.dart';
import '../../blocks/moomentz/moomentz_bloc.dart';
import '../../models/moment.dart';

class MomentDetails extends StatefulWidget {
  static String routeName = 'moment_details_screen';

  const MomentDetails({Key? key}) : super(key: key);

  @override
  _MomentDetailsState createState() => _MomentDetailsState();
}

class _MomentDetailsState extends State<MomentDetails> {
  var item;
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        final item = ModalRoute.of(context)!.settings.arguments as Moment;
        BlocProvider.of<MoomentzBloc>(context).add(GetMomentEvent(id: item.id));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: BlocConsumer<MoomentzBloc, MoomentzState>(
              listener: (context, state) {
                if (state is MomentLoaded) {
                  print(state.moment);
                  item = state.moment;
                }
                if (state is JoinMomentLoaded) {
                  const snackBar =
                      SnackBar(content: Text('Moment Joined Successfully'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              builder: (context, state) {
                if (state is MomentLoaded || state is JoinMomentLoaded) {
                  var formattedDate = DateFormat('kk:mm a . dd MMM,yyyy')
                      .format(
                          DateTime.fromMicrosecondsSinceEpoch(item.start_time));
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigation.back(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      'images/backbutton.png',
                                      fit: BoxFit.fill,
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Moomentz',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0),
                                ),
                              ),
                            ],
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image(
                                      height: 180,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(item.banner),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.name.toString(),
                              style: const TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.description),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'images/time.png',
                                  fit: BoxFit.cover,
                                  height: 15,
                                  width: 15,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  formattedDate + '. 12 Km',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Container(
                                      height: 150,
                                      child: GoogleMap(
                                        zoomControlsEnabled: false,
                                        onMapCreated: _onMapCreated,
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(
                                              item.location.coordinates[0],
                                              item.location.coordinates[1]),
                                          zoom: 11.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'images/location.png',
                                  fit: BoxFit.contain,
                                  height: 15,
                                  width: 15,
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(item.address,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('About this Place',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.description),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              style: raisedButtonStyle,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, MessagingScreen.routeName,
                                    arguments: item);
                              },
                              child: const Text('Messages'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              style: raisedButtonStyle,
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ReviewScreen.routeName,
                                    arguments: item);
                              },
                              child: const Text('Reviews'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              style: raisedButtonStyle,
                              onPressed: () {
                                var user = FirebaseAuth.instance.currentUser;
                                BlocProvider.of<MoomentzBloc>(context).add(
                                    JoinMomentEvent(
                                        id: item.id, userId: user!.uid));
                              },
                              child: const Text('Join'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const Center(
                  child: Text('Loading...',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                );
              },
            ),
          )),
    );
  }
}
