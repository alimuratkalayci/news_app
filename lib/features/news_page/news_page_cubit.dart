import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news_page/services/news_page_web_service.dart';

import 'news_page_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsService newsService;

  NewsCubit(this.newsService) : super(NewsInitial());

  Future<void> fetchNews(String country, String category) async {
    emit(NewsLoading());
    try {
      final newsData = await newsService.fetchNewsData(country, category);
      emit(NewsLoaded(newsData));
    } catch (e) {
      emit(NewsError("Failed to fetch news: $e"));
    }
  }
}
