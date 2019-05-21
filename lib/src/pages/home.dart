import 'package:flutter/material.dart';
import 'package:movies_app/src/moviesdb_api.dart';
import 'package:movies_app/src/providers/movie_provider.dart';
import 'package:movies_app/src/widgets/buttons_group.dart';
import 'package:movies_app/src/widgets/movies_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  moviesDBAPIEndpoints buttonSelected = moviesDBAPIEndpoints.NOW_PLAYING;

  @override
  void initState() {
    super.initState();

    _getSwiperMovies(buttonSelected);
  }

  void _getSwiperMovies(moviesDBAPIEndpoints movieEndpoint) async {
    movieProvider.getFeaturedMovies(buttonSelected);
  }

  void _handleSwiperButtonPressed(moviesDBAPIEndpoints movieEndpoint) {
    if (movieEndpoint != buttonSelected) {
      _getSwiperMovies(movieEndpoint);

      setState(() {
        buttonSelected = movieEndpoint;
      });
    }
  }

  Widget _buildButtonsGroup () {
    List<Map<String, dynamic>> buttons = [
      {
        'text': 'Now playing',
        'type': moviesDBAPIEndpoints.NOW_PLAYING
      },
      {
        'text': 'Top Rated',
        'type': moviesDBAPIEndpoints.TOP_RATED
      },
      {
        'text': 'Upcoming',
        'type': moviesDBAPIEndpoints.UPCOMING
      },
    ];

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 20.0),
      width: 350.0,
      child: ButtonsGroup(
        children: buttons.map((item) => ButtonGroup(
            onPressed: (){
              _handleSwiperButtonPressed(item['type']);
            },
            child: Text(item['text']),
            isActived: buttonSelected == item['type'],
          )
        ).toList(),
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
            _buildButtonsGroup(),
            MoviesSwiper(stream: movieProvider.featuredMoviesStream)
          ],
        ),
      ),
    );
  }
}
