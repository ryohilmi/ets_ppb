import 'package:flutter/material.dart';

class MovieFormWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final String? image;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedImage;

  const MovieFormWidget({
    super.key,
    this.title = '',
    this.description = '',
    this.image = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedImage,
  });

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    style: const TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.bold,
        fontSize: 24
    ),
    decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
        hintStyle: TextStyle(
            color: Colors.white70
        )
    ),
    validator: (title) =>
    title != null &&
        title.isEmpty ? 'The title cannot be empty' : null,
    onChanged: onChangedTitle,
  );

  Widget buildImage() => TextFormField(
    maxLines: 2,
    initialValue: image,
    style: const TextStyle(
        color: Colors.white70,
        fontSize: 18
    ),
    decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Cover Image Link',
        hintStyle: TextStyle(
            color: Colors.white70
        )
    ),
    validator: (image) =>
    image != null &&
        image.isEmpty ? 'The image cannot be empty' : null,
    onChanged: onChangedImage,
  );

  Widget buildDescription() => TextFormField(
    initialValue: description,
    maxLines: 20,
    style: const TextStyle(
        color: Colors.white60,
        fontSize: 18
    ),
    decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Description',
        hintStyle: TextStyle(
            color: Colors.white60
        )
    ),
    validator: (title) =>
    title != null &&
        title.isEmpty ? 'The description cannot be empty' : null,
    onChanged: onChangedDescription,
  );

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget> [
          buildTitle(),
          const SizedBox(height: 8),
          Divider(),
          buildImage(),
          const SizedBox(height: 8),
          Divider(),
          buildDescription(),
          const SizedBox(height: 16)
        ],
      ),
    ),
  );
}
