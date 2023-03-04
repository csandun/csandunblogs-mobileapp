import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/article_screen.dart';
import 'package:news_app/screens/image_screen.dart';
import 'package:transition/transition.dart';

class NewsTile extends StatelessWidget {
  final String image, title, content, date, fullArticle;

  NewsTile({
    required this.content,
    required this.date,
    required this.image,
    required this.title,
    required this.fullArticle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6))),
      margin: EdgeInsets.only(bottom: 24),
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(6),
            bottomLeft: Radius.circular(6),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Hero(
                  tag: 'image-$image',
                  child: CachedNetworkImage(
                    height: 275,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    imageUrl: image,
                    placeholder: (context, url) => Image(
                      image: AssetImage('images/dotted-placeholder.jpg'),
                      height: 275,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageScreen(
                      imageUrl: image,
                      headline: title,
                    ),
                  ),
                );
              },
            ),
            GestureDetector(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Chip(
                    //     label: Text(
                    //   'GeeksforGeeks',
                    //   style: TextStyle(fontSize: 12),
                    // )),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      content,
                      maxLines: 2,
                      style:
                          TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(date,
                        style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w500))
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  Transition(
                    child: ArticleScreen(articleUrl: fullArticle),
                    transitionEffect: TransitionEffect.BOTTOM_TO_TOP,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
