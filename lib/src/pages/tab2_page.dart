import 'package:flutter/material.dart';
import 'package:noticias/src/models/categories.dart';
import 'package:noticias/src/services/news_service.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [_ListaCategorias()],
          ),
        ),
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
