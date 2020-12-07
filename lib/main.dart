import 'package:flutter/material.dart';
import 'package:flutter_noticias_practica/src/screens/tabs_screen.dart';
import 'package:flutter_noticias_practica/src/services/news_service.dart';
import 'package:flutter_noticias_practica/src/theme/theme_custom.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new NewsService() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        title: 'Noticias',
        home: TabsScreen()
      ),
    );
  }
}
