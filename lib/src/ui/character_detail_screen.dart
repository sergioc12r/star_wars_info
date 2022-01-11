import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_info/src/bloc/character_detail/character_detail_bloc.dart';
import 'package:star_wars_info/src/common/utils/colors.dart';
import 'package:star_wars_info/src/common/utils/text_styles.dart';
import 'package:star_wars_info/src/models/character.dart';

class CharacterDetailScreen extends StatefulWidget{

  final Character? character;

  const CharacterDetailScreen({Key? key, this.character}) : super(key: key);


  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {

  CharacterDetailBloc? _bloc;

  @override
  void initState() {
    _bloc = CharacterDetailBloc(insideCharacter: widget.character)..add(LoadCharacterDetailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(builder: (context,state){
      if(state is LoadingCharacterDetailState)
        return _loadingWidget();
      if(state is ErrorCharacterDetailState)
        return _errorWidget();
      if(state is FetchCharacterDetailState)
        return _dataWidget();
      return Container();
    },
    bloc: _bloc,
    );
  }

  Widget _errorWidget() {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and morty'),),
      body: const Material(child: Center(child: Text('Error'),)),
    );
  }

  Widget _loadingWidget() => const Material(child: Center(child: CupertinoActivityIndicator(),));

  Widget _dataWidget(){
    return Scaffold(
      appBar: AppBar(title: Text('${_bloc?.character?.name}'),titleTextStyle: PrivateTextStyles.baseFont.copyWith(color: PrivateColors.appBarTitle)),
      body: _bodyData(),
    );
  }

  Widget _bodyData(){
    return Padding(
      padding: const EdgeInsets.all(12),
      child: CustomScrollView(
        slivers: [
          _sliverHead(),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          _sliverData(),
        ],
      ),
    );
  }

  Widget _sliverHead(){
    return SliverToBoxAdapter(
      child: Row(
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: CachedNetworkImage(
              imageUrl: _bloc?.character?.image ?? '',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CupertinoActivityIndicator.partiallyRevealed(progress: downloadProgress.progress ?? 0),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Expanded(child: Text('General Information ', style: PrivateTextStyles.baseFont.copyWith(fontSize: 17),textAlign: TextAlign.center,maxLines: 3,overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Widget _sliverData(){
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _itemData('Name: ',_bloc?.character?.name ?? ""),
          _itemData('Status: ',_bloc?.character?.status ?? ""),
          _itemData('Gender: ',_bloc?.character?.gender ?? ""),
          _itemData('Species: ',_bloc?.character?.species ?? ""),
          _itemData('Origin: ',_bloc?.character?.origin?.name ?? ""),
          _itemData('Location: ',_bloc?.character?.location?.name ?? ""),
        ],
      )
    );
  }

  Widget _itemData(String title, String data){
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(title,style: PrivateTextStyles.baseFont.copyWith(fontSize: 17,color: PrivateColors.paragraph), maxLines: 2,overflow: TextOverflow.ellipsis,)),
            Expanded(child: Text(data,style: PrivateTextStyles.baseFont.copyWith(fontSize: 17),maxLines: 2,overflow: TextOverflow.ellipsis, textAlign: TextAlign.right,)),
          ],
        ),
        const Divider(),
      ],
    );
  }

  @override
  void dispose() {
    _bloc?.close();
    super.dispose();
  }
}