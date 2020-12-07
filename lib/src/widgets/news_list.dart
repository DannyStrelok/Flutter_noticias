import 'package:flutter/material.dart';
import 'package:flutter_noticias_practica/src/models/news_model.dart';
import 'package:flutter_noticias_practica/src/theme/theme_custom.dart';

class NewsList extends StatelessWidget {

  final List<Article> news;


  NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int index) {
        return _New(article: news[index], index: index, );
      },
    );
  }
}

class _New extends StatelessWidget {

  final Article article;
  final int index;

  _New({@required this.article, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopBarCard(article, index),
        _CardTitle(article),
        _CardImage(article),
        _CardBody(article),
        _CardButtons(),

        SizedBox(height: 10,),
        Divider()
      ],
    );
  }
}

class _CardButtons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: (){},
            fillColor: myTheme.accentColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
          ),
          SizedBox(width: 25,),
          RawMaterialButton(
            onPressed: (){},
            fillColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more),
          )
        ],
      ),
    );
  }
}

class _CardBody extends StatelessWidget{

  final Article article;

  _CardBody(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(article.description != null ? article.description : ''),
    );
  }

}

class _CardImage extends StatelessWidget {

  final Article article;

  _CardImage(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: (article.urlToImage != null)
              ? FadeInImage(
            placeholder: AssetImage('assets/img/giphy.gif'),
            image: NetworkImage(article.urlToImage),
          )
              : Image(image: AssetImage('assets/img/no-image.png'),)
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {

  final Article article;

  _CardTitle(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(article.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
    );
  }

}

class _TopBarCard extends StatelessWidget {

  final Article article;
  final int index;

  _TopBarCard(this.article, this.index);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Text('${index + 1}. ', style: TextStyle(color: myTheme.accentColor),),
          Text('${article.source.name}')
        ],
      ),
    );
  }
}


