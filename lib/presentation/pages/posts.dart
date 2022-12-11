
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:three_pam/presentation/pages/postDetails.dart';

import '../../domain/Welcome.dart';

class SecondRoute extends StatefulWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  State<SecondRoute> createState() => SecondRouteState();
}

class SecondRouteState extends State<SecondRoute> {
  final storage = LocalStorage('shop');
  final baseUrl = 'http://mobile-shop-api.hiring.devebs.net/products';
  int page = 1;

  final int limit = 5;

  bool isFirstLoadRunning = false;
  bool hasNextPage = true;

  bool isLoadMoreRunning = false;

  Welcomes posts = Welcomes(welcomes: []);

  saveToStorage() {
    storage.setItem('posts', posts.welcomes);
  }

  void loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        controller.position.extentAfter < 100) {
      setState(() {
        isLoadMoreRunning = true;
        page += 1; // Display a progress indicator at the bottom
      });
      // Increase page by 1

      try {
        var dio = Dio();
        final res = await dio.get("$baseUrl?page=$page&limit=$limit");
        final Welcomes fetchedPosts = Welcomes.fromJson(res.data);

        if (res.data['current_page'] == res.data['total_pages']) {
          setState(() {
            hasNextPage = false;
          });
        }
        if (fetchedPosts.welcomes.isNotEmpty) {
          setState(() {
            posts.welcomes.addAll(fetchedPosts.welcomes);
          });
        } else {
          setState(() {
            hasNextPage = false;
          });
        }
      } catch (err) {
        print(err);
        setState(() {
          hasNextPage = false;
        });
        print('Something went wrong!');
      }
      setState(() {
        isLoadMoreRunning = false;
      });
    }
  }

  void firstLoad() async {
    setState(() {
      isFirstLoadRunning = true;
    });
    try {
      var dio = Dio();
      final res = await dio.get("$baseUrl?page=$page&per_page=$limit");
      final Welcomes test = Welcomes.fromJson(res.data);
      setState(() {
        posts = test;
      });
      saveToStorage();
    } catch (err) {
      print(err);
      print('Something went wrong');
    }
    setState(() {
      isFirstLoadRunning = false;
    });
  }

  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    firstLoad();
    controller = ScrollController()..addListener(loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display the data loaded from sample.json
            Container(
              margin: const EdgeInsets.fromLTRB(16, 53, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Categories",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: 120,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: posts.welcomes.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(children: <Widget>[
                        Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          margin: const EdgeInsets.fromLTRB(16, 0, 16, 15),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(244, 244, 244, 1),
                                offset: Offset(0, 6), // Shadow position
                              ),
                            ],
                          ),
                          child: Image.network(
                            posts.welcomes[index].category.icon,
                            width: 60,
                            height: 60,
                          ),
                        ),
                        SizedBox(
                          width: 60,
                          child: Text(posts.welcomes[index].category.name,
                              style: const TextStyle(
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                                color: Color.fromRGBO(0, 0, 0, 1),
                              )),
                        )
                      ]);
                    },
                  ),
                )

                // ])
                ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    "Best Selling",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(0, 0, 0, 1)),
                  )
                ],
              ),
            ),
            Container(
              child: posts.welcomes.isNotEmpty
                  ? Expanded(
                      child: SingleChildScrollView(
                          controller: controller,
                          scrollDirection: Axis.vertical,
                          child: Wrap(
                            spacing: 10.0,
                            alignment: WrapAlignment.start,
                            runSpacing: 2.0,
                            children: List.generate(
                              posts.welcomes.length,
                              (index) {
                                return GestureDetector(
                                    onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PostRoute(data: posts.welcomes[index])),
                                        ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.network(
                                            posts.welcomes[index].mainImage,
                                            width: 175,
                                            height: 225,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 80,
                                          width: 150,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                posts.welcomes[index].name,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1)),
                                              ),
                                              Text(
                                                posts.welcomes[index].category
                                                    .name,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color.fromRGBO(
                                                        146, 146, 146, 1)),
                                              ),
                                              Text(
                                                'MD${posts.welcomes[index].price}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        0, 197, 105, 1)),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ));
                              },
                            ),
                          )))
                  : Container(),
              // ])
            ),
          ],
        ),
      ),
    );
  }
}
