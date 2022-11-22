class DonerCardData {
  DonerCardData({
    required this.id,
    required this.title,
    required this.description,
    this.isExpanded = false,
  });

  int id;
  String title;
  String description;
  bool isExpanded;

  static List<DonerCardData> generateItems(int numberOfItems) {
    return List<DonerCardData>.generate(numberOfItems, (int index) {
      return DonerCardData(
        id: index + 1,
        title: 'Doner${index + 1}',
        description: 'Está é a descrição do Doner ${index + 1}',
      );
    });
  }
}
