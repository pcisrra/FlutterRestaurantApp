import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/random_list.dart';
import '../widgets/categories.dart';
import '../widgets/populer.dart';
import '../provider/meals.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSeeAll = false;

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Meals>(context, listen: false).fetchAndSetMeals(),
      builder: (BuildContext context, AsyncSnapshot dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (dataSnapshot.error != null) {
            return AlertDialog(
              title: Text('Ha ocurrido un error'),
              content: Text('No hay conexión a internet!'),
            );
          } else {
            return Container(
              // padding: EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Platter',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  RandomList(),
                  // SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tipo de Comida',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Categories(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Populares',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            isSeeAll ? 'Ver Menos' : 'Ver Todo',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isSeeAll = !isSeeAll;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Populer(isSeeAll: isSeeAll),
                ],
              ),
            );
          }
        }
      },
    );
  }
}