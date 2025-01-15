import 'package:flutter/material.dart';
import 'package:noticias/src/models/categories.dart';
import 'package:noticias/src/services/news_service.dart';
import 'package:noticias/src/widgets/listas_noticias_page.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatefulWidget {
  const Tab2Page({Key? key}) : super(key: key);

  @override
  State<Tab2Page> createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              _ListaCategoriasV2(),
              Expanded(
                child: _ListCategories(),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}

class _ListCategories extends StatelessWidget {
  const _ListCategories({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
   

    return newsService.isLoad
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListaNoticias(
            noticias: newsService.selectedCategoryArticles,
          );
  }
}

class _ListaCategoriasV2 extends StatelessWidget {
  const _ListaCategoriasV2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return SizedBox(
      height: 90,
      child: Center(
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final item = categories[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: _CategoryItem(category: item),
              );
            }),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Categories
      category; // Asume una clase Category con al menos un campo 'name'

  const _CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String firstLetter = category.name[0].toUpperCase();
    final String otherLetters = category.name.substring(1);

    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        print('Category: ${category.name}');
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 44,
              width: 44,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: Icon(
                category.icon,
                color: newsService.selectedCategory == category.name
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
              )),
          const SizedBox(width: 10),
          AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              style: TextStyle(
                  fontSize: 16,
                  color: newsService.selectedCategory == category.name
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary),
              child: Text(
                '$firstLetter$otherLetters',
              )),
        ],
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    // Asegúrate de que hay espacio vertical suficiente para el ListView.builder
    return SizedBox(
      height:
          50, // Ajusta esto según la altura deseada de tus elementos de lista
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          // shrinkWrap: true,
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            final item = categories[index];
            return _CategoryTile(category: item);
          }),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final Categories
      category; // Asume una clase Category con al menos un campo 'name'

  const _CategoryTile({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: () {},
      child: Row(
        children: [
          Icon(category.icon),
          const SizedBox(width: 10),
          Text(category.name, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
