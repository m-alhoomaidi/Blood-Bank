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
                            child: MyExpansionPanelList.radio(
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() => state.donors[index].isExpanded =
                                    !isExpanded);
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
                                            donor.bloodType,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ),
                                      ),
                                      title: DonerCardDetails(
                                        bloodTayep: donor.bloodType,
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
                          ),
                          Container(
                            color: Colors.blue,
                            child: const Center(child: Text("data")),
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
}
