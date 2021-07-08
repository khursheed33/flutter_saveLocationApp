import 'package:flutter/material.dart';
import 'package:native_features/providers/great_places.dart';
import 'package:native_features/screens/add_places.dart';
import 'package:native_features/screens/places_list.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GreatPlacesProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home: ListOfPlacesScreen(),
        routes: {
          AddPlacesScreen.routeName: (ctx) => AddPlacesScreen(),
        },
      ),
    );
  }
}
