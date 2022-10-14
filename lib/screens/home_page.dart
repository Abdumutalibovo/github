import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github/models/user.dart';
import 'package:github/utils/images.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Future<UserModel?> getData() async {
    String url = "https://api.github.com/users/zayniddinmamarasulov";

    Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> json =
          jsonDecode(response.body) as Map<String, dynamic>;
      return UserModel.fromJson(json);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset(myImages.github_svg, color: Colors.white,),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Icon(Icons.notifications),
        )],
        backgroundColor: Colors.black.withOpacity(0.9),
      ),
      body: FutureBuilder<UserModel?>(
          future: getData(),
          builder: (BuildContext contet, AsyncSnapshot<UserModel?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              UserModel? userModel = snapshot.data;
              return Container(
                width: double.infinity,
                margin: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(userModel?.avatar_url ??
                                    myImages.google_image)),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userModel?.name ?? "",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                            Text(
                              userModel?.login ?? "",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Color(0xFF7F7F7F)),
                            left: BorderSide(color: Color(0xFF7F7F7F)),
                            right: BorderSide(color: Color(0xFF7F7F7F)),
                            bottom: BorderSide(color: Color(0xFF7F7F7F)),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Focusing"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF6F8FA),
                          border: Border(
                            top: BorderSide(color: Color(0xFF7F7F7F)),
                            left: BorderSide(color: Color(0xFF7F7F7F)),
                            right: BorderSide(color: Color(0xFF7F7F7F)),
                            bottom: BorderSide(color: Color(0xFF7F7F7F)),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                          child: Text(
                        "Edit profile",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          myImages.link_svg,
                          width: 10,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          child: Text(userModel?.blog ?? ""),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          myImages.followers_svg,
                          width: 15,
                        ),
                        SizedBox(width: 2,),
                        Text(
                          userModel?.followers.toString() ?? "",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(" followers• "),
                        Text(
                          userModel?.following.toString() ?? "",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(" following")
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    DefaultTabController(
                        length: 10,
                        child: Column(
                          children: [
                            TabBar(tabs: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.menu_book_rounded,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    "Overview",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.file_upload_outlined,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Repositories",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),

                            ])
                          ],
                        ))
                  ],
                ),
              );
            }
            return Container();
          }),
    );
  }
}
