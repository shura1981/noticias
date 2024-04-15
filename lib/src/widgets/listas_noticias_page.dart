import 'package:flutter/material.dart';
import 'package:noticias/src/models/news_models.dart';
import 'package:url_launcher/url_launcher.dart';

class ListaNoticias extends StatelessWidget {
  const ListaNoticias({Key? key, required this.noticias}) : super(key: key);
  final List<Article> noticias;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: noticias.length,
        itemBuilder: (BuildContext context, int index) {
          return _ItemNewList(noticias: noticias, index: index);
        },
      ),
    );
  }
}

class _ItemNewList extends StatelessWidget {
  const _ItemNewList({
    required this.noticias,
    required this.index,
  });

  final List<Article> noticias;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _TarjetaTopBar(noticias: noticias, index: index),
          _TarjetaTitulo(noticias: noticias, index: index),
          _TarjetaImagen(noticias: noticias, index: index),
          _TarjetaBody(noticias: noticias, index: index),
          _TarjetaBotones(noticias: noticias, index: index),
        ],
      ),
    );
  }
}

_TarjetaTopBar({required List<Article> noticias, required int index}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Text('${index + 1}. ', style: const TextStyle(color: Colors.blue)),
        Text('${noticias[index].source.name}. '),
      ],
    ),
  );
}

_TarjetaTitulo({required List<Article> noticias, required int index}) {
  return Container(
    child: Text(noticias[index].title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
  );
}

_TarjetaImagen({required List<Article> noticias, required int index}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: FadeInImage(
              fit: BoxFit.cover,
              image: noticias[index].urlToImage.isEmpty
                  ? const Image(
                          image: AssetImage('assets/img/no-image.png'))
                      .image
                  : Image.network(noticias[index].urlToImage).image,
              placeholder: const AssetImage('assets/img/giphy.gif')),
        ),
  );
}

_TarjetaBody({required List<Article> noticias, required int index}) {
  return Text(noticias[index].description ?? 'Sin descripción');
}

_TarjetaBotones({required List<Article> noticias, required int index}) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () async {
            final url = noticias[index].url;
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: const Text('Ver más'),
        ),
      ],
    ),
  );
}