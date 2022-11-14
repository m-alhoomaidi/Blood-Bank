import 'package:blood_bank_app/widgets/search/doner_card_details.dart';
import 'package:flutter/material.dart';

import '../../models/doner_data.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ExpansionPanelList.radio(
            expansionCallback: (int index, bool isExpanded) {
              setState(() => _donerDatas[index].isExpanded = !isExpanded);
            },
            expandedHeaderPadding: EdgeInsets.zero,
            dividerColor: Colors.black12,
            elevation: 8,
            children:
                _donerDatas.map<ExpansionPanel>((DonerCardData donerData) {
              return ExpansionPanelRadio(
                // isExpanded: product.isExpanded,
                value: donerData.id,

                canTapOnHeader: false,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 23,
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
