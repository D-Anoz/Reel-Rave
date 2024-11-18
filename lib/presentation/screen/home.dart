import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reelrave/core/constant/api_services.dart';
import 'package:reelrave/presentation/bloc/home/home_bloc.dart';
import 'package:reelrave/services/remote/home_services.dart';

import '../../core/constant/colors.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class MovieHomePage extends StatefulWidget {
  const MovieHomePage({super.key});

  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  @override
  void initState() {
    super.initState();
    HomeServices homeServices = HomeServices();
    homeServices.getTopRated();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // statusBarColor: Colors.transparent, // Make status bar transparent
      statusBarIconBrightness: Brightness.light,
    ));

    return BlocProvider(
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
              final popularData = state.popular;
              final List carousels = [
                '${AppServices.popular_movies_500px}${topRateData?[3].posterPath}',
                '${AppServices.popular_movies_500px}${topRateData?[5].posterPath}',
                '${AppServices.popular_movies_500px}${topRateData?[1].posterPath}',
                '${AppServices.popular_movies_500px}${topRateData?[2].posterPath}',
                '${AppServices.popular_movies_500px}${topRateData?[6].posterPath}',
              ];

              return Column(
                children: [
                  Container(
                      height: 500,
                      width: double.infinity,
                      decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(carousels[2], scale: 1), fit: BoxFit.fitWidth)),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Color(0xFF333333)
                            ],
                            stops: [
                              0.0,
                              0.99,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      )),
                  //column for the lists of movies
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Top rated',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/topRatedScreen');
                                  },
                                  icon: const Icon(Icons.chevron_right_rounded),
                                  color: AppColors.primaryColor,
                                  iconSize: 28,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 280,
                            width: double.infinity,
                            child: Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  final movieResult = topRateData![index];
                                  return Container(
                                    width: 150,
                                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Card(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(4),
                                            child: Image.network(
                                              '${AppServices.popular_movies_500px}${movieResult.posterPath}',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 4),
                                          child: Text(
                                            movieResult.title ?? 'Untitled title',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 4),
                                          child: Text(
                                            movieResult.releaseDate?.substring(0, 4) ?? 'Untitled date',
                                            style: const TextStyle(
                                              color: AppColors.yearColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          //popular lists
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Popular',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/popular');
                                  },
                                  icon: const Icon(Icons.chevron_right_rounded),
                                  color: AppColors.primaryColor,
                                  iconSize: 28,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 285,
                            width: 500,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      final popularResult = popularData?[index];
                                      return Container(
                                        width: 150,
                                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Card(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(4),
                                                child: Image.network(
                                                  '${AppServices.popular_movies_500px}${popularResult?.posterPath}',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4),
                                              child: Text(
                                                popularResult?.title ?? 'Untitled title',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 4),
                                              child: Text(
                                                popularResult?.releaseDate.toString().substring(0, 4) ?? 'Unknown year',
                                                style: const TextStyle(color: Color.fromARGB(255, 0, 104, 189)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is HomeLoadingErrorState) {
              return Center(child: Text('Error: ${state.errorMsg}'));
            }
            return const Center(child: Text('You shouldn\'nt be here!'));
          },
          listener: (context, state) {}),
    );
  }
}
