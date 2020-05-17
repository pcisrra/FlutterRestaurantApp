import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Category with ChangeNotifier {
  String id;
  dynamic symbol;
  String title;
  String imageUrl;

  Category({
    @required this.id,
    @required this.symbol,
    @required this.title,
    @required this.imageUrl,
  });
}