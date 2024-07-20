class ProgrmesLevels {
  String name;
  bool isSelected;

  ProgrmesLevels({
    required this.name,
    required this.isSelected,
  });
}

List<ProgrmesLevels> generateProgramLevelsData() {
  return [
    ProgrmesLevels(
      name: "ig",
      isSelected: false,
    ),
    ProgrmesLevels(
      name: "sat",
      isSelected: false,
    ),
    ProgrmesLevels(
      name: "normal",
      isSelected: false,
    ),
    ProgrmesLevels(
      name: "other",
      isSelected: false,
    ),
  ];
}
