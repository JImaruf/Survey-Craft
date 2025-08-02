// To parse this JSON data, do
//
//     final formModel = formModelFromJson(jsonString);

import 'dart:convert';

FormModel formModelFromJson(String str) => FormModel.fromJson(json.decode(str));

String formModelToJson(FormModel data) => json.encode(data.toJson());

class FormModel {
  String? dateTime;
  String? formName;
  int? id;
  List<Section>? sections;

  FormModel({
     this.formName,
     this.id,
     this.sections,
    this.dateTime
  });

  factory FormModel.fromJson(Map<String, dynamic> json) => FormModel(
    formName: json["formName"],
    id: json["id"],
    dateTime: json["date_time"]??"",
    sections: List<Section>.from(json["sections"].map((x) => Section.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "formName": formName,
    "id": id,
    "date_time": dateTime,
    "sections": List<dynamic>.from(sections!.map((x) => x.toJson())),
  };
}

class Section {
  String name;
  String key;
  List<Field> fields;

  Section({
    required this.name,
    required this.key,
    required this.fields,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    name: json["name"],
    key: json["key"],
    fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "key": key,
    "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
  };
}

class Field {
  int id;
  String key;
  Properties properties;

  Field({
    required this.id,
    required this.key,
    required this.properties,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    id: json["id"],
    key: json["key"],
    properties: Properties.fromJson(json["properties"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "properties": properties.toJson(),
  };
}

class Properties {
  String type;
  String defaultValue;
  String? hintText;
  int? minLength;
  int? maxLength;
  String label;
  String? listItems;
  bool? multiSelect;
  bool? multiImage;
  String? answer;

  Properties({
    required this.type,
    required this.defaultValue,
    this.hintText,
    this.minLength,
    this.maxLength,
    required this.label,
    this.listItems,
    this.multiSelect,
    this.multiImage,
    this.answer
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    type: json["type"],
    defaultValue: json["defaultValue"],
    hintText: json["hintText"],
    minLength: json["minLength"],
    maxLength: json["maxLength"],
    label: json["label"],
    listItems: json["listItems"],
    multiSelect: json["multiSelect"],
    multiImage: json["multiImage"],
    answer: json["answer"]??"",

  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "defaultValue": defaultValue,
    "hintText": hintText,
    "minLength": minLength,
    "maxLength": maxLength,
    "label": label,
    "listItems": listItems,
    "multiSelect": multiSelect,
    "multiImage": multiImage,
    "answer": answer,
  };
}
