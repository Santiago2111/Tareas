class TaskData {
  String? title;
  String? description;
  DateTime? date;
  String? priority;

  TaskData({
    this.title,
    this.description,
    this.date,
    this.priority,
  });

  @override
  String toString() {
    return """
      Title: ${title}, 
      Description: ${description}, 
      Date: ${date}, 
      Priority: ${priority}, 
    """;
  }
}
