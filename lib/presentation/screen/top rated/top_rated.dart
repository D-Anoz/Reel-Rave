import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reelrave/core/constant/colors.dart';
import 'package:reelrave/presentation/bloc/home/home_bloc.dart';

import '../../../core/constant/api_services.dart';

class TopRated extends StatefulWidget {
  const TopRated({super.key});

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  //strings
  final Map<int, bool> savedStatus = {};

  //methods
  void toggleIsSaved(int movieId, String movieName) {
    setState(() {
      final isSaved = savedStatus[movieId] ?? false;
      savedStatus[movieId] = !isSaved;
      displaySnackbar(context, movieName, !isSaved);
    });
  }

  List<int> getSavedMovies() {
    return savedStatus.entries.where((entry) => entry.value == true).map((entry) => entry.key).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          'Top rated',
          style: TextStyle(color: AppColors.primaryColor),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
      ),
      body: BlocProvider(
        create: (content) => HomeBloc()..add(HomeLoadedEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeInitialState) {
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
                      Text(
                        'Loading data',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                );
              } else if (state is HomeLoadingState) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is HomeLoadedState) {
                final topRateData = state.topRated;
                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.55,
                    crossAxisSpacing: 12,
                    // mainAxisSpacing: 10,
                  ),
                  itemCount: topRateData!.length,
                  itemBuilder: (context, index) {
                    final movieResult = topRateData[index];
                    final isSaved = savedStatus[movieResult.id] ?? false;
                    return GestureDetector(
                      onTap: () {
                        debugPrint('single tap');
                      },
                      onDoubleTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            // elevation: 4,
                            child: Stack(children: [
                              Column(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network('${AppServices.popular_movies_500px}${movieResult!.posterPath}')),
                                ],
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: isSaved
                                    ? const Icon(
                                        Icons.bookmark,
                                        color: AppColors.primaryColor,
                                        size: 28,
                                      )
                                    : const SizedBox.shrink(),
                              )
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              movieResult.title ?? 'Untitled title',
                              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              movieResult.releaseDate?.substring(0, 4) ?? 'Untitled date',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 104, 189),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              } else if (state is HomeLoadingErrorState) {
                return Center(child: Text('Error: ${state.errorMsg}'));
              }
              return const Center(child: Text('Something is wrong'));
            },
            listener: (context, state) {}),
      ),
    );
  }

  void displaySnackbar(BuildContext context, String movieName, bool isAdded) {
    final message = isAdded ? '$movieName has been saved in the list' : '$movieName has been removed from the list';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.primaryColor,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
