import 'package:flutter/material.dart';
import 'package:noticias/src/services/news_service.dart';
import 'package:noticias/src/widgets/listas_noticias_page.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({Key? key}) : super(key: key);

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final NewsService newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: newsService.headlines.isNotEmpty ? ListaNoticias(
        noticias: newsService.headlines,
      ): const Center(
        child: CircularProgressIndicator(),
      )
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
