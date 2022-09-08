import 'package:desafio_starta_flutter/shared/components/image_custom_widget.dart';
import 'package:desafio_starta_flutter/utils/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/item_movie_recommendation_model.dart';

class MoviesRecommendationWidget extends StatelessWidget {
  ItemMovieRecommendationModel itemMovie;
  Function(int) callback;

  MoviesRecommendationWidget(
      {Key? key, required this.itemMovie, required this.callback})
      : super(key: key);

  _listOfGenres() {
    String genres = '';
    itemMovie.genres.forEach((genre) => genres += ', ${genre.name}');
    return genres.replaceRange(0, 2, '  ');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => callback(itemMovie.id),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ImageCustomWidget(urlImage: itemMovie.urlImage),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 11,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itemMovie.title,
                      style: Theme.of(context).textTheme.titleMedium),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: itemMovie.year.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                      children: <TextSpan>[
                        TextSpan(
                            text: _listOfGenres(),
                            style:
                                const TextStyle(fontWeight: FontWeight.w400)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Icon(FontAwesomeIcons.solidCircleCheck,
                  color: ColorsUtil.white, size: 12),
            ),
          ],
        ),
      ),
    );
  }
}
