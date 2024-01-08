class SearchModel {
  final String query;
  final Map<String, dynamic> answer;
  SearchModel({required this.query, required this.answer});
  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(query: json['query'], answer: json['answer']);
  }

  Map<String, dynamic> toJson() {
    return {'query': query, 'answer': answer};
  }
}
