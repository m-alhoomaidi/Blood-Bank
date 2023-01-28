import 'package:flutter/material.dart';

import '../resources/style.dart';
import '../widgets/search/search_options.dart';
import '../widgets/search/search_result.dart';
import 'search_map.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const String routeName = 'search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('البحث عن دم'),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: eBackGroundColor,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SearchOptions(),
              ),
            ),
            const Expanded(
              child: SearchResult(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.search_rounded),
          onPressed: () async {
            Navigator.pushNamed(context, SearchMapPage.routeName);
          },
        ));
  }
}