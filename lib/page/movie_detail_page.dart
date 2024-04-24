import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ets_ppb_ryo/db/movies_db.dart';
import 'package:ets_ppb_ryo/model/movie.dart';
import 'package:ets_ppb_ryo/page/edit_movie_page.dart';

class MovieDetailPage extends StatefulWidget {
  final int noteId;

  const MovieDetailPage({
    super.key,
    required this.noteId,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late Movie movie;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshMovie();
  }

  Future refreshMovie() async {
    setState(() => isLoading = true);

    movie = await MoviesDatabase.instance.readMovie(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [editButton(), deleteButton()],
    ),
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
        children: [
          Flexible(
              child: Image.network(movie.image)
          ),
          Text(
            movie.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,

            ),
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat.yMMMd().format(movie.createdTime),
            style: const TextStyle(color: Colors.white38, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            movie.description,
            textAlign: TextAlign.justify,
            style:
            const TextStyle(color: Colors.white70, fontSize: 18),
          )
        ],
      ),
    ),
  );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined, color: Colors.white,),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditMoviePage(movie: movie),
        ));

        refreshMovie();
      });

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete, color: Colors.white,),
    onPressed: () async {
      await MoviesDatabase.instance.delete(widget.noteId);

      if(mounted) {
        Navigator.of(context).pop();
      }
    },
  );
}