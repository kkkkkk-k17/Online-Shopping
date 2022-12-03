import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondRoute extends StatefulWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  State<SecondRoute> createState() => SecondRouteState();
}

class News {
  String cover;
  String title;

  News({required this.cover, required this.title});
}

class SecondRouteState extends State<SecondRoute> {
  List dataList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      dataList = Provider.of(context);
    });
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
              child: dataList[0].isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: dataList[0].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(children: <Widget>[
                            Container(
                              width: 60,
                              height: 60,
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 10),
                              margin: const EdgeInsets.fromLTRB(16, 0, 10, 15),
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
                                dataList[0][index]["icon"],
                              ),
                            ),
                            Text(dataList[0][index]["title"],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ))
                          ]);
                        },
                      ),
                    )
                  : Container(),
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
              child: dataList[1].isNotEmpty
                  ? Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Wrap(
                            spacing: 10.0,
                            alignment: WrapAlignment.start,
                            runSpacing: 2.0,
                            children: List.generate(
                              dataList[1].length,
                              (index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        dataList[1][index]["cover"],
                                        width: 150,
                                        height: 200,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 70,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dataList[1][index]["title"],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1)),
                                          ),
                                          Text(
                                            dataList[1][index]["sub_title"],
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Color.fromRGBO(
                                                    146, 146, 146, 1)),
                                          ),
                                          Text(
                                            dataList[1][index]["currency"] +
                                                dataList[1][index]["price"]
                                                    .toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    0, 197, 105, 1)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
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
