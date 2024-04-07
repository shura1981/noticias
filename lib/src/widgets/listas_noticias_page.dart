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
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                    fit: BoxFit.cover,
                    image: noticias[index].urlToImage.isEmpty
                        ? const Image(
                                image: AssetImage('assets/img/no-image.png'))
                            .image
                        : Image.network(noticias[index].urlToImage).image,
                    placeholder: const AssetImage('assets/img/giphy.gif')),
              ),
              title: Text(
                noticias[index].title,
                style: const TextStyle(color: Colors.grey),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RawMaterialButton(
                    onPressed: () async {
                      final Uri url = Uri.parse(noticias[index].url);
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    fillColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Icon(Icons.navigate_next),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
