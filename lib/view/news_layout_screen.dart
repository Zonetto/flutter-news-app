import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/controller/cubit.dart';
import 'package:news_app/controller/states.dart';
import 'package:news_app/shared/components/components.dart';

import 'search_screen.dart';

class NewsLayoutScreen extends StatefulWidget {
  const NewsLayoutScreen({Key? key}) : super(key: key);

  @override
  State<NewsLayoutScreen> createState() => _NewsLayoutScreenState();
}

class _NewsLayoutScreenState extends State<NewsLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'News',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateto(context, const SearchScreen());
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: () {
                  NewsCubit.get(context).changeAppMode();
                },
                icon: Icon(
                  !NewsCubit.get(context).isDark
                      ? Icons.brightness_medium_outlined
                      : Icons.brightness_medium_rounded,
                ),
              ),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
