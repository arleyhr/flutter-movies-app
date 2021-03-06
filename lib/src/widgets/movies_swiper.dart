import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:kt_dart/kt.dart';
import 'package:movies_app/src/models/movie_entity.dart';


class MoviesSwiper extends StatelessWidget {
  MoviesSwiper({ @required this.moviesStream });

  Stream<KtList<MovieEntity>> moviesStream;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder(
        stream: moviesStream,
        builder: (BuildContext context, AsyncSnapshot<KtList<MovieEntity>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text('Not found'),
              );
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent)
                  )
              );
            default:
              return Swiper(
                  layout: SwiperLayout.STACK,
                  itemCount: snapshot.data.size,
                  itemWidth: size.width * 0.6,
                  itemHeight: size.height * 0.45,
                  onTap: (index) {
                    MovieEntity movie = snapshot.data.get(index);
                    Navigator.pushNamed(context, 'movieDetail', arguments: movie);
                  },
                  itemBuilder: (BuildContext context, index) {
                    MovieEntity item = snapshot.data.get(index);

                    return ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: FadeInImage(
                            placeholder: AssetImage('assets/images/placeholder.png'),
                            image: NetworkImage(item.getPosterImage()),
                            fit: BoxFit.fill
                        )
                    );

                  });

          }
        }
    );
  }
}
