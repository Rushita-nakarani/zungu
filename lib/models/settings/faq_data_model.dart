import 'dart:convert';

import 'package:zungu_mobile/models/api_response_obj.dart';

List<FaqDataModel> faqDataModelFromJson(String str) => List<FaqDataModel>.from(
      defaultRespInfo(str).resultArray.map((x) => FaqDataModel.fromJson(x)),
    ).toList();

String faqDataModelToJson(List<FaqDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FaqDataModel {
  FaqDataModel({
    this.id = "",
    this.questionJson = const [],
    this.title = "",
  });

  String id;
  List<QuestionJson> questionJson;
  String title;

  factory FaqDataModel.fromJson(Map<String, dynamic> json) => FaqDataModel(
        id: json["_id"] ?? "",
        questionJson: json["questionJson"] == null
            ? []
            : List<QuestionJson>.from(
                json["questionJson"].map((x) => QuestionJson.fromJson(x)),
              ),
        title: json["title"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "questionJson": questionJson == null
            ? []
            : List<dynamic>.from(questionJson.map((x) => x.toJson())),
        "title": title,
      };
}

class QuestionJson {
  QuestionJson({
    this.id = "",
    this.question = "",
    this.answer = "",
    this.isShow = true,
  });

  String id;
  String question;
  String answer;
  bool isShow;

  factory QuestionJson.fromJson(Map<String, dynamic> json) => QuestionJson(
        id: json["_id"] ?? "",
        question: json["question"] ?? "",
        answer: json["answer"] ?? "",
        isShow: json["isShow"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "question": question,
        "answer": answer,
        "isShow": isShow,
      };
}
