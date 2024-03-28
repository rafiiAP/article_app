import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/navigation.dart';
import '../data/model/article.dart';
import 'article_web_view.dart';

class ArticleDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final ArticleModel article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              article.urlToImage.isEmpty || article.urlToImage == 'null'
                  ? 'https://images.tokopedia.net/img/KRMmCm/2023/8/29/360dbc5b-92c5-4e07-919f-7338969b4447.png'
                  : article.urlToImage,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.description.isEmpty || article.description == 'null'
                        ? ''
                        : article.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    article.title.isEmpty || article.title == 'null'
                        ? ''
                        : article.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    'Date: ${article.publishedAt}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Author: ${article.author.isEmpty || article.author == "null" ? "" : article.author}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const Divider(color: Colors.grey),
                  Text(
                    article.content ?? "-",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    child: const Text('Read more'),
                    onPressed: () {
                      Navigation.intentWithData(
                        ArticleWebView.routeName,
                        article.url,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
