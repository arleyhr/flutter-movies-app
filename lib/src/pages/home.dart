import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:kt_dart/collection.dart';
import 'package:movies_app/src/models/movie_entity.dart';
import 'package:movies_app/src/moviesdb_api.dart';
import 'package:movies_app/src/widgets/buttons_group.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController<KtList<MovieEntity>> _swiperDataController;

  final Map<int, Widget> segmentedOptions = const <int, Widget>{
    0: Text('Now Playing'),
    1: Text('Top Rated'),
    2: Text('Upcoming')
  };

  @override
  void initState() {
    super.initState();
    _swiperDataController = new StreamController<KtList<MovieEntity>>();
    _getPlayingMovies();
  }

  _getPlayingMovies() async {
    KtList<MovieEntity> result = await moviesDBAPI.getNowPlaying();
    _swiperDataController .add(result);
  }

  Widget _buildSwiper() {
    return StreamBuilder(
        stream: _swiperDataController.stream,
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

  Widget _buildSegmentedControl () {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 20.0),
      width: 350.0,
      child: ButtonsGroup(
              children: [
                ButtonGroup(
                    onPressed: (){},
                    child: Text('Now Playing')
                ),
                ButtonGroup(
                    onPressed: (){},
                    child: Text('Top Rated')
                ),
                ButtonGroup(
                    onPressed: (){},
                    child: Text('Upcoming')
                ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30.0),
        color: Colors.black54,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildSegmentedControl(),
            _buildSwiper()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _swiperDataController.close();
    super.dispose();
  }
}
