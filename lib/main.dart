import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/news_page/news_page.dart';
import 'features/news_page/news_page_cubit.dart';
import 'features/news_page/services/news_page_web_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit(NewsService()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Case',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NewsPage(),
      ),
    );
  }
}
