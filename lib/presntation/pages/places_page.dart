import 'package:fav_place/data/models/place.dart';
import 'package:fav_place/data/models/place_local_ds/place_local_ds.dart';
import 'package:fav_place/presntation/bloc/authentication_bloc_bloc.dart';
import 'package:fav_place/presntation/bloc/place_bloc.dart';
import 'package:fav_place/presntation/pages/add_place.dart';
import 'package:fav_place/presntation/pages/sign_in_page.dart';
import 'package:fav_place/presntation/widgets/place_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesPage extends StatefulWidget {
  const PlacesPage({super.key});

  @override
  State<PlacesPage> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  @override
  void initState()  {
    super.initState();
    context.read<PlaceBloc>().add(GetPlacesEvent());
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        actions: [
          GestureDetector(
            child: Icon(Icons.output),
            onTap: () {
              context
                  .read<AuthenticationBlocBloc>()
                  .add(AuthenticationSignOutEvent());
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(),
                  ));
            },
          )
        ],
        title: Text(
          "Favorite Places",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocConsumer<PlaceBloc, PlaceState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return ListView(
            children: [
              if (state is PlaceLoadingState) CircularProgressIndicator(),
              
              if (state is PlaceloadedState)
                Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, i) =>
                        PlaceListTile(place: state.places[i]),
                    itemCount: state.places.length,
                  ),
                )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        onPressed: () {
          try {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPlace(

                  ),
                ));
          } catch (e) {
            print(e);
          }
        },
        tooltip: 'Add Place',
        child: const Icon(Icons.add),
      ),
    );
  }
}
