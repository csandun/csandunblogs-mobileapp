import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News {
  List<ArticleModel> news = [];

  Future getNews({String? category}) async {
    String kDailyhuntEndpoint =
        'https://dailyhunt-api.vercel.app/dailyhunt?category=$category&items=30';
    String kinshortsEndpoint =
        'https://inshorts-api.vercel.app/shorts?category=$category';

    String csandunblogsApiEndpoint =
        'https://csandunblogs.com/ghost/api/content/posts/?key=c43a16ed5e7ad7730c4f0c8b96&fields=id,excerpt,title,slug,feature_image,featured,published_at,url,reading_time&include=tags&limit=all';

    http.Client client = http.Client();
    http.Response response =
        await client.get(Uri.parse(csandunblogsApiEndpoint));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      jsonData['posts'].forEach((element) {
        if (element['feature_image'] != "" &&
            element['url'] != "" &&
            element['title'] != null) {
          ArticleModel articleModel = ArticleModel(
            publishedDate: element['published_at'].toString().split('T')[0],
            publishedTime: element['published_at'].toString(),
            image: element['feature_image'].toString(),
            content: element['excerpt'].toString(),
            fullArticle: element['url'].toString(),
            title: element['title'].toString(),
          );
          news.add(articleModel);
        }
      });
    }
  }

  Future getTags() async {

    String csandunblogsApiEndpoint =
        'https://csandunblogs.com/ghost/api/content/tags/?key=c43a16ed5e7ad7730c4f0c8b96&fields=id,name,slug,description,feature_image,accent_color,url&include=count.posts&limit=all';

    http.Client client = http.Client();
    http.Response response =
        await client.get(Uri.parse(csandunblogsApiEndpoint));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      jsonData['tags'].forEach((element) {
        if (element['name'] != "" &&
            element['url'] != "" ) {
          ArticleModel articleModel = ArticleModel(
            publishedDate: element['published_at'].toString().split('T')[0],
            publishedTime: element['published_at'].toString(),
            image: element['feature_image'].toString(),
            content: element['excerpt'].toString(),
            fullArticle: element['url'].toString(),
            title: element['title'].toString(),
          );
          news.add(articleModel);
        }
      });
    }
  }
}
