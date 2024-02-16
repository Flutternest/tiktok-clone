import 'package:flutter/material.dart';
import 'package:tiktokclone/core/theme/text_theme.dart';
import 'package:tiktokclone/feature/global_widgets/common_padding.dart';

class CreatingPost extends StatelessWidget {
  const CreatingPost({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        title: Text(
          'Post',
          style: appTheme.displaySmall?.copyWith(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: CommonPadding(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Divider(
            height: 1,
            color: Colors.black,
          ),
          Row(
            children: [
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width - 110,
                child: TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Describe your Video',
                    errorBorder: OutlineInputBorder(
                      //<-- SEE HERE
                      borderSide: BorderSide(width: 3, color: Colors.redAccent),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(image: NetworkImage(''))),
              ),
            ],
          ),
          Spacer(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () {},
              child: Text(
                'Post',
                style: appTheme.displaySmall?.copyWith(color: Colors.white),
              ))
        ]),
      ),
    ));
  }
}
