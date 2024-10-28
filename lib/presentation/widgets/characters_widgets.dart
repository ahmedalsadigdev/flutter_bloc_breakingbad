import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/characters_bloc.dart';
import '../../business_logic/cubit/search_cubit.dart';
import '../../data/models/character.dart';
import '../../helper/contstants/my_colors.dart';
import '../../helper/contstants/string.dart';
import 'cached_image.dart';
import 'loading_widget.dart';

class CharactersWidget extends StatefulWidget {
  final List<Character> characters;
  const CharactersWidget({super.key, required this.characters});

  @override
  State<CharactersWidget> createState() => _CharactersWidgetState();
}

class _CharactersWidgetState extends State<CharactersWidget> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(onScroll)
      ..dispose();
    super.dispose();
  }

  void onScroll() {
    if (scrollController.offset >=
        scrollController.position.maxScrollExtent * 0.9) {
      final isSearch = BlocProvider.of<SearchCubit>(context).isSearch;
      if (kDebugMode) {
        print("is scrolling $isSearch");
      }
      if (isSearch == false) {
        BlocProvider.of<CharactersBloc>(context).add(FetchCharactersEvent());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.secondary,
      child: GridView.builder(
        controller: scrollController,

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 2 / 3),
        itemBuilder: (context, index) {
          return index >= widget.characters.length
              ? const LoadingWidget()
              : characterGridItemWidget(widget.characters[index]);
        },
        padding: const EdgeInsets.all(10),
        physics: const ClampingScrollPhysics(),
        itemCount: BlocProvider.of<CharactersBloc>(context).nextPage ==
                BlocProvider.of<CharactersBloc>(context).pages
            ? widget.characters.length + 1
            : widget.characters.length,
        // children:
        //     characters.map((character) => characterWidget(character)).toList(),
      ),
    );
  }

  Widget characterItemWidget(Character character) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CachedImage(
          url: character.image,
        ),
        // Image.network(
        //   character.image,
        // ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: MyColors.textColor.withOpacity(0.5),
          ),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  character.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                character.status,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget characterGridItemWidget(Character character) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        border: Border.all(width: 4, color: MyColors.textColor),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, charactersDetailsPage,
            arguments: character),
        child: GridTile(
          footer: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            color: Colors.black54,
            child: Text(
              character.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  height: 1.3,
                  fontWeight: FontWeight.w600,
                  color: MyColors.textColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          child: Hero(
            tag: character.id,
            child: CachedImage(
              url: character.image,
            ),
          ),
        ),
      ),
    );

    // Stack(
    //   alignment: Alignment.bottomCenter,
    //   children: [
    //     CachedImage(
    //       url: character.image,
    //     ),
    //     // Image.network(
    //     //   character.image,
    //     // ),
    //     Container(
    //       padding: const EdgeInsets.symmetric(horizontal: 5),
    //       decoration: BoxDecoration(
    //         borderRadius: const BorderRadius.only(
    //             topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    //         color: MyColors.textColor.withOpacity(0.5),
    //       ),
    //       width: double.infinity,
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           FittedBox(
    //             child: Text(
    //               character.name,
    //               textAlign: TextAlign.center,
    //               style: const TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.w600),
    //               maxLines: 1,
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //           ),
    //           Text(
    //             character.status,
    //             style: const TextStyle(fontWeight: FontWeight.w600),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
