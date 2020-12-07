import 'package:flutter/material.dart';
import 'package:flutter_noticias_practica/src/screens/tab1_screen.dart';
import 'package:flutter_noticias_practica/src/screens/tab2_screen.dart';
import 'package:provider/provider.dart';
// NEWS API KEY: 24fa35b768ab4320980b82dfb4ccc49a
class TabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation()
      ),
    );
  }

}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Screen(),
        Tab2Screen()
      ],
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.currentPage,
      onTap: (value) => navigationModel.currentPage = value,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Novedades'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Encabezados'
        )
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _currentPage = 0;
  PageController _pageController = new PageController();

  int get currentPage => this._currentPage;

  set currentPage(int value) {
    this._currentPage = value;
    _pageController.animateToPage(value, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;

}