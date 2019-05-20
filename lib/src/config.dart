final String mdbApiKey = 'f5380bfd80422200aba8987938823dda';
final String mdbBaseAPIUrl = 'api.themoviedb.org';
final String mdbApiVersion = '3';
final String mdbImageBaseUrl = 'https://image.tmdb.org/t/p';

String getMdbImage({ int width, String src }) {
  int defaultWidth = 500;
  return '$mdbImageBaseUrl/w${width ?? defaultWidth}$src';
}