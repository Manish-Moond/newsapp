import 'package:flutter/material.dart';
import 'package:newsapp/constants/colors.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/widgets/news_card_widget.dart';
import 'package:newsapp/repository/news_local_repo.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  final NewsLocalRepository _localRepository = NewsLocalRepository();

  List<Article> savedArticles = [];
  Set<String> savedUrls = {};
  bool _featched = false;

  _saveArticlesToLocal(Article art) {
    _localRepository.saveArticle(art);
  }

  _removeArticlesFromLocal(String url, int i) {
    setState(() {
      savedArticles.removeAt(i);
    });
    _localRepository.removeArticle(url);
  }

  @override
  void initState() {
    super.initState();
    _localRepository.getArticles().then((value) {
      setState(() {
        _featched = true;
        for (int i = 0; i < value.length; i++) {
          savedArticles.add(value[i]);
          savedUrls.add(value[i].url!);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile(BuildContext context) =>
        MediaQuery.of(context).size.width < 750;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Saved Articles",
            style: TextStyle(color: kWhiteColor),
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: _featched
            ? isMobile(context)
                ? Center(
                    child: SizedBox(
                      width: 600,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: savedArticles.length,
                                itemBuilder: (_, index) {
                                  return NewsCardWidget(_saveArticlesToLocal,
                                      index: index,
                                      removeFromLocal: _removeArticlesFromLocal,
                                      savedUrls: savedUrls,
                                      news: savedArticles[index]);
                                }),
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: GridView.builder(
                        itemCount: savedArticles.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 450.0,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemBuilder: (_, index) {
                          return NewsCardWidget(
                            _saveArticlesToLocal,
                            index: index,
                            removeFromLocal: _removeArticlesFromLocal,
                            savedUrls: savedUrls,
                            news: savedArticles[index],
                          );
                        }),
                  )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
