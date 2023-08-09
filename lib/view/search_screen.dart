import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/controller/cubit.dart';
import 'package:news_app/controller/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  //controller: searchController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: articleBuilder(list, context, isSearch: true),
              ),
            ],
          ),
        );
      },
    );
  }
}
