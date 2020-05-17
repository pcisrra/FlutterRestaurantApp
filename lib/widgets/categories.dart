import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/categories_list.dart';
import '../widgets/category_item.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final catogorie = Provider.of<CategoriesList>(context).catogoriesList;

    return Container(
      height: 150,
      // color: Colors.red,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: catogorie.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: catogorie[i],
          child: CategoriesItem(
              // id: catData.id,
              // title: catData.title,
              // image: catData.imageUrl,
              ),
        ),
      ),
    );
  }
}