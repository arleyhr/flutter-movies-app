import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  final posterId;
  final ImageProvider poster;
  final Function onPressed;

  MoviePoster({ @required this.posterId, @required this.poster, this.onPressed });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: posterId,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Material(
            elevation: 0,
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                FadeInImage(
                  image: poster,
                  placeholder: AssetImage('assets/images/placeholder.png'),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
                Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          splashColor: Colors.red,
                          onTap: onPressed
                      ),
                    )
                )
              ],
            )
        ),
      ),
    );
  }
}
