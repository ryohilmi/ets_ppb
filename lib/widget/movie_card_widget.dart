import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ets_ppb_ryo/model/movie.dart';

class MovieCardWidget extends StatelessWidget {
  final Movie movie;
  final int index;

  const MovieCardWidget({
    super.key,
    required this.movie,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMMMd().format(movie.createdTime);

    return Card(
      color: Colors.white54,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Flexible(
              child: Image.network(movie.image)
            ),
            const SizedBox(height: 10,),
            const SizedBox(height: 5,),
            Flexible(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                strutStyle: const StrutStyle(fontSize: 12),
                text: TextSpan(
                  text: movie.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Flexible(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                strutStyle: const StrutStyle(fontSize: 12),
                text: TextSpan(
                  text: time,
                  style: const TextStyle(
                      color: Colors.black26,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Flexible(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                strutStyle: const StrutStyle(fontSize: 12),
                maxLines: 5,
                text: TextSpan(
                  text: movie.description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
