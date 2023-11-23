class Todo{
  final String title;
  final String description;
  bool isComplete;

  Todo({
    this.title = '',
    this.description = '',
    this.isComplete = false
  });


  Todo copyWith({
    String? title,
    String? description,
    bool? isComplete,
  }) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        title: json['title'],
        description: json['description'],
        isComplete: json['isComplete']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isComplete': isComplete
    };
  }

  @override
  String toString() {
    return '''Todo: {
			title: $title\n
			description: $description\n
			isComplete: $isComplete\n
		}''';
  }
}