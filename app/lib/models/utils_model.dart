// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class QuestionModel {
  String? question;
  Map<String, bool>? answer;

  QuestionModel(this.question, this.answer);
}

class ReviewQuizModel {
  int? number;
  String? name;
  String? answer;
  bool isSkip = false;
  bool isVn = false;

  ReviewQuizModel(this.number, this.name, this.answer, this.isSkip, this.isVn);
}

class QuestionNumber {
  final double? x;
  final double? y;
  QuestionNumber({this.x, this.y});
}

List<QuestionNumber> get question {
  final data = <double>[2, 4, 5, 7, 8];
  return data
      .mapIndexed(
          ((index, element) => QuestionNumber(x: index.toDouble(), y: element)))
      .toList();
}
