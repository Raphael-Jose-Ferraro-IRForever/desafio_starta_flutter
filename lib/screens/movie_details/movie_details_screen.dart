import 'dart:math';
import 'package:desafio_starta_flutter/screens/movie_details/movie_details_controller.dart';
import 'package:desafio_starta_flutter/screens/movie_details/movies_recommendation_widget.dart';
import 'package:desafio_starta_flutter/shared/components/image_custom_widget.dart';
import 'package:desafio_starta_flutter/shared/components/loading_widget.dart';
import 'package:desafio_starta_flutter/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import '../../shared/components/back_button_widget.dart';
import '../../utils/colors_util.dart';

class MovieDetailsScreen extends StatefulWidget {
  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final _controller = MovieDetailsController();
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _controller.obtainGenres(() {
      _controller.obtainMovie(idMovie: Random().nextInt(10000));
    });
  }

  _buildWithLoading() {
    if (_controller.isLoading || _controller.movieDetails == null) {
      return const LoadingWidget();
    }
    return _buildBody();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: BackButtonWidget(),
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        body: Observer(builder: (_) {
          return _buildWithLoading();
        }));
  }

  _buildBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageMovieWidget(),
          _headerTitle(),
          const SizedBox(height: 16),
          _listRecommendation()
        ],
      ),
    );
  }

  _imageMovieWidget() {
    var height = MediaQuery.of(context).size.height;
    return Stack(children: [
      SizedBox(
          height: height * .5,
          width: MediaQuery.of(context).size.width,
          child:
              ImageCustomWidget(urlImage: _controller.movieDetails!.urlImagem)),
      Container(
        height: height * .05,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black54, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
      ),
      Padding(
        padding: EdgeInsets.only(top: height * .1),
        child: Container(
          height: height * .4,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment(0, .3))),
        ),
      )
    ]);
  }

  _headerTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 5,
                child: Text(_controller.movieDetails!.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis)),
            Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                  child: Container(
                    width: 50,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(top: 4),
                    child: LikeButton(
                      circleColor: const CircleColor(
                          start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Color(0xff33b5e5),
                        dotSecondaryColor: Color(0xff0099cc),
                      ),
                      mainAxisAlignment: MainAxisAlignment.end,
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          size: 24,
                          color: isLiked ? ColorsUtil.red : ColorsUtil.white,
                        );
                      },
                    ),
                  ),
                ))
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Icon(
              Icons.favorite,
              size: 16,
              color: ColorsUtil.white,
            ),
            Text(
              ' ${_controller.movieDetails!.votes.formattedNumber()} Likes',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              width: 28,
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Icon(
                FontAwesomeIcons.circleHalfStroke,
                size: 16,
                color: ColorsUtil.white,
              ),
            ),
            Text(
              ' ${_controller.movieDetails!.views} views',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        )
      ]),
    );
  }

  _listRecommendation() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _controller.movieDetails!.moviesRecommendations.length,
            itemBuilder: (_, index) {
              var movie =
                  _controller.movieDetails!.moviesRecommendations[index];
              return MoviesRecommendationWidget(
                  itemMovie: movie,
                  callback: (id) {
                    _controller.obtainMovie(idMovie: id);
                  });
            }),
      ),
    );
  }
}
