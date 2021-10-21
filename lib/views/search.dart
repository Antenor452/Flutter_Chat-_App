import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchtext = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();
  QuerySnapshot? searchSnapshot;

  search() async {
    searchSnapshot = await databaseMethods.getUserByusername(searchtext.text);
    setState(() {});
  }

  Widget searchlist() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.size,
            itemBuilder: (context, index) {
              print(searchSnapshot!.docs.first['name']);
              return SearchTile(
                username: searchSnapshot!.docs.first['name'],
                email: searchSnapshot!.docs.first['email'],
              );
            })
        : Container(
            alignment: Alignment.center,
            child: Text(
              'No user found ',
              style: simpleTextStyle(),
            ),
          );
  }

  //Create a chatroom,send user converstaion screen,push Replacement

  createChatroomAndSendUserConvo(String username) {}

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(children: [
          Container(
            color: const Color(0x54FFFFFF),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                        controller: searchtext,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            hintText: "Search username",
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none))),
                GestureDetector(
                  onTap: search,
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Color(0x36FFFFFF),
                            Color(0x0FFFFFFF),
                          ]),
                          borderRadius: BorderRadius.circular(48)),
                      padding: const EdgeInsets.all(12),
                      child: Image.asset("assets/images/search_white.png")),
                )
              ],
            ),
          ),
          searchlist()
        ]),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final email;
  final username;
  const SearchTile({Key? key, this.email, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: meduimTextStyle(),
              ),
              Text(
                email,
                style: meduimTextStyle(),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              child: Text('Message', style: meduimTextStyle()),
            ),
          ),
        ],
      ),
    );
  }
}
