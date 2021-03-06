class ApiConstants {
  ApiConstants._();

  static const String BASE_URL = "http://10.50.164.56";
  static const String BASE_SOURCE_URL =
      "http://10.50.164.56:8080/wavie-backend/public";

  static const String GET10 = "/api/get10";
  static const String GETPOPULAR = "/api/popular";
  static const String GET_MOVIE_TODAY = "/api/movie_today";

  static const String GET_MOVIE_DETAIL = "/api/movie/";
  static const String SEARCH_MOVIE = "/api/search/";
  static const String GET_MOVIE_COMMENTS = "/api/movie/comments/";

  static const String SIGN_IN = "/api/signin/";
  static const String SIGN_UP = "/api/signup";
  static const String SIGN_OUT = "/api/signout";
  static const String REFRESH_TOKEN = "/api/refreshtoken";
  static const String UPDATE_USER = "/api/save_user_data";

  static const String DELETE_COMMENT = "/api/movie/comments/delete";
  static const String CREATE_COMMENT = "/api/movie/comments/create";
}
