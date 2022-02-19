abstract class  NewsState{}

class NewsInitialState extends NewsState{}

class NewsBottomNavState extends NewsState{}

class NewsGetBusinessSuccessState extends NewsState{}

class NewsGetBusinessLoadingState extends NewsState{}

class NewsGetBusinessErrorState extends NewsState{
  final error;
  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsSuccessState extends NewsState{}

class NewsGetSportsLoadingState extends NewsState{}

class NewsGetSportsErrorState extends NewsState{
  final error;
  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceSuccessState extends NewsState{}

class NewsGetScienceLoadingState extends NewsState{}

class NewsGetScienceErrorState extends NewsState{
  final error;
  NewsGetScienceErrorState(this.error);
}

class NewsSearchSuccessState extends NewsState{}

class NewsSearchLoadingState extends NewsState{}

class NewsSearchErrorState extends NewsState{
  final error;
  NewsSearchErrorState(this.error);
}