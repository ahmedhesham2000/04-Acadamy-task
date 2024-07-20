class AcademicLevels {
  String name;
  bool isSelected;
  List<ClasseLevels> classes;

  AcademicLevels({
    required this.name,
    required this.isSelected,
    required this.classes,
  });
}

class ClasseLevels {
  String name;
  bool isSelected;

  ClasseLevels({
    required this.name,
    required this.isSelected,
  });
}

List<AcademicLevels> generateAcademicLevelsData() {
  return [
    AcademicLevels(name: "kg", isSelected: true, classes: [
      ClasseLevels(
        name: "KG1",
        isSelected: false,
      ),
      ClasseLevels(
        name: "KG2",
        isSelected: false,
      ),
    ]
        // ["KG1", "KG2"],
        ),
    AcademicLevels(name: "primery", isSelected: false, classes: [
      ClasseLevels(
        name: "first",
        isSelected: false,
      ),
      ClasseLevels(
        name: "second",
        isSelected: false,
      ),
      ClasseLevels(
        name: "third",
        isSelected: false,
      ),
      ClasseLevels(
        name: "fourth",
        isSelected: false,
      ),
    ]),
    AcademicLevels(name: "secondary", isSelected: false, classes: [
      ClasseLevels(
        name: "fifth",
        isSelected: false,
      ),
      ClasseLevels(
        name: "six",
        isSelected: false,
      ),
      ClasseLevels(
        name: "seven",
        isSelected: false,
      ),
      ClasseLevels(
        name: "eight",
        isSelected: false,
      ),
      ClasseLevels(
        name: "nine",
        isSelected: false,
      ),
    ]
        //  [
        //   "fifth",
        //   "six",
        //   "seven",
        //   "eight",
        //   "nine",
        // ],
        ),
    AcademicLevels(name: "high_school", isSelected: false, classes: [
      ClasseLevels(
        name: "ten",
        isSelected: false,
      ),
      ClasseLevels(
        name: "eleven",
        isSelected: false,
      ),
      ClasseLevels(
        name: "twelve",
        isSelected: false,
      ),
    ]
        // ["ten", "eleven", ""],
        ),
  ];
}
