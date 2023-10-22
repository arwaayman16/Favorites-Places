
import 'package:fav_place/data/place_local_ds/place_local_ds.dart';
import 'package:fav_place/presntation/pages/add_place.dart';
import 'package:fav_place/presntation/widgets/place_list_tile.dart';
import 'package:flutter/material.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          "Favorite Places",
          style: Theme.of(context).textTheme.labelMedium,
          
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body:  Container(
          child: FutureBuilder(
              future: PlaceLocalDSIml().getPlace(),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                 
                    itemBuilder: (context, i) =>
                        PlaceListTile(place:snapshot.data![i]),
                    itemCount: snapshot.data!.length,
                  );
                }
              }),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPlace(file: null,),
              ));
        },
        tooltip: 'Add Place',
        child: const Icon(Icons.add),
      ),
    );
  }
}
