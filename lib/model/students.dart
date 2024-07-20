class Students {
  final String text;
  bool isSelected;
  final int? count;

  Students({required this.text, this.isSelected = false, this.count});
}

List<Students> generateStudentsData() {
  return [
    Students(text: 'one student', count: 1),
    Students(text: 'two student', count: 2),
    Students(text: 'three student', count: 3),
    Students(text: 'More than three students', count: 10),
  ];
}
