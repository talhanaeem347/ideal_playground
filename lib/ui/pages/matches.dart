import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ideal_playground/bloc/matches_bloc.dart';
import 'package:ideal_playground/repositories/match_repository.dart';

class Matches extends StatefulWidget {
  final String _userId;
  const Matches({required String userId, Key? key}) :_userId = userId, super(key: key);

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
   MatchRepository matchRepository = MatchRepository();
   late MatchesBloc _matchesBloc;
    late int differance;
   Future<void> getDifferance(GeoPoint userLocation) async {
     final currentLocation = await Geolocator.getCurrentPosition();
     differance = Geolocator.distanceBetween(
       userLocation.latitude,
       userLocation.longitude,
       currentLocation.latitude,
       currentLocation.longitude,
     ).toInt();
   }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _matchesBloc = MatchesBloc(matchRepository: matchRepository);

  }
  @override
  Widget build(BuildContext context) {
     final Size size = MediaQuery.of(context).size;
    return BlocBuilder<MatchesBloc,MatchesState>(
      bloc: _matchesBloc,
        builder: (context,state){
          if(state is MatchesLoading){
            _matchesBloc.add(MatchesLoadEvent(userId: widget._userId));
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is MatchesLoad) {}
          return const Scaffold(
            body: Center(
              child: Text("Matches"),
            ),
          );
    });
  }
}
