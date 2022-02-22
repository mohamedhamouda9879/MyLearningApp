class NotesModel {
  String? text;
  String? placeDateTime;
  String? userId;
  String? id;

  NotesModel({this.text, this.placeDateTime, this.userId, this.id});

  NotesModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    placeDateTime = json['placeDateTime'];
    userId = json['userId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['placeDateTime'] = this.placeDateTime;
    data['userId'] = this.userId;
    data['id'] = this.id;
    return data;
  }
}