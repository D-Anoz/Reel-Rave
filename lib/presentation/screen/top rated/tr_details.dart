import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reelrave/core/constant/colors.dart';
import 'package:url_launcher/link.dart';

import '../../../core/constant/api_services.dart';
import '../../bloc/Top Rated Detail/tr_detail_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TRDetails extends StatefulWidget {
  const TRDetails({super.key});

  @override
  State<TRDetails> createState() => _TRDetailsState();
}

class _TRDetailsState extends State<TRDetails> {
  @override
  Widget build(BuildContext context) {
    final movieID = ModalRoute.of(context)?.settings.arguments as int?;
    print(movieID);
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      // ),
      body: BlocProvider(
        create: (content) => TrDetailBloc()..add(TRDetailsLoadedEvent(id: movieID!)),
        child: BlocConsumer<TrDetailBloc, TrDetailState>(
          builder: (context, state) {
            if (state is TrDetailInitialState) {
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
            } else if (state is TrDetailLoadingState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is TrDetailLoadedState) {
              final data = state.topRatedDetails;
              List<String> genres = [
                '${AppServices.popular_movies_500px}${data.belongsToCollection?.posterPath}',
                '${AppServices.popular_movies_500px}${data.belongsToCollection?.backdropPath}'
              ];
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: CarouselSlider(
                        options: CarouselOptions(height: 500, autoPlay: true, autoPlayInterval: const Duration(seconds: 2), autoPlayCurve: Curves.linearToEaseOut, autoPlayAnimationDuration: const Duration(milliseconds: 800), viewportFraction: 1),
                        items: genres.map((imgUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                // width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(imgUrl, scale: 1),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Color(0xFF333333),
                                      ],
                                      stops: [
                                        0.0,
                                        0.99
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),

                    //name starts from here
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Link(
                            uri: Uri.parse(data.homepage ?? 'https://www.themoviedb.org/'),
                            target: LinkTarget.defaultTarget,
                            builder: (context, openlink) {
                              return GestureDetector(
                                onTap: openlink,
                                child: Text(
                                  data.belongsToCollection?.name ?? 'Name unknown',
                                  style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 25,
                            child: ListView.builder(
                              itemCount: data.genres?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                print(data.genres?[index].name);

                                return Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: data.genres?[index].name,
                                          style: const TextStyle(color: AppColors.yearColor, fontSize: 16),
                                        ),
                                        TextSpan(
                                          text: index != data.genres!.length - 1 ? '.' : ' ',
                                          style: const TextStyle(color: AppColors.yearColor, fontSize: 24, fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            data.overview ?? 'No overview',
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 24),
                          const Text('Casts and crew', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),

                          //cast and crew starts here
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: data.productionCompanies?.length ?? 0,
                              itemBuilder: (context, index) {
                                print(data.productionCompanies?[index].logoPath);
                                final item = data.productionCompanies;

                                return Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    width: 80,
                                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        item?[index].logoPath != null ? Image.network('${AppServices.popular_movies_500px}${item?[index].logoPath}', height: 52, width: 52, fit: BoxFit.cover) : Image.asset('assets/images/logo.png', height: 52, width: 52, fit: BoxFit.cover),
                                        const SizedBox(height: 8),
                                        Text(
                                          item?[index].name ?? 'No name',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(fontSize: 12, color: Colors.black),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is TrDetailErrorState) {
              return Center(child: Text('Error: ${state.errMsg}'));
            }
            return const Center(child: Text('Something is wrong'));
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
