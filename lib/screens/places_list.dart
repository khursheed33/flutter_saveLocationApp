import 'package:flutter/material.dart';
import 'package:native_features/providers/great_places.dart';
import 'package:provider/provider.dart';
import '../screens/add_places.dart';

class ListOfPlacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Great Places"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacesScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlacesProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(10),
                child: Consumer<GreatPlacesProvider>(
                  child: Center(child: Text("There is no places added yet!")),
                  builder: (ctx, placeData, ch) => placeData.places.length <= 0
                      ? ch
                      : ListView.builder(
                          itemCount: placeData.places.length,
                          itemBuilder: (ctx, index) => Card(
                            elevation: 5,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(placeData.places[index].image),
                              ),
                              title: Text(
                                placeData.places[index].title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
      ),
    );
  }
}
