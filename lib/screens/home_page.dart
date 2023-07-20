import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/constants/colors.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/widgets/news_card_widget.dart';
import 'package:newsapp/repository/news_local_repo.dart';
import 'package:newsapp/repository/news_repo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HttpNewsRepository _httpNewsRepository = HttpNewsRepository();
  final NewsLocalRepository _localRepository = NewsLocalRepository();
  final TextEditingController _controller =
      TextEditingController(text: "India");

  Set<String> savedUrls = {};
  String intitialText = "India";
  bool _isSearchBarVisible = true;
  List<Article> news = [];
  List<Article> savedArticles = [];
  bool _featched = false;

  void _toggleSearchBarVisibility() {
    setState(() {
      _isSearchBarVisible = !_isSearchBarVisible;
    });
    if (_controller.text != intitialText) {
      intitialText = _controller.text;
      _featched = false;
      news = [];
      _httpNewsRepository
          .getNews(_controller.text)
          .then((value) => _filler(value.articles));
    }
  }

  _filler(value) {
    for (int i = 0; i < value.length; i++) {
      news.add(value[i]);
    }
    setState(() {
      _featched = true;
    });
  }

  _saveArticlesToLocal(Article art) {
    _localRepository.saveArticle(art);
  }

  _removeArticlesFromLocal(String url, int i) {
    _localRepository.removeArticle(url);
  }

  @override
  void initState() {
    super.initState();
    _httpNewsRepository
        .getNews(_controller.text)
        .then((value) => _filler(value.articles));
    _localRepository.getArticles().then((value) {
      for (int i = 0; i < value.length; i++) {
        savedArticles.add(value[i]);
        savedUrls.add(value[i].url!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile(BuildContext context) =>
        MediaQuery.of(context).size.width < 750;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: _isSearchBarVisible
              ? Text(
                  "News about ${_controller.text}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: kWhiteColor),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: kWhiteColor),
                    cursorColor: kWhiteColor,
                    decoration: InputDecoration(
                        fillColor: kWhiteColor,
                        hintText: "You can search any topic",
                        hintStyle: TextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kWhiteColor)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kWhiteColor))),
                  ),
                ),
          actions: [
            IconButton(
                onPressed: _toggleSearchBarVisibility,
                icon: const Icon(
                  FluentIcons.search_16_filled,
                  color: Colors.white,
                ))
          ],
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
                                itemCount: news.length,
                                itemBuilder: (_, index) {
                                  return NewsCardWidget(
                                    _saveArticlesToLocal,
                                    index: index,
                                    removeFromLocal: _removeArticlesFromLocal,
                                    savedUrls: savedUrls,
                                    news: news[index],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: GridView.builder(
                        itemCount: news.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 500.0,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemBuilder: (_, index) {
                          return NewsCardWidget(
                            _saveArticlesToLocal,
                            index: index,
                            removeFromLocal: _removeArticlesFromLocal,
                            savedUrls: savedUrls,
                            news: news[index],
                          );
                        }),
                  )
            : const Center(child: CircularProgressIndicator()));
  }
}
