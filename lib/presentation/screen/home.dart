import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reelrave/core/constant/api_services.dart';
import 'package:reelrave/presentation/bloc/home/home_bloc.dart';
import 'package:reelrave/services/remote/home_services.dart';
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
    return SafeArea(
      child: BlocProvider(
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

                return Column(
                  children: [
                    Container(
                        height: 380,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage('${AppServices.popular_movies_500px}${topRateData![0].posterPath}', scale: 1
                                    // fit: BoxFit.fitWidth,
                                    ),
                                fit: BoxFit.fitWidth)),
                        child: Container(
                          decoration: const BoxDecoration(
                              gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                            Colors.transparent,
                            Color(0xff323232)
                          ])),
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
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/topRatedScreen');
                                      },
                                      child: const Text('View all', style: TextStyle(color: Colors.blue)))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 280,
                              width: double.infinity,
                              child: Expanded(
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                                  itemCount: 5, // Adjust item count to reflect actual data length
                                  itemBuilder: (context, index) {
                                    final movieResult = topRateData[index];
                                    return Container(
                                      width: 150, // Set a fixed width to simulate grid-like layout
                                      margin: const EdgeInsets.symmetric(horizontal: 8.0), // Add horizontal spacing
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Card(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(4),
                                              child: Image.network(
                                                '${AppServices.popular_movies_500px}${movieResult.posterPath}',
                                                fit: BoxFit.cover, // Optional: Adjust image scaling
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
                                                color: Color.fromARGB(255, 0, 104, 189),
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
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/popular');
                                      },
                                      child: const Text('View all', style: TextStyle(color: Colors.blue)))
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
                                      scrollDirection: Axis.horizontal, // Set horizontal scrolling
                                      itemCount: 5, // Update this to reflect the actual item count
                                      itemBuilder: (context, index) {
                                        final popularResult = popularData?[index];
                                        return Container(
                                          width: 150, // Set a fixed width for each item to mimic a grid-like layout
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
              return const Center(child: Text('Something is wrong'));
            },
            listener: (context, state) {}),
      ),
    );
  }
}
