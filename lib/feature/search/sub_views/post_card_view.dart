import 'package:flutter/material.dart';
import 'package:tiktokclone/core/constants/constants.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/core/utility/design_utility.dart';

class PostCardView extends StatefulWidget {
  const PostCardView({
    super.key,
    required this.description,
    required this.thumbnailUrl,
    required this.numberOfLikes,
    required this.firstName,
    required this.lastName,
  });
  final String description;
  final String thumbnailUrl;
  final String numberOfLikes;
  final String firstName;
  final String lastName;

  @override
  State<PostCardView> createState() => _PostCardViewState();
}

class _PostCardViewState extends State<PostCardView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              clipBehavior: Clip.antiAlias,
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x07000000),
                    blurRadius: 15,
                    offset: Offset(0, 3),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Image(
                image: NetworkImage(widget.thumbnailUrl),
                fit: BoxFit.fill,
              )),
          Text(
            widget.description,
            maxLines: 2,
            style: appTheme.displaySmall?.copyWith(
              height: 1.6,
              overflow: TextOverflow.ellipsis,
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          Row(
            children: [
              const SizedBox(
                height: 29,
                width: 29,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    AppString.testingUrl,
                  ),
                ),
              ),
              horizontalSpaceTiny,
              Expanded(
                child: Text(
                  "${widget.firstName} ${widget.lastName}",
                  maxLines: 2,
                  style: appTheme.headlineSmall?.copyWith(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              horizontalSpaceTiny,
              const Icon(
                Icons.favorite_border,
                color: Colors.grey,
                size: 20,
              ),
              Text(
                widget.numberOfLikes,
                style: appTheme.headlineSmall?.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
