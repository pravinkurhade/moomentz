import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moomentz/blocks/moomentz/moomentz_bloc.dart';
import 'package:moomentz/common/common/navigation.dart';
import 'package:moomentz/models/my_moments_response.dart';
import 'package:moomentz/screens/momentdetails/momentsdetails.dart';
import 'package:moomentz/screens/profile/profile.dart';

class MyMoments extends StatefulWidget {
  const MyMoments({Key? key}) : super(key: key);

  @override
  _MyMomentsState createState() => _MyMomentsState();
}

class _MyMomentsState extends State<MyMoments> {
  late List<MomentData> upcomingMoomentz = [];
  late List<MomentData> historyMoomentz = [];

  @override
  void initState() {
    var user = FirebaseAuth.instance.currentUser;
    BlocProvider.of<MoomentzBloc>(context).add(MyMomentsEvent(id: user!.uid));
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
        child: BlocConsumer<MoomentzBloc, MoomentzState>(
          listener: (context, state) {
            print(state);
            if (state is MyMomentsLoaded) {
              upcomingMoomentz = state.upcomingMomentsResponse.moments;
              historyMoomentz = state.historyMomentsResponse.moments;
            }
            if (state is ErrorState) {
              print(state.message);
            }
          },
          builder: (context, state) {
            if (state is MyMomentsLoaded) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Moomentz',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25.0),
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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Upcoming',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: upcomingMoomentz.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = upcomingMoomentz[index];
                              var formattedDate =
                                  DateFormat('kk:mm a . dd MMM,yyyy').format(
                                      DateTime.fromMicrosecondsSinceEpoch(
                                          item.start_time));
                              return GestureDetector(
                                onTap: () {
                                  Navigation.intentWithData(
                                      context, MomentDetails.routeName, item);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image(
                                          height: 150,
                                          width: 250,
                                          fit: BoxFit.cover,
                                          image: NetworkImage(item.banner),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name.toString(),
                                              style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(item.description),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(formattedDate + '. 12 Km'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Recent',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: historyMoomentz.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = historyMoomentz[index];
                              var formattedDate =
                                  DateFormat('kk:mm a . dd MMM,yyyy').format(
                                      DateTime.fromMicrosecondsSinceEpoch(
                                          item.start_time));
                              return GestureDetector(
                                onTap: () {
                                  Navigation.intentWithData(
                                      context, MomentDetails.routeName, item);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image(
                                          height: 150,
                                          width: 250,
                                          fit: BoxFit.cover,
                                          image: NetworkImage(item.banner),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name.toString(),
                                              style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(item.description),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(formattedDate + '. 12 Km'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is ErrorState) {
              return const Center(
                child: Text('Nothing to show',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              );
            }
            return const Center(
              child: Text('Loading...',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            );
          },
        ),
      ),
    );
  }
}
