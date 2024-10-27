import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../business_logic/cubit/quote_cubit.dart';
import '../../data/models/character.dart';
import '../../helper/contstants/my_colors.dart';
import '../widgets/cached_image.dart';

class CharactersDetailsPage extends StatefulWidget {
  final Character character;
  const CharactersDetailsPage({super.key, required this.character});

  @override
  State<CharactersDetailsPage> createState() => _CharactersDetailsPageState();
}

class _CharactersDetailsPageState extends State<CharactersDetailsPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<QuoteCubit>(context).fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.secondary,
        body: CustomScrollView(
          slivers: [
            buildSliverAppBar(),
            buildSliverList(),
          ],
        ));
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 500,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.secondary,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            color: Colors.black54,
            child: Text(widget.character.name,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white))),
        expandedTitleScale: 1.5,
        background: Hero(
          tag: widget.character.id,
          child: CachedImage(
            url: widget.character.image,
          ),
        ),
      ),
    );
  }

  Widget buildInfo(String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          // maxLines: 1,
          // overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: MyColors.textColor,
                ),
              ),
              TextSpan(
                text: value,
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.textColor,
                ),
              ),
            ],
          ),
        ),
        buildDivider(
            MediaQuery.sizeOf(context).width - title.length.toDouble() * 8.5)
      ],
    );
  }

  Widget buildDivider(double width) {
    return Divider(
      height: 30,
      endIndent: width,
      color: Colors.yellow[600],
      thickness: 2,
    );
  }

  Widget buildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInfo(
                    "Date of Creation : ",
                    DateFormat("MMMM dd, yyyy")
                        .format(DateTime.parse(widget.character.created))),
                buildInfo(
                  "Gender : ",
                  widget.character.gender,
                ),
                buildInfo(
                  'Status : ',
                  widget.character.status,
                ),
                buildInfo(
                  'Species : ',
                  widget.character.species,
                ),
                buildInfo(
                  'Origin : ',
                  widget.character.origin.name,
                ),
                buildInfo(
                  'Last Known Location : ',
                  widget.character.location.name,
                ),
                buildInfo(
                  'Episodes : ',
                  widget.character.episode
                      .join(' , ')
                      .splitMapJoin(RegExp(r'\d+'),
                          onMatch: (m) => '${m[0]}', // (or no onMatch at all)
                          onNonMatch: (n) => ', '),
                ),
                const SizedBox(
                  height: 20,
                ),
                buildQuote(),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildQuote() {
    return BlocBuilder<QuoteCubit, QuoteState>(
      builder: (context, state) {
        if (state is QuoteLoaded) {
          return AnimatedTextKit(
            totalRepeatCount: 4,
            pause: const Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
            animatedTexts: [
              TypewriterAnimatedText(
                state.quote.quote,
                textStyle: const TextStyle(fontSize: 24, color: Colors.white),
                speed: const Duration(milliseconds: 100),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
