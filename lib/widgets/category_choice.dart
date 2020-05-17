import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/category.dart';
import '../provider/categories_list.dart';

/// this Calss just For [rendering] List of [symble & editing] them in EditMeal Screen
class CategoryChoice extends StatefulWidget {
  final Category cat;
  final List<dynamic> mealCatogories;

  CategoryChoice({
    this.cat,
    this.mealCatogories,
  });
  @override
  _CategoryChoiceState createState() => _CategoryChoiceState();
}

class _CategoryChoiceState extends State<CategoryChoice> {
  bool isSelected = false;

  var isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      if (widget.mealCatogories != null) {
        isSelected = widget.mealCatogories.contains(widget.cat.symbol);
        // Provider.of<CatogoriesList>(context )
        //     .addSymbolList(widget.mealCatogories);
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      // color: Colors.red,
      child: Consumer<CategoriesList>(
        builder: (context, cat, _) => CheckboxListTile(
          title: Text(widget.cat.title),
          value: isSelected,
          // activeColor: Colors.green,
          onChanged: (value) {
            if (!isSelected) {
              cat.addSymobl(widget.cat.symbol);
            } else {
              cat.removeSymbol(widget.cat.symbol);
            }
            setState(() {
              isSelected = !isSelected;
            });
          },
        ),
      ),
    );
  }
}