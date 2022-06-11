import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wavie/presentation/blocs/search_movie/bloc/search_movie_bloc.dart';
import 'package:wavie/presentation/journeys/search/searched_item_widget.dart';
import 'package:wavie/presentation/themes/app_colors.dart';
import '';

import '../../../di/get_it.dart';
import '../../utils/custom_page_route.dart';
import '../../widgets/app_error_widget.dart';
import '../../../common/extensions/size_extensions.dart';
import '../movie_detail/movie_detail_arguments.dart';
import '../movie_detail/movie_detail_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchMovieBloc? _searchMovieBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchMovieBloc = getItInstance<SearchMovieBloc>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchMovieBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _searchMovieBloc!,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  color: AppColor.white,
                  margin: EdgeInsets.only(top: 20.0),
                  child: TextField(
                    autocorrect: false,
                    style: TextStyle(color: AppColor.background),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search',
                    ),
                    onChanged: (value) {
                      //print(value);
                      if (value.isNotEmpty) {
                        _searchMovieBloc!.add(SearchTermChangedEvent(value));
                      }
                    },
                    onSubmitted: (value) {
                      //print(value);
                      //_searchMovieBloc!.add(SearchTermChangedEvent(value));
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: BlocBuilder<SearchMovieBloc, SearchMovieState>(
                      //bloc: _searchMovieBloc!,
                      builder: (context, state) {
                        if (state is SearchMovieLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is SearchMovieError) {
                          return Container(
                            height: 250.0,
                            child: Center(
                              child: AppErrorWidget(
                                errorType: state.errorType,
                                onPressed: () {
                                  //_searchMovieBloc!.add(SearchTermChangedEvent());
                                },
                              ),
                              // child: Text('Error'),
                            ),
                          );
                        } else if (state is SearchMovieLoaded) {
                          final movies = state.movies;
                          if (movies.isEmpty) {
                            return Center(
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 64.0.w),
                                child: Text(
                                  'No movies',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                          return SearchedItemWidget(movies: movies);
                        } else {
                          return Center(
                            child: SizedBox.shrink(),
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
