import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_info/src/bloc/home_screen/home_screen_bloc.dart';
import 'package:star_wars_info/src/resources/mixins/scroll_mixin.dart';
import 'package:star_wars_info/src/ui/character_list_tile.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ScrollMixin {

  final HomeScreenBloc? _homeScreenBloc = HomeScreenBloc()..add(const LoadDataHomeScreenEvent());

  bool isLoading = false;

  bool hasReachedMax = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('People of Rick and Morty'),centerTitle: true,),
      body: BlocBuilder(builder: (_, state) {
        if(state is LoadingHomeScreenState)
          return _loadingWidget();
        if(state is ErrorHomeScreenState)
          return _errorWidget();
        if(state is FetchedHomeScreenState)
          return _allData();
        return Container();
      }, bloc: _homeScreenBloc),
    );
  }

  @override
  void dispose() {
    _homeScreenBloc?.close();
    super.dispose();
  }

  Widget _errorWidget() => const Text('Failed to Load Data...',style: TextStyle(color: Colors.red));

  Widget _loadingWidget() {
    return Row(
      children: const [
        Expanded(child: SizedBox()),
        CupertinoActivityIndicator(),
        SizedBox(width: 10),
        Text('Loading...',),
        Expanded(child: SizedBox()),
      ],
    );
  }

  Widget _allData(){
    return RefreshIndicator(
      onRefresh: ()async => _homeScreenBloc?.add(const LoadDataHomeScreenEvent()),
      child: CustomScrollView(
        controller: controller,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) =>
                 CharacterListTile(character: _homeScreenBloc?.allCharacters?[index]),
              childCount: _homeScreenBloc?.allCharacters?.length ?? 0,
            ),
          ),
          SliverToBoxAdapter(child: buildFooter()),
        ],
      ),
    );
  }

  @override
  onEndOfPage() {
    if ((!isLoading) && (!hasReachedMax)) {
      _homeScreenBloc?.add(RequestNewPage());
      isLoading = true;
    }
  }

  @override
  onListenerScroll() => null;

  @override
  double get scrollThreshold => 100;

  Widget buildFooter() {
    return BlocBuilder(
        bloc: _homeScreenBloc,
        builder: (context, state) {
          if (state is FetchedHomeScreenState) {
            isLoading = state.isLoading ?? false;
            hasReachedMax = state.pagination?.isLastPage ?? true;
          }
          if (!isLoading) return !hasReachedMax ? const SizedBox() : const SizedBox(height: 10);
          return Container(
            height: 80,
            padding: const EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            child: const AspectRatio(
              aspectRatio: 1,
              child: CupertinoActivityIndicator(),
            ),
          );
        });
  }

}

