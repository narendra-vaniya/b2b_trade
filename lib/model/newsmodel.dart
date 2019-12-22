import 'dart:io';

class NewsModel {
  final String _newsText;
  final File _newsImage;
  
  //Con
  NewsModel(this._newsText, this._newsImage);

  //Getter

  String get getnewsText => _newsText;
  File get getnewsImage => _newsImage;

  //Convert to Json
    json(NewsModel data) {
    return {'newsText': data._newsText, 'newsImage': data._newsImage};
  }
}
