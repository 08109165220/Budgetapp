class Item {
  final String name;
  final String category;
  final double price;
  final DateTime date;

  Item({
    required this.name,
    required this.category,
    required this.price,
    required this.date,
  });
  factory Item.fromMap(Map<String ,dynamic>map){
    final properties =map["properties"] as Map <String ,dynamic>;
    final dateStr=properties["Date"]?["date"]?["Start"] ;
    return Item(
        name:properties["Name"]?["title"]?[0]?["plain_text"] ??"?",
        category:properties["Category"]?["select"]?["name "] ??"any",
    price:(properties["Price"]?["number"] ?? 0).todouble,
    date:dateStr!=null?DateTime.parse(dateStr):DateTime.now(),
    );

  }
}
