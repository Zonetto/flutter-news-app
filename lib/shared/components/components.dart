import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/view/web_view/web_view_screen.dart';

Widget myDivider({
  double end = 0.0,
  Color color = Colors.blue,
}) {
  return Padding(
    padding: EdgeInsetsDirectional.only(
      start: 10.0,
      end: end,
    ),
    child: Container(
      color: color,
      width: double.infinity,
      height: 0.5,
    ),
  );
}

Widget buildArticItem(Map article, context) {
  final String title = article['title'];
  final String date = article['publishedAt'];
  final String currentDate =
      DateFormat("yyyy-MM-dd").format(DateTime.parse(date));
  return InkWell(
    //highlightColor: Colors.amber,
    splashColor: Colors.blue,
    onTap: () {
      navigateto(context, WebViewScreen(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              image: DecorationImage(
                image: AssetImage('assets/image/iconsNews.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    currentDate,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget articleBuilder(list, context, {isSearch = false}) {
  //list = NewsCubit.get(context).science;
  return list.length > 0
      ? ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildArticItem(list[index], context),
          separatorBuilder: (context, index) =>
              myDivider(color: Color(0xFFEF5B0C)),
          itemCount: 10,
        )
      : isSearch
          ? Container()
          : Center(child: CircularProgressIndicator());
}

void navigateto(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );
