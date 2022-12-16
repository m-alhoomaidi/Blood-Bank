import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/search_cubit/search_cubit.dart';
import '../../models/donor.dart';
import '../../widgets/search/doner_card_details.dart';
import '../../widgets/search/my_expansion_panel.dart';
import 'doner_card_body.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is SearchSuccess) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: MyExpansionPanelList.radio(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(
                        () => state.donors[index].isExpanded = !isExpanded);
                  },
                  expandedHeaderPadding: EdgeInsets.zero,
                  elevation: 0,
                  dividerColor: Colors.white,
                  children: state.donors.map<ExpansionPanel>((Donor donor) {
                    return ExpansionPanelRadio(
                      value: donor.bloodType,
                      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CircleAvatar(
                              radius: 25,
                              child: Text(donor.bloodType),
                            ),
                          ),
                          title: DonerCardDetails(
                              bloodTayep: donor.bloodType,
                              donerName: donor.name,
                              donerCity: donor.neighborhood,
                              donerPhone: donor.phone),
                        );
                      },
                      body: const DonerCardBody(),
                    );
                  }).toList(),
                ),
              );
            } else if (state is SearchInitial) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child:
                      Text('حدد المحافظة والمديرية وزمرة الدم التي تبحث عنها'),
                ),
              );
            } else {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: Text('حدث خطأ'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
