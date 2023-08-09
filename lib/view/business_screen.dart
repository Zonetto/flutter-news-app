import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/controller/cubit.dart';
import 'package:news_app/controller/states.dart';
import 'package:news_app/shared/components/components.dart';

class BusineesScreen extends StatefulWidget {
  const BusineesScreen({Key? key}) : super(key: key);

  @override
  State<BusineesScreen> createState() => _BusineesScreenState();
}

class _BusineesScreenState extends State<BusineesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;
        return articleBuilder(list, context);
      },
    );
  }
}
