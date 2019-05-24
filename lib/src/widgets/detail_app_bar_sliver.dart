import 'package:flutter/material.dart';

class DetailAppBarSliver extends StatelessWidget {
  DetailAppBarSliver({ @required this.title, @required this.backdrop });

  final String title;
  final ImageProvider backdrop;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.black,
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(title, style: TextStyle(
              color: Colors.white,
              fontSize: 16.0
          )),
          background: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: FadeInImage(
                      image: backdrop,
                      placeholder: AssetImage('assets/images/placeholder.png'),
                      fadeInDuration: Duration(microseconds: 150),
                      fit: BoxFit.cover
                  )
              )

          )
      ),
    );
  }
}
