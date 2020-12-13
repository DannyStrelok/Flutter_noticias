import 'package:flutter/material.dart';
import 'package:flutter_noticias_practica/src/models/category_model.dart';
import 'package:flutter_noticias_practica/src/services/news_service.dart';
import 'package:flutter_noticias_practica/src/theme/theme_custom.dart';
import 'package:flutter_noticias_practica/src/widgets/news_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Tab2Screen extends StatefulWidget {
  @override
  _Tab2ScreenState createState() => _Tab2ScreenState();
}

class _Tab2ScreenState extends State<Tab2Screen> {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _CategoriesList(),
            if (!newsService.isLoading)
              Expanded(
                  child: NewsList(newsService.getArticlesBySelectedCategory)),
            if (newsService.isLoading)
              Expanded(
                  child: Center(
                child: CircularProgressIndicator(),
              ))
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(categories[index]),
                SizedBox(
                  height: 5,
                ),
                Text(
                    '${categories[index].name[0].toUpperCase()}${categories[index].name.substring(1)}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        alignment: Alignment.center,
        child: FaIcon(
          category.icon,
          color: (newsService.selectedCategory == this.category.name)
              ? myTheme.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
