import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reelrave/presentation/bloc/TV/tv_bloc.dart';

import '../../../core/constant/api_services.dart';
import '../../../core/constant/colors.dart';

class TVScreen extends StatefulWidget {
  const TVScreen({super.key});

  @override
  State<TVScreen> createState() => _TVScreenState();
}

class _TVScreenState extends State<TVScreen> {
  //strings
  final List<int> savedStatus = [];

  //methods
  void showAddedMessage(String listName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$listName is added to your saved list. '),
        backgroundColor: AppColors.primaryColor,
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
      ),
    );
  }

  void showRemoveMessage(String listName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$listName is removed from your saved list. '),
        backgroundColor: AppColors.accentColor,
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
      ),
    );
  }

  void toggleIsSaved(int tvID, String listName) {
    setState(() {
      debugPrint('You have called the function.');
      if (savedStatus.contains(tvID)) {
        savedStatus.remove(tvID);
        showRemoveMessage(listName);
      } else {
        savedStatus.add(tvID);
        showAddedMessage(listName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.bgColor,
        title: const Text('TV list', style: TextStyle(color: AppColors.primaryColor)),
      ),
      body: BlocProvider(
        create: (content) => TVBloc()..add(TVLoadedEvent()),
        child: BlocConsumer<TVBloc, TVState>(
            builder: (context, state) {
              if (state is TVInitialState) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text('Loading data', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                );
              } else if (state is TVLoadingState) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is TVLoadedState) {
                final tvlist = state.tvLists;

                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.55,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: tvlist.length,
                  itemBuilder: (context, index) {
                    final lists = tvlist[index];
                    final String year = lists.firstAirDate.year.toString(); //filtering the date only from the DateTime
                    final String ratings = lists.voteAverage.toString();

                    return GestureDetector(
                      onTap: () {
                        debugPrint('single tap');
                      },
                      onDoubleTap: () => toggleIsSaved(lists.id, lists.name),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            // elevation: 4,
                            child: Column(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network('${AppServices.popular_movies_500px}${lists.posterPath}')),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(lists.name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  year,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 104, 189)),
                                ),
                                Row(
                                  children: [
                                    lists.voteAverage <= 5
                                        ? Icon(
                                            Icons.star_half_rounded,
                                            color: Colors.yellow.shade100,
                                            size: 28,
                                          )
                                        : const Icon(
                                            Icons.star_rate_rounded,
                                            color: Colors.yellow,
                                            size: 28,
                                          ),
                                    const SizedBox(width: 4),
                                    Text(ratings, style: const TextStyle(color: Colors.white, fontSize: 16))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              } else if (state is TVErrorState) {
                return Center(
                  child: Text('Error occured: ${state.errMsg}'),
                );
              }
              return const Center(child: Text('You shouldn\'nt be here!'));
            },
            listener: (context, state) {}),
      ),
    );
  }
}
