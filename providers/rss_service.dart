import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class RssFeedService with ChangeNotifier {
  final _targetUrl = 'http://rss.cnn.com/rss/edition.rss';

  Future<RssFeed> getFeed() =>
      http.read(_targetUrl).then((xmlString) => RssFeed.parse(xmlString));
}
