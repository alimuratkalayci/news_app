import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news_page/components/news_card.dart';
import 'details_pages/news_detail_page/news_detail_page.dart';
import 'models/news_page_model.dart';
import 'news_page_cubit.dart';
import 'news_page_state.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String? selectedCountryValue;
  final List<String> selectedCountryItems = [
    'TR',
    'AU',
    'CN',
    'US',
    'JP',
    'GB'
  ];

  String? selectedCategoryValue;
  final List<String> selectedCategoryItems = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];

  TextEditingController _searchController = TextEditingController();
  List<Article> _filteredArticles = [];

  @override
  void initState() {
    super.initState();
    selectedCountryValue = 'US';
    selectedCategoryValue = 'business';
    if (selectedCountryValue != null && selectedCategoryValue != null) {
      context
          .read<NewsCubit>()
          .fetchNews(selectedCountryValue!, selectedCategoryValue!);
    }
    _searchController.addListener(_filterArticles);
  }

  void _filterArticles() {
    final query = _searchController.text.toLowerCase();
    final state = context.read<NewsCubit>().state;

    if (state is NewsLoaded) {
      final articles = state.newsData.articles;
      setState(() {
        _filteredArticles = articles.where((article) {
          return article.title.toLowerCase().contains(query) ||
              (article.description != null &&
                  article.description!.toLowerCase().contains(query));
        }).toList();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFBF4F4),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xffFBF4F4),
        elevation: 0,
        scrolledUnderElevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xff254a83),
                  Color(0xffffffff),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )),
        ),
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("News"),
        ),
      ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            final articlesToShow = _searchController.text.isNotEmpty
                ? _filteredArticles
                : state.newsData.articles;

            return Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Country',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xff254a83)),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff254a83),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: DropdownButton<String>(
                                    iconSize: 32,
                                    iconEnabledColor: Colors.white,
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    borderRadius: BorderRadius.circular(16),
                                    value: selectedCountryValue,
                                    items: selectedCountryItems
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(value,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedCountryValue = newValue;
                                        if (selectedCategoryValue != null) {
                                          context.read<NewsCubit>().fetchNews(
                                              selectedCountryValue!,
                                              selectedCategoryValue!);
                                        }
                                      });
                                    },
                                    dropdownColor: const Color(0xff254a83),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Category',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xff254a83)),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff254a83),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: DropdownButton<String>(
                                    iconSize: 32,
                                    isExpanded: true,
                                    iconEnabledColor: Colors.white,
                                    underline: const SizedBox(),
                                    borderRadius: BorderRadius.circular(16),
                                    value: selectedCategoryValue,
                                    items: selectedCategoryItems
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(value,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedCategoryValue = newValue;
                                        if (selectedCountryValue != null) {
                                          context.read<NewsCubit>().fetchNews(
                                              selectedCountryValue!,
                                              selectedCategoryValue!);
                                        }
                                      });
                                    },
                                    dropdownColor: const Color(0xff254a83),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.cancel_outlined),
                                  color: const Color(0xff254a83),
                                  onPressed: () {
                                    _searchController.clear();
                                    _filterArticles();
                                  },
                                ),
                                labelText: 'Search',
                                labelStyle: const TextStyle(
                                  color: Color(0xff254a83),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xff254a83),
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: Color(0xff254a83),
                                    width: 2.0,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 12.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff254a83),
                          Color(0xffffffff),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 24),
                      child: ListView.builder(
                        itemCount: articlesToShow.length,
                        itemBuilder: (context, index) {
                          final article = articlesToShow[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NewsDetailPage(article: article),
                                ),
                              );
                            },
                            child: NewsCard(article: article),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is NewsError) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
    );
  }
}
