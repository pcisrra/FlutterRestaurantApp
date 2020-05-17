import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared_widgets/darwer.dart';
import '../widgets/order_item.dart';
import '../provider/orders.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = 'Order-Screen';

  // var isLoading = false;
  // @override
  // void initState() {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        textTheme: Theme.of(context).textTheme,
        actionsIconTheme: Theme.of(context).accentIconTheme,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Color.fromARGB(0, 0, 0, 1),
        elevation: 0.0,
        title: Text('Ordenes'),
      ),
      drawer: SharedDrawer(),
      body: FutureBuilder(

          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, snapShot) {
            switch (snapShot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.active:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.none:
                return AlertDialog(
                  title: Text('Ha ocurrido un error'),
                  content: Text('No se encontraron datos!'),
                );
                break;
              case ConnectionState.done:
                if (snapShot.error != null) {
                  return AlertDialog(
                    title: Text('Ha ocurrido un error'),
                    content: Text(snapShot.error.toString()),
                  );
                } else {
                  return Consumer<Orders>(builder: (ctx, orderData, _) {
                    if (orderData.orders.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Text(
                            'No tienes ordenes!!.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: orderData.orders.length,
                      itemBuilder: (ctx, i) => OrderItem(
                        order: orderData.orders[i],
                      ),
                    );
                  });
                }
                break;
              default:
            }
            return null;
          }),
    );
  }
}