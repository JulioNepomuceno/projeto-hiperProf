class ItemModel{
  String nome,email, data;
  bool isExpanded;

  ItemModel({required this.nome, required this.email, required this.data, this.isExpanded = false});
}