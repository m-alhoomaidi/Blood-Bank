import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/blood_types.dart';
import '../../../domain/entities/donor.dart';
import '../../cubit/search_cubit/search_cubit.dart';

class ResultTabs extends StatelessWidget {
  const ResultTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchSuccess) {
          return Container(
            width: double.infinity,
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: BloodTypes.canReceiveFrom(
                      bloodType: BlocProvider.of<SearchCubit>(context)
                          .selectedBloodType!)
                  .length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                List<String> compatibleBloodTypes = BloodTypes.canReceiveFrom(
                    bloodType: BlocProvider.of<SearchCubit>(context)
                        .selectedBloodType!);
                List<Donor> compatibleDonors = state.donors
                    .where((donor) =>
                        donor.bloodType == compatibleBloodTypes[index])
                    .toList();
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<SearchCubit>(context)
                            .setSelectedTabBloodType(tabIndex: index);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.all(5),
                        width: state.selectedTabIndex == index ? 75 : 65,
                        height: 45,
                        decoration: BoxDecoration(
                          color: state.selectedTabIndex == index
                              ? Colors.white
                              : Colors.white70,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              compatibleBloodTypes[index],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: state.selectedTabIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              ),
                            ),
                            Text(
                              compatibleDonors.length.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state.selectedTabIndex == index,
                      child: Container(
                        width: 60,
                        height: 3,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text('ستظهر هنا فصائل الدم المناسبة'),
            ),
          );
        }
      },
    );
  }
}
