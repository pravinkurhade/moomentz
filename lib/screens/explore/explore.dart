import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moomentz/blocks/moomentz/moomentz_bloc.dart';
import 'package:moomentz/common/common/constants.dart';
import 'package:moomentz/common/common/navigation.dart';
import 'package:moomentz/models/categories_response.dart';
import 'package:moomentz/models/moment.dart';
import 'package:moomentz/screens/categorylist/categorylist.dart';
import 'package:moomentz/screens/momentdetails/momentsdetails.dart';
import 'package:moomentz/screens/profile/profile.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late List<Moment> moomentz = [];
  late List<CategoriesData> categories = [];
  bool categoriesView = true;
  final menus = [
    'International',
    'Sports',
    'Trending',
    'Popular',
    'Tour Plan',
    'Nature'
  ];

  @override
  void initState() {
    BlocProvider.of<MoomentzBloc>(context).add(GetCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    onItemChanged(String value) {
      if (value.isNotEmpty) {
        categoriesView = false;
        BlocProvider.of<MoomentzBloc>(context).add(
            SearchMomentEvent(lat: 37.338207, long: -121.88633, text: value));
      } else {
        setState(() {
          categoriesView = true;
          moomentz.clear();
          BlocProvider.of<MoomentzBloc>(context).add(GetCategoriesEvent());
        });
      }
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
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
                        'Explore',
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
                          alignment: Alignment.centerLeft, // This is needed
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
                  child: TextFormField(
                    onChanged: onItemChanged,
                    decoration: InputDecoration(
                      enabledBorder: border,
                      disabledBorder: border,
                      border: border,
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search Something',
                      contentPadding: const EdgeInsets.all(16.0),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                BlocConsumer<MoomentzBloc, MoomentzState>(
                  listener: (context, state) {
                    if (state is MomentsLoaded) {
                      print(state.momentsResponse.feed.length);
                      moomentz = state.momentsResponse.feed;
                    }

                    if (state is CategoriesLoaded) {
                      print(state.categoriesResponse.categories.length);
                      categories = state.categoriesResponse.categories;
                    }
                  },
                  builder: (context, state) {
                    if (!categoriesView) {
                      return Expanded(
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
                      );
                    } else {
                      if (state is CategoriesLoaded) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: 0.80,
                              mainAxisSpacing: 1.0,
                              crossAxisSpacing: 1.0,
                              shrinkWrap: true,
                              children:
                                  List.generate(categories.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CategoryList.routeName,
                                        arguments: categories[index].id);
                                    print(categories[index]);
                                  },
                                  child: GridTile(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.network(
                                              categories[index].url,
                                              width: 160,
                                              height: 180,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            categories[index].name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 15.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('Loading...',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
