import 'package:flutter/cupertino.dart';
import 'package:apprestaurant/model/category.dart';

class CategoriesList with ChangeNotifier {
  List<dynamic> _mySelectedCat = [];

  final List<Category> _catogeriesList = [
    Category(
      id: 'c1',
      title: 'BreakFast',
      symbol: 'break',
      imageUrl: 'assets/images/lunch.png',
    ),
    Category(
      id: 'c2',
      title: 'Lunch',
      symbol: 'lunch',
      imageUrl: 'assets/images/preak.png',
    ),
    Category(
      id: 'c3',
      title: 'Burger',
      symbol: 'burger',
      imageUrl: 'assets/images/burger.png',
    ),
    Category(
      id: 'c4',
      title: 'Chips',
      symbol: 'chips',
      imageUrl: 'assets/images/chips.png',
    ),
    Category(
      id: 'c5',
      title: 'Pizza',
      symbol: 'pizza',
      imageUrl: 'assets/images/pizza.png',
    ),
    Category(
      id: 'c6',
      title: 'Drink',
      symbol: 'drink',
      imageUrl: 'assets/images/drink.png',
    ),
  ];

  List<Category> get catogoriesList {
    return List.from(_catogeriesList);
  }

  void addNewCatogorie(Category catogorie) {
    final newCatogorie = Category(
      id: DateTime.now().toIso8601String(),
      title: catogorie.title,
      symbol: catogorie.symbol,
      imageUrl: catogorie.imageUrl,
    );
    _catogeriesList.insert(0, newCatogorie);
    notifyListeners();
  }

  void updatrCatogorie(String id, Category editingCatogorie) {
    final catIndex = _catogeriesList.indexWhere((cat) => cat.id == id);
    if (catIndex >= 0) {
      _catogeriesList[catIndex] = editingCatogorie;
      notifyListeners();
    } else {
      print('....');
    }
  }

  void removeCat(String catId) {
    _catogeriesList.removeWhere((cato) => cato.id == catId);
    notifyListeners();
  }

  List<dynamic> get mySelectedCat {
    return List.from(_mySelectedCat);
  }

  void addSymobl(dynamic symbol) {
    _mySelectedCat.add(symbol);
    notifyListeners();
  }

  void addSymbolList(List<dynamic> symbolList) {
    _mySelectedCat = symbolList;
    notifyListeners();
  }

  void removeSymbol(dynamic symbol) {
    _mySelectedCat.remove(symbol);
    notifyListeners();
  }

  void emptyMySelectedCat() {
    _mySelectedCat.clear();
    notifyListeners();
  }
}