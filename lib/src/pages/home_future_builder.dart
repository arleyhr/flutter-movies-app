import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:kt_dart/collection.dart';
import 'package:movies_app/src/models/movie_entity.dart';
import 'package:movies_app/src/moviesdb_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildSwiper() {
    return FutureBuilder(
        future: moviesDBAPI.getNowPlaying(),
        builder: (BuildContext context, AsyncSnapshot<KtList<MovieEntity>> snapshot) {

          switch (snapshot.connectionState) {
            case ConnectionState.none:
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
                  itemWidth: 300.0,
                  itemHeight: 500.0,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      body: Container(
        color: Colors.black54,
        width: double.infinity,
        child: _buildSwiper(),
      ),
    );
  }
}
