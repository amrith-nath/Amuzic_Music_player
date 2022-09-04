import 'package:amuzic/database/database_model.dart';
import 'package:amuzic/database/db_functions.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../fonts/fonts.dart';

class TopContainer extends StatelessWidget {
  TopContainer(this.width, this.height, this.image, {Key? key})
      : super(key: key);
  double width;
  double height;
  String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.77 * width,
      height: 0.43 * height,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(300),
              bottomRight: Radius.circular(300)),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 4,
                offset: Offset(0, 4))
          ]),
    );
  }
}
//*playScreen Container
//

class TopContainerPlay extends StatefulWidget {
  TopContainerPlay(this.width, this.height, this.image, {Key? key})
      : super(key: key);
  double width;
  double height;
  int image;

  @override
  State<TopContainerPlay> createState() => _TopContainerPlayState();
}

class _TopContainerPlayState extends State<TopContainerPlay> {
  final box = Mybox.getinstance();

  List<LocalStorageSongs> dbSongs = [];
  @override
  Widget build(BuildContext context) {
    dbSongs = Mybox.getDbSongs();

    List? favourites = box!.get("favourites");
    final temp =
        Mybox.getDbSongWithId(songs: dbSongs, songId: widget.image.toString());
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Container(
            clipBehavior: Clip.hardEdge,
            width: 0.77 * widget.width,
            height: 0.43 * widget.height,
            decoration: const BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage(image),
                //   fit: BoxFit.cover,
                // ),

                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(300),
                    bottomRight: Radius.circular(300)),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 4,
                      offset: Offset(0, 4))
                ]),
            child: QueryArtworkWidget(
              nullArtworkWidget: Image.asset(
                'assets/images/red_lady.png',
                fit: BoxFit.cover,
              ),
              artworkClipBehavior: Clip.none,
              artworkFit: BoxFit.cover,
              id: widget.image,
              type: ArtworkType.AUDIO,
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 0.05 * widget.width,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              MyFont.myClick();
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromRGBO(43, 45, 66, 1),
                boxShadow: [MyFont.myBoxShadow()],
              ),
              width: 60,
              height: 60,
              child: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 45,
                color: Colors.white,
              ),
            ),
          ),
        ),
        //!implememnt to add to fav <3//
        favourites!
                .where((element) => element.id.toString() == temp.id.toString())
                .isEmpty
            ? Positioned(
                top: 50,
                right: widget.width * 0.05,
                child: GestureDetector(
                  onTap: () async {
                    favourites.add(temp);

                    await box!.put("favourites", favourites);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromRGBO(43, 45, 66, 1),
                      boxShadow: [MyFont.myBoxShadow()],
                    ),
                    width: 60,
                    height: 60,
                    child: const Icon(
                      Icons.favorite_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : Positioned(
                top: 50,
                right: widget.width * 0.05,
                child: GestureDetector(
                  onTap: () async {
                    favourites.removeWhere((element) =>
                        element.id.toString() == temp.id.toString());
                    // favourites.remove(temp);

                    await box!.put("favourites", favourites);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromRGBO(43, 45, 66, 1),
                      boxShadow: [MyFont.myBoxShadow()],
                    ),
                    width: 60,
                    height: 60,
                    child: const Icon(
                      Icons.favorite_rounded,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
