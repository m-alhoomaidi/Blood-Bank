import 'package:blood_bank_app/domain/entities/blood_center.dart';
import 'package:blood_bank_app/presentation/widgets/search/result_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/blood_types.dart';
import '../../../domain/entities/donor.dart';
import '../../cubit/search_cubit/search_cubit.dart';
import '../../widgets/search/doner_card_details.dart';
import '../../widgets/search/my_expansion_panel.dart';
import 'doner_card_body.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(
      vsync: this,
      length: 2,
    );
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
              List<String> compatibleBloodTypes = BloodTypes.canReceiveFrom(
                  bloodType:
                      BlocProvider.of<SearchCubit>(context).selectedBloodType!);
              List<Donor> compatibleDonors = state.donors
                  .where((donor) =>
                      donor.bloodType ==
                      compatibleBloodTypes[state.selectedTabIndex])
                  .toList();
              print("fetched centers length");
              print(state.centers.length);

              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: TabBar(
                        controller: tabController,
                        indicator: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        labelStyle: Theme.of(context).textTheme.titleLarge,
                        unselectedLabelColor: Colors.black54,
                        tabs: const [
                          Tab(text: "متبرعين"),
                          Tab(text: "مراكز طبية"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(textScaleFactor: 1.0),
                                    child: const ResultTabs()),
                                MyExpansionPanelList.radio(
                                  expansionCallback:
                                      (int index, bool isExpanded) {
                                    setState(() => state.donors[index]
                                        .isExpanded = !isExpanded);
                                  },
                                  expandedHeaderPadding: EdgeInsets.zero,
                                  elevation: 0,
                                  dividerColor: Colors.white,
                                  children: compatibleDonors
                                      .map<ExpansionPanel>((Donor donor) {
                                    return ExpansionPanelRadio(
                                      value: donor.phone,
                                      backgroundColor:
                                          const Color.fromARGB(0, 0, 0, 0),
                                      canTapOnHeader: true,
                                      headerBuilder: (BuildContext context,
                                          bool isExpanded) {
                                        return ListTile(
                                          leading: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: CircleAvatar(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              radius: 25,
                                              child: Text(
                                                donor.bloodType,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                            ),
                                          ),
                                          title: DonerCardDetails(
                                            donerName: donor.name,
                                            donerCity: donor.neighborhood,
                                            donerPhone: donor.phone,
                                          ),
                                        );
                                      },
                                      body: const DonerCardBody(),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: MyExpansionPanelList.radio(
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() => state.donors[index].isExpanded =
                                    !isExpanded);
                              },
                              expandedHeaderPadding: EdgeInsets.zero,
                              elevation: 0,
                              dividerColor: Colors.white,
                              children: state.centers
                                  .map<ExpansionPanel>((BloodCenter center) {
                                return ExpansionPanelRadio(
                                  value: center.phone,
                                  backgroundColor:
                                      const Color.fromARGB(0, 0, 0, 0),
                                  canTapOnHeader: true,
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return ListTile(
                                      leading: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          radius: 25,
                                          child: Text(
                                            getBloodAmount(
                                              center: center,
                                              bloodType: compatibleBloodTypes[
                                                  state.selectedTabIndex],
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ),
                                      ),
                                      title: DonerCardDetails(
                                        donerName: center.name,
                                        donerCity: center.neighborhood,
                                        donerPhone: center.phone,
                                      ),
                                    );
                                  },
                                  body: const DonerCardBody(),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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

  String getBloodAmount({
    required BloodCenter center,
    required String bloodType,
  }) {
    switch (bloodType) {
      case "A+":
        return center.aPlus.toString();
      case "A-":
        return center.aMinus.toString();
      case "B+":
        return center.bPlus.toString();
      case "B-":
        return center.bMinus.toString();
      case "O+":
        return center.oPlus.toString();
      case "O-":
        return center.oMinus.toString();
      case "AB+":
        return center.abPlus.toString();
      case "AB-":
        return center.abMinus.toString();
      default:
        return center.oMinus.toString();
    }
  }
}
