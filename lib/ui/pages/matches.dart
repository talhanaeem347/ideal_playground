import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/matchies/matches_bloc.dart';
import 'package:ideal_playground/repositories/match_repository.dart';
import 'package:ideal_playground/ui/widgets/liked_someone.dart';
import 'package:ideal_playground/ui/widgets/matches_grid.dart';

class Matches extends StatefulWidget {
  final String _userId;

  const Matches({required String userId, Key? key})
      : _userId = userId,
        super(key: key);

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  MatchRepository matchRepository = MatchRepository();
  late MatchesBloc _matchesBloc;
  late int differance;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _matchesBloc = MatchesBloc(matchRepository: matchRepository);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<MatchesBloc, MatchesState>(
        bloc: _matchesBloc,
        builder: (context, state) {
          if (state is MatchesLoading) {
            _matchesBloc.add(MatchesLoadEvent(userId: widget._userId));
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MatchesLoaded) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
              children: [
                matchesGrid(
                  context: context,
                    matchRepository: matchRepository,
                    size: size,
                    list: state.matchedList,
                    userId: widget._userId,
                    matchesBloc: _matchesBloc,
                ),
                likedPeople(
                    context: context,
                    matchRepository: matchRepository,
                    size: size,
                    list: state.selectedList,
                    userId: widget._userId,
                    matchesBloc: _matchesBloc,

                ),
              ],
            ));
          }
          return const Scaffold(
            body: Center(
              child: Text("Matches"),
            ),
          );
        });
  }








}
