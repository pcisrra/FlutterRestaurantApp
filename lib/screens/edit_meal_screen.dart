import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../provider/categories_list.dart';
import '../widgets/category_choice.dart';
import '../model/category.dart';
import '../provider/meals.dart';
import '../model/meal.dart';

class EditMealScreen extends StatefulWidget {
  static const routeName = 'Edit_Meal_screen';

  @override
  _EditMealScreenState createState() => _EditMealScreenState();
}

class _EditMealScreenState extends State<EditMealScreen> {
  final _imageUrlController = TextEditingController();
  final _pricFocusNode = FocusNode();
  // final _catogoreyFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode =
      FocusNode();

  final _formKey = GlobalKey<FormState>();
  var _editedMeal = Meal(
    id: null,
    imagUrl: '',
    catogories: null,
    title: '',
    price: 0.0,
    description: '',
    isFavorite: false,
  );

  @override
  void initState() {
    _imageUrlFocusNode
        .addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(
        _updateImageUrl);
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    // _catogoreyFocusNode.dispose();
    _pricFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  var isLoading = false;

  Future<void> _saveMealForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    if (_editedMeal.id != null) {
      _editedMeal.catogories =
          Provider.of<CategoriesList>(context, listen: false).mySelectedCat;

      try {
      await  Provider.of<Meals>(context, listen: false)
            .updatingMeal(_editedMeal.id, _editedMeal);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Ha ocurrido un error'),
            content: Text('Algo salió mal!'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }

    } else {
      _editedMeal.catogories =
          Provider.of<CategoriesList>(context, listen: false).mySelectedCat;

      try {
        await Provider.of<Meals>(context, listen: false)
            .addNewMeal(_editedMeal);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Ha ocurrido un error'),
            content: Text('Algo salió mal!'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
    // Navigator.of(context).pop();
  }

  var _initMealValue = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };

  var _isInit = true;
  var mealId;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      mealId = ModalRoute.of(context).settings.arguments as String;
      if (mealId != null) {
        _editedMeal =
            Provider.of<Meals>(context, listen: false).findById(mealId);

        Provider.of<CategoriesList>(context)
            .addSymbolList(_editedMeal.catogories);

        _initMealValue = {
          'title': _editedMeal.title,
          'price': _editedMeal.price.toString(),
          'description': _editedMeal.description,
          // 'imageUrl': _editedMeal.imagUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedMeal.imagUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    List<Category> myCurrentCat =
        Provider.of<CategoriesList>(context).catogoriesList;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).accentIconTheme,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Color.fromARGB(0, 0, 0, 1),
        elevation: 0.0,
        title: _editedMeal.id != null ? Text('Edit Comida') : Text('Agregar Comida'),
        // actions: <Widget>[
        //   IconButton(
        //     padding: EdgeInsets.symmetric(
        //       horizontal: 20.0,
        //       vertical: 20.0,
        //     ),
        //     icon: Icon(Icons.arrow_back, size: 30),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //       // Provider.of<CatogoriesList>(context).emptyMySelectedCat();
        //     },
        //   ),
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: _saveMealForm,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        initialValue: _initMealValue['title'],
                        decoration: InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_pricFocusNode);
                        },
                        onSaved: (value) {
                          _editedMeal.title = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor ingrese un título';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _initMealValue['price'],
                        decoration: InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _pricFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        onSaved: (value) {
                          _editedMeal.price = double.parse(value);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor ingrese un precio ';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Por favor ingrese un número válido';
                          }
                          if (double.parse(value) <= 0) {
                            return 'EL precio debe ser mayor a 0';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Lista de categorías : ${Provider.of<CategoriesList>(context, listen: false).mySelectedCat}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 130,
                        margin: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: Theme.of(context).accentColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                            // scrollDirection: Axis.horizontal,
                            itemCount: myCurrentCat.length,
                            itemBuilder: (ctx, i) {
                              return CategoryChoice(
                                cat: myCurrentCat[i],
                                mealCatogories: _editedMeal.id != null
                                    ? _editedMeal.catogories
                                    : null,
                              );
                            }),
                      ),
                      // TextFormField(
                      //   initialValue: _initMealValue['catogories'],
                      //   decoration: InputDecoration(labelText: 'Catogories'),
                      //   textInputAction: TextInputAction.next,
                      //   focusNode: _catogoreyFocusNode,
                      //   onFieldSubmitted: (_) {
                      //     FocusScope.of(context).requestFocus(_descriptionFocusNode);
                      //   },
                      //   onSaved: (value) {
                      //     _editedMeal = Meal(
                      //       id: _editedMeal.id,
                      //       isFavorite: _editedMeal.isFavorite,
                      //       catogories: [value],
                      //       title: _editedMeal.title,
                      //       description: _editedMeal.description,
                      //       imagUrl: _editedMeal.imagUrl,
                      //       price: _editedMeal.price,
                      //     );
                      //   },
                      //   validator: (value) {
                      //     if (value.isEmpty) {
                      //       return 'Please enter provid value';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      TextFormField(
                        initialValue: _initMealValue['description'],
                        decoration: InputDecoration(labelText: 'Description'),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        focusNode: _descriptionFocusNode,
                        onSaved: (value) {
                          _editedMeal.description = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor ingrese un valor válido';
                          }
                          if (value.length < 10) {
                            return 'La descripción debe tener al menos 10 caracteres!!';
                          }
                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(right: 8, top: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            child: _imageUrlController.text.isEmpty
                                ? Center(child: Text('Ingrese Url'))
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              // initialValue: _initMealValue['imageUrl'],
                              decoration:
                                  InputDecoration(labelText: 'Imágen Url'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              onSaved: (value) {
                                _editedMeal.imagUrl = value;
                              },
                              onFieldSubmitted: (_) {
                                _saveMealForm();
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Por favor ingrese una URL';
                                }
                                if (!value.startsWith('http') &&
                                    !value.startsWith('https')) {
                                  return 'Por favor ingrese una URL válida';
                                }
                                if (!value.endsWith('.png') &&
                                    !value.endsWith('.jpg') &&
                                    !value.endsWith('.jpeg')) {
                                  return 'Ingrese una Url de imágen';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}