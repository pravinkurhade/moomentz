import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moomentz/blocks/moomentz/moomentz_bloc.dart';
import 'package:moomentz/common/common/navigation.dart';
import 'package:moomentz/models/moment.dart';
import 'package:moomentz/screens/momentdetails/momentsdetails.dart';

class CategoryList extends StatefulWidget {
  static String routeName = 'category_list_screen';

  const CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late List<Moment> moomentz = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        String category = ModalRoute.of(context)!.settings.arguments as String;
        print(category);
        BlocProvider.of<MoomentzBloc>(context).add(GetMomentsByCategoryEvent(
            lat: 37.338207, long: -121.88633, category: category));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var category = ModalRoute.of(context)!.settings.arguments as String?;
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
            if (state is MomentsByCategoryLoaded) {
              print(state.momentsResponse.feed.length);
              moomentz = state.momentsResponse.feed;
            }
          },
          builder: (context, state) {
            if (state is MomentsByCategoryLoaded) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
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
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              category!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25.0),
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
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image(
                                              height: 180,
                                              fit: BoxFit.cover,
                                              image: NetworkImage(item.banner),
                                            ),
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
                                                    Text(
                                                      item.name.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(formattedDate +
                                                        '. 12 Km'),
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
