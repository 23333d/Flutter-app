class product {
  late String pName;
  late String pLocaion;
  late String pDescription;
  late String pPrice;
  late String pCatogary;
  late String? pId;
  int? pQuantity;

  product(
      {required this.pDescription,
      required this.pCatogary,
      required this.pLocaion,
      required this.pName,
      required this.pPrice,
      this.pId,
      this.pQuantity});
}
