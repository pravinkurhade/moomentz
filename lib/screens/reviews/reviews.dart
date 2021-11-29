import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moomentz/blocks/moomentz/moomentz_bloc.dart';
import 'package:moomentz/common/common/constants.dart';
import 'package:moomentz/common/common/navigation.dart';
import 'package:moomentz/models/moment.dart';
import 'package:moomentz/models/reviews/reviews_response.dart';

class ReviewScreen extends StatefulWidget {
  static String routeName = 'reviews_screen';
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  var messageTextController = TextEditingController();
  late String messageText;
  var item;
  List<ReviewsData> reviewsData = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        item = ModalRoute.of(context)!.settings.arguments as Moment;
        BlocProvider.of<MoomentzBloc>(context)
            .add(GetReviewsEvent(id: item.id));
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        'Reviews',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                  ],
                ),
                BlocConsumer<MoomentzBloc, MoomentzState>(
                  listener: (context, state) {
                    if (state is ReviewAddedLoaded) {
                      print(state.messageResponse);
                      const snackBar =
                          SnackBar(content: Text('Review Added Successfully'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      BlocProvider.of<MoomentzBloc>(context)
                          .add(GetReviewsEvent(id: item.id));
                    }
                    if (state is ReviewLoaded) {
                      reviewsData.clear();
                      reviewsData = state.reviewsResponse.reviews;
                    }
                  },
                  builder: (context, state) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: reviewsData.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = reviewsData[index];
                            var formattedDate =
                                DateFormat('kk:mm a . dd MMM,yyyy').format(
                                    DateTime.fromMicrosecondsSinceEpoch(
                                        item.created_on));
                            return Padding(
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              item.message.toString(),
                                              style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                                Text(formattedDate + '. 12 Km'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  },
                ),
                Container(
                  decoration: kMessageContainerDecoration,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: messageTextController,
                          onChanged: (value) {
                            messageText = value;
                          },
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.send),
                          tooltip: 'Send',
                          onPressed: () {
                            var user = FirebaseAuth.instance.currentUser;
                            BlocProvider.of<MoomentzBloc>(context).add(
                                AddReviewEvent(
                                    message:
                                        messageTextController.text.toString(),
                                    userId: user!.uid,
                                    id: item.id));
                            messageTextController.clear();
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
