import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moomentz/blocks/moomentz/moomentz_bloc.dart';
import 'package:moomentz/common/common/constants.dart';
import 'package:moomentz/common/common/navigation.dart';
import 'package:moomentz/models/moment.dart';

class MessagingScreen extends StatefulWidget {
  static String routeName = 'messaging_screen';
  const MessagingScreen({Key? key}) : super(key: key);

  @override
  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  var messageTextController = TextEditingController();
  late String messageText;
  var item;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        item = ModalRoute.of(context)!.settings.arguments as Moment;
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
                        'Messaging',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                  ],
                ),
                BlocConsumer<MoomentzBloc, MoomentzState>(
                  listener: (context, state) {
                    if (state is MessageLoaded) {
                      print(state.messageResponse);
                      const snackBar = SnackBar(content: Text('Message Sent'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  builder: (context, state) {
                    return Text('messages all');
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
                            if (user!.uid == item.host_id.toString()) {
                              BlocProvider.of<MoomentzBloc>(context).add(
                                  SendMessageGuestEvent(
                                      message:
                                          messageTextController.text.toString(),
                                      userId: user.uid,
                                      id: item.id));
                            } else {
                              BlocProvider.of<MoomentzBloc>(context).add(
                                  SendMessageHostEvent(
                                      message:
                                          messageTextController.text.toString(),
                                      userId: user.uid,
                                      id: item.id));
                            }
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
