import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moomentz/screens/profile/profile.dart';
import '../../blocks/moomentz/moomentz_bloc.dart';
import '../../common/common/navigation.dart';
import '../../models/moment.dart';
import '../momentdetails/momentsdetails.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Moment> moomentz = [];

  @override
  void initState() {
    BlocProvider.of<MoomentzBloc>(context)
        .add(GetMomentsEvent(lat: 37.338207, long: -121.88633));
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
            if (state is MomentsLoaded) {
              print(state.momentsResponse.feed.length);
              moomentz = state.momentsResponse.feed;
            }
          },
          builder: (context, state) {
            if (state is MomentsLoaded) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Home',
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
                      Expanded(
                        child: ListView.builder(
                            itemCount: moomentz.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = moomentz[index];
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
                                  padding: const EdgeInsets.all(4.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Stack(
                                            children: <Widget>[
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.network(
                                                  item.banner,
                                                  height: 180,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                  alignment: Alignment.topRight,
                                                  child: PopupMenuButton(
                                                      itemBuilder: (_) => <
                                                              PopupMenuItem<
                                                                  String>>[
                                                            new PopupMenuItem<
                                                                    String>(
                                                                child: const Text(
                                                                    'ActionOne'),
                                                                value:
                                                                    'ActionOne'),
                                                            new PopupMenuItem<
                                                                    String>(
                                                                child: const Text(
                                                                    'ActionTwo'),
                                                                value:
                                                                    'ActionTwo'),
                                                          ],
                                                      onSelected:
                                                          (value) async =>
                                                              print(value))),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        item.name.toString(),
                                                        style: const TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                          formattedDate +
                                                              '. 12 Km'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(item.description),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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
