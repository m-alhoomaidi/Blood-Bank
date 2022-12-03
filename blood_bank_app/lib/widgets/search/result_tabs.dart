import '../../cubit/search_cubit/search_cubit.dart';
import '../../models/blood_types.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultTabs extends StatefulWidget {
  const ResultTabs({Key? key}) : super(key: key);

  @override
  State<ResultTabs> createState() => _ResultTabsState();
}

class _ResultTabsState extends State<ResultTabs> {
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
              itemCount: BloodTypes.bloodTypes.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<SearchCubit>(context)
                            .setSelectedBloodType(index: index);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.all(5),
                        width: 70,
                        height: 45,
                        decoration: BoxDecoration(
                          color: state.selectedBloodTypeIndex == index
                              ? Colors.white
                              : Colors.white70,
                          borderRadius: state.selectedBloodTypeIndex == index
                              ? BorderRadius.circular(10)
                              : BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              BloodTypes.bloodTypes[index],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight:
                                    state.selectedBloodTypeIndex == index
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                              ),
                            ),
                            // ignore: prefer_const_constructors
                            Text(
                              '5',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: state.selectedBloodTypeIndex == index,
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