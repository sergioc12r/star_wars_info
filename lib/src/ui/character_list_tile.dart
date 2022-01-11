import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_info/src/common/utils/colors.dart';
import 'package:star_wars_info/src/common/utils/text_styles.dart';
import 'package:star_wars_info/src/models/character.dart';

class CharacterListTile extends StatelessWidget{

  final Character? character;

  const CharacterListTile({Key? key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      return ListTile(
        leading: CachedNetworkImage(
          imageUrl: character?.image ?? '',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CupertinoActivityIndicator.partiallyRevealed(progress: downloadProgress.progress ?? 0),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        onTap: ()=>_onTap(context),
        title: Text(character?.name ?? '',style: PrivateTextStyles.baseFont),
        subtitle: Text(character?.status ?? '', style: PrivateTextStyles.baseFont.copyWith(fontSize: 14, color: PrivateColors.paragraph)),
        trailing: const Icon(Icons.arrow_forward_ios),
      );
    });
  }

  _onTap(BuildContext context) => Navigator.pushNamed(context,'/detail',arguments: character);
}