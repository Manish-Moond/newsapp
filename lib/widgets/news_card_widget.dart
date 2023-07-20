import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/constants/colors.dart';
import 'package:newsapp/models/news_model.dart';

// ignore: must_be_immutable
class NewsCardWidget extends StatefulWidget {
  int index;
  Article news;
  Set<String> savedUrls;
  Function saveTolocal;
  Function removeFromLocal;
  NewsCardWidget(
    this.saveTolocal, {
    super.key,
    required this.index,
    required this.removeFromLocal,
    required this.savedUrls,
    required this.news,
  });

  @override
  State<NewsCardWidget> createState() => _NewsCardWidgetState();
}

class _NewsCardWidgetState extends State<NewsCardWidget> {
  bool _favPressed = false;

  @override
  Widget build(BuildContext context) {
    if (widget.savedUrls.contains(widget.news.url)) {
      _favPressed = true;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 220,
            width: 380,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: Image.network(
                widget.news.urlToImage ?? "https://via.placeholder.com/350x150",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            "${widget.news.title}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.news.source!.name}",
                style: const TextStyle(fontSize: 12),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _favPressed = !_favPressed;
                        if (widget.savedUrls.contains(widget.news.url)) {
                          widget.savedUrls.remove(widget.news.url);
                          widget.removeFromLocal(widget.news.url, widget.index);
                        } else {
                          widget.savedUrls.add(widget.news.url!);
                          widget.saveTolocal(widget.news);
                        }
                      });
                    },
                    icon: Icon(
                        _favPressed ||
                                widget.savedUrls.contains(widget.news.url)
                            ? FluentIcons.heart_16_filled
                            : FluentIcons.heart_16_regular,
                        color: kPrimaryColor),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(FluentIcons.share_android_20_filled),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(FluentIcons.more_vertical_16_filled),
                  ),
                ],
              ),
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
