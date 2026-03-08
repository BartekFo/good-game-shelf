class RawgEndpoints {
  const RawgEndpoints._();

  static const String games = '/games';

  static String gameDetails(String id) => '/games/$id';
}
