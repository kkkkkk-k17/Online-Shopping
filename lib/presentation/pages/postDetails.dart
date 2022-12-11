import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:three_pam/presentation/pages/posts.dart';

import '../../domain/Welcome.dart';

class PostRoute extends StatefulWidget {
  final Welcome data;

  const PostRoute({Key? key, required this.data}) : super(key: key);

  @override
  State<PostRoute> createState() => PostRouteState();
}

class PostRouteState extends State<PostRoute> {
  final storage = LocalStorage('post');

  saveToStorage() {
    storage.setItem('post', widget.data);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    saveToStorage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SecondRoute()),
                                  ),
                              child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Image.asset(
                                    'assets/images/back.png',
                                    width: 12,
                                  ))),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(widget.data.mainImage,
                                width: 360, height: 250, fit: BoxFit.cover),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: Text(
                              widget.data.name,
                              style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(9, 16, 29, 1)),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  width: 150,
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 10, 16, 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            235, 235, 235, 1)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            16) //                 <--- border radius here
                                        ),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        const Text(
                                          'Size',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 1)),
                                        ),
                                        SizedBox(
                                            width: 90,
                                            child: Text(widget.data.size,
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1))))
                                      ])),
                              Container(
                                  width: 150,
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 10, 16, 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            235, 235, 235, 1)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            16) //                 <--- border radius here
                                        ),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        const Text(
                                          'Colour',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 1)),
                                        ),
                                        SizedBox(
                                            width: 75,
                                            child: Text(widget.data.colour,
                                                textAlign: TextAlign.end,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1))))
                                      ])),
                            ],
                          ),
                          Container(
                              margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 16),
                                      child: const Text('Details',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 1)))),
                                  Text(widget.data.details),
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 16, 0, 16),
                                      child: const Text('Read more',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  0, 197, 105, 1)))),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          const Text('PRICE',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromRGBO(
                                                      146, 147, 147, 1))),
                                          Text('MD${widget.data.price}',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      0, 197, 105, 1)))
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 16, 0, 16),
                                        width: 146,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              0, 197, 105, 1),
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  0, 197, 105, 1)),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(
                                                  4) //                 <--- border radius here
                                              ),
                                        ),
                                        child: const Text('ADD',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1))),
                                      )
                                    ],
                                  )
                                ],
                              ))
                        ])))));
  }
}
