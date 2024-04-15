import 'package:flutter/material.dart';
import 'package:noticias/src/pages/pages.dart';
 
import 'package:provider/provider.dart';

class TabPage extends StatelessWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _NavigationProvider(),
      child: const Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationProvider =
        Provider.of<_NavigationProvider>(context);

    return BottomNavigationBar(
      currentIndex: navigationProvider.paginaActual,
      onTap: (int index) {
        navigationProvider.paginaActual = index;
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Noticias'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Categorías'),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<_NavigationProvider>(context);

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: navigationProvider.pageController,
      children: const [
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _NavigationProvider extends ChangeNotifier {
  int _paginaActual = 0;
  int get paginaActual => _paginaActual;
  final PageController _pageController = PageController();
  get pageController => _pageController;
  set paginaActual(int index) {
    _paginaActual = index;
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    notifyListeners();
  }
}
