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
    if (_cache[text] != null) {
      return _cache[text];
    }
    var translation = await _engine.translate(text, from:"en", to: "ru");
    _cache[text] = translation;
    return translation;
  }
}