import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ets_ppb_ryo/db/movies_db.dart';
import 'package:ets_ppb_ryo/model/movie.dart';
import 'package:ets_ppb_ryo/page/edit_movie_page.dart';
import 'package:ets_ppb_ryo/page/movie_detail_page.dart';
import 'package:ets_ppb_ryo/widget/movie_card_widget.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  late List<Movie> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshMovies();
  }

  @override
  void dispose() {
    MoviesDatabase.instance.close();

    super.dispose();
  }

  Future refreshMovies() async {
    setState(() => isLoading = true);

    notes = await MoviesDatabase.instance.readAllMovies();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Moo-v',
            style: TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          actions: const [
            // Icon(
            //   Icons.search,
            //   color: Colors.white,
            //   size: 32,
            // ),
            SizedBox(width: 12)
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: isLoading
              ? const CircularProgressIndicator()
              : (notes.isEmpty
                  ? const Center(
                      child: Text(
                        'No Movie 🧑‍🦯',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    )
                  : buildMovies()),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditMoviePage()),
            );

            refreshMovies();
          },
        ),
      );

  Widget buildMoviesz() => StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(
        notes.length,
        (index) {
          final movie = notes[index];

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MovieDetailPage(noteId: movie.id!),
                ));

                refreshMovies();
              },
              child: MovieCardWidget(movie: movie, index: index),
            ),
          );
        },
      ));

  Widget buildMovies() => ListView(
        children: List.generate(
          notes.length,
          (index) {
            final movie = notes[index];

            return StaggeredGridTile.fit(
              crossAxisCellCount: 1,
              child: GestureDetector(
                onTap: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MovieDetailPage(noteId: movie.id!),
                  ));

                  refreshMovies();
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  child: MovieCardWidget(movie: movie, index: index),
                ),
              ),
            );
          },
        ),
      );
}
