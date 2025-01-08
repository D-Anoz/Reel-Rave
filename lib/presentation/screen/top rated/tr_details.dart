import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reelrave/core/constant/colors.dart';

import '../../../core/constant/api_services.dart';
import '../../bloc/Top Rated Detail/tr_detail_bloc.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class TRDetails extends StatefulWidget {
  const TRDetails({super.key});

  @override
  State<TRDetails> createState() => _TRDetailsState();
}

class _TRDetailsState extends State<TRDetails> {
  // @override
  // void initState() {
  //   super.initState();
  //   var id =
  //   print(id);
  // }

  @override
  Widget build(BuildContext context) {
    final movieID = ModalRoute.of(context)?.settings.arguments as int?;
    print(movieID);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
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
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card(
                      //   // elevation: 4,
                      //   child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network('${AppServices.popular_movies_500px}${data.posterPath}')),
                      // ),

                      Container(
                          height: 500,
                          width: double.infinity,
                          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('${AppServices.popular_movies_500px}${data.posterPath}', scale: 1), fit: BoxFit.fitWidth)),
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

                      //name starts from here
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.belongsToCollection.name,
                              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 25,
                              child: ListView.builder(
                                  itemCount: data.genres.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    print(data.genres[index].name);

                                    return Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: data.genres[index].name,
                                              style: const TextStyle(color: AppColors.yearColor, fontSize: 16),
                                            ),
                                            const TextSpan(
                                              text: ' .',
                                              style: TextStyle(color: AppColors.yearColor, fontSize: 24, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              data.overview,
                              style: const TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            const SizedBox(height: 24),
                            const Text('Casts and crew', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),

                            //cast and crew starts here
                            SizedBox(
                              height: 120, // Define a fixed height for the horizontal ListView
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: data.productionCompanies.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 80, // Width of each card
                                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min, // Fit content inside the column
                                      children: [
                                        Image.network(
                                          '${AppServices.popular_movies_500px}${data.productionCompanies[index].logoPath}',
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(height: 8), // Add spacing between image and text
                                        Text(
                                          data.productionCompanies[index].name,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 12), // Adjust font size
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
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
            listener: (context, state) {}),
      ),
    );
  }
}
