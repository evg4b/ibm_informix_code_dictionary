import 'package:translator/translator.dart';

class TranslationService {
  var _cache = new Map(); 
  static final TranslationService engine = TranslationService._();
  static GoogleTranslator _translator;

  TranslationService._();

  static GoogleTranslator get _engine {
    if (_translator != null) {
      return _translator;
    }
    _translator = GoogleTranslator();
    return _translator;
  }

  Future<String> translate(String text) async {
    print("Translation");
    if (_cache[text] != null) {
      print("Translation from cache");
      return _cache[text];
    }
    var translation = await _engine.translate(text, to: "ru");
    print("Translation from api");
    _cache[text] = translation;
    return translation;
  }
}