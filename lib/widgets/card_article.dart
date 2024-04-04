import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/navigation.dart';
import '../data/model/article.dart';
import '../provider/database_provider.dart';
import '../ui/article_detail_page.dart';

class CardArticle extends StatelessWidget {
  final Article article;

  const CardArticle({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(article.url),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Hero(
                  tag: article.urlToImage!.isEmpty ||
                          article.urlToImage == 'null'
                      ? 'https://images.tokopedia.net/img/KRMmCm/2023/8/29/360dbc5b-92c5-4e07-919f-7338969b4447.png'
                      : article.urlToImage!,
                  child: Image.network(
                    article.urlToImage!.isEmpty || article.urlToImage == 'null'
                        ? 'https://images.tokopedia.net/img/KRMmCm/2023/8/29/360dbc5b-92c5-4e07-919f-7338969b4447.png'
                        : article.urlToImage!,
                    width: 100,
                  ),
                ),
                title: Text(
                  article.title,
                ),
                subtitle: Text(article.author ?? ""),
                trailing: isBookmarked
                    ? IconButton(
                        icon: const Icon(Icons.bookmark),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.removeBookmark(article.url),
                      )
                    : IconButton(
                        icon: const Icon(Icons.bookmark_border),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.addBookmark(article),
                      ),
                onTap: () => Navigation.intentWithData(
                    ArticleDetailPage.routeName, article),
              ),
            );
          },
        );
      },
    );
  }
}
