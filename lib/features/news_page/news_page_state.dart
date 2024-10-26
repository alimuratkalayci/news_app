import 'models/news_page_model.dart';

abstract class NewsState {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final News newsData;

  NewsLoaded(this.newsData);

  @override
  List<Object?> get props => [newsData];
}

class NewsError extends NewsState {
  final String errorMessage;

  NewsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
