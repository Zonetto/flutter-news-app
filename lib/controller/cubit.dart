import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/controller/states.dart';

import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/local/remote/dio_helper.dart';
import 'package:news_app/view/business_screen.dart';
import 'package:news_app/view/science_screen.dart';
import 'package:news_app/view/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  List<dynamic> business = [];
  List<dynamic> science = [];
  List<dynamic> sports = [];
  List<dynamic> search = [];

  int currentIndex = 0;
  bool isDark = false;

  List<Widget> screen = const [
    BusineesScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putDate(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getBusiness();
    if (index == 2) getSports();
    if (index == 3) getScience();
    emit(NewsBottomNavState());
  }

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '6b6d63fa50f3412a841149558a3e73ac',
      },
    ).then((value) {
      //print(value.data['articles'][1]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccssState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '6b6d63fa50f3412a841149558a3e73ac',
      },
    ).then((value) {
      sports = value.data['articles'];
      //print(sports[0]['title']);
      emit(NewsGetSportsSuccssState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '6b6d63fa50f3412a841149558a3e73ac',
      },
    ).then((value) {
      science = value.data['articles'];
      print(science[0]['articles']);
      emit(NewsGetScienceSuccssState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '6b6d63fa50f3412a841149558a3e73ac',
      },
    ).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccssState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
// https://newsapi.org/
// v2/top-headlines?
// sources=google-news-sa&apiKey=15dab3a3cb694c4ab5218d9d530fce42

// https://newsapi.org/
// v2/top-headlines?
// country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

// https://newsapi.org/
// v2/top-headlines?
// country=eg&category=business&apiKey=15dab3a3cb694c4ab5218d9d530fce42
