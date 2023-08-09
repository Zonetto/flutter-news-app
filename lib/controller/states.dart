abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccssState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  late final String Error;
  NewsGetBusinessErrorState(this.Error);
}

class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetSportsSuccssState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  late final String Error;
  NewsGetSportsErrorState(this.Error);
}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetScienceSuccssState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  late final String Error;
  NewsGetScienceErrorState(this.Error);
}

class AppChangeModeState extends NewsStates {}

class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccssState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  late final String Error;
  NewsGetSearchErrorState(this.Error);
}
