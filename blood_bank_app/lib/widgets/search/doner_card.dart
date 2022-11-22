import 'package:blood_bank_app/style.dart';

import '../../widgets/search/doner_card_details.dart';
import '../../widgets/search/my_expansion_panel.dart';
import '../../models/doner_data.dart';
import 'package:flutter/material.dart';
import 'doner_card_body.dart';

class DonerCard extends StatefulWidget {
  const DonerCard({Key? key}) : super(key: key);

  @override
  State<DonerCard> createState() => _DonerCardState();
}

class _DonerCardState extends State<DonerCard> {
  final List<DonerCardData> _donerDatas = DonerCardData.generateItems(8);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          // decoration: const BoxDecoration(
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(30),
          //   ),
          // ),
          padding: const EdgeInsets.all(12),
          child: MyExpansionPanelList.radio(
            expansionCallback: (int index, bool isExpanded) {
              setState(() => _donerDatas[index].isExpanded = !isExpanded);
            },
            expandedHeaderPadding: EdgeInsets.zero,
            elevation: 0,
            dividerColor: Colors.white,
            children:
                _donerDatas.map<ExpansionPanel>((DonerCardData donerData) {
              return ExpansionPanelRadio(
                value: donerData.id,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      child: Text(donerData.id.toString()),
                    ),
                    title: DonerCardDetails(
                        bloodTayep: donerData.id.toString(),
                        donerName: "طيب علي محمد العامري",
                        donerCity: "الريس",
                        donerPhone: "77 77 77"),
                  );
                },
                body: const DonerCardBody(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
