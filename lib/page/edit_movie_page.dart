import 'package:flutter/material.dart';
import 'package:ets_ppb_ryo/db/movies_db.dart';
import 'package:ets_ppb_ryo/model/movie.dart';
import 'package:ets_ppb_ryo/widget/movie_form_widget.dart';

class AddEditMoviePage extends StatefulWidget {
  final Movie? movie;

  const AddEditMoviePage({
    super.key,
    this.movie
  });

  @override
  State<AddEditMoviePage> createState() => _AddEditMoviePageState();
}

class _AddEditMoviePageState extends State<AddEditMoviePage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String image;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.movie?.title ?? '';
    image = widget.movie?.image ?? '';
    description = widget.movie?.description ?? '';
  }

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty && image.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isFormValid ? null : Colors.grey.shade300,
        ),
        onPressed: addOrUpdateMovie,
        child: const Text(
          'Save',
          style: TextStyle(
              color: Colors.black54
          ),
        ),
      ),
    );
  }

  void addOrUpdateMovie() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.movie != null;

      if (isUpdating) {
        await updateMovie();
      } else {
        await addMovie();
      }

      if(mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  Future updateMovie() async {
    final movie = widget.movie!.copy(
      title: title,
      description: description,
    );

    await MoviesDatabase.instance.update(movie);
  }

  Future addMovie() async {
    final movie = Movie(
      title: title,
      image: image,
      description: description,
      createdTime: DateTime.now(),
    );

    await MoviesDatabase.instance.create(movie);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: MovieFormWidget(
        title: title,
        image: image,
        description: description,
        onChangedTitle: (title) => setState(() => this.title = title),
        onChangedImage: (image) => setState(() => this.image = image),
        onChangedDescription: (description) =>
            setState(() => this.description = description),
      ),
    ),
  );
}
