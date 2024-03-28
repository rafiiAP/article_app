import 'package:flutter/material.dart';

import '../common/navigation.dart';
import '../common/style.dart';
import '../data/model/article.dart';
import '../ui/article_detail_page.dart';

class CardArticle extends StatelessWidget {
  final ArticleModel article;

  const CardArticle({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // article.urlToImage.isEmpty
    //     ? 'https://images.tokopedia.net/img/KRMmCm/2023/8/29/360dbc5b-92c5-4e07-919f-7338969b4447.png'
    //     : '';
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Image.network(
          article.urlToImage.isEmpty || article.urlToImage == 'null'
              ? 'https://images.tokopedia.net/img/KRMmCm/2023/8/29/360dbc5b-92c5-4e07-919f-7338969b4447.png'
              : article.urlToImage,
          width: 100,
        ),
        title: Text(
          article.title,
        ),
        subtitle: Text(article.author!),
        onTap: () => Navigation.intentWithData(
          ArticleDetailPage.routeName,
          article,
        ),
      ),
    );
  }
}
