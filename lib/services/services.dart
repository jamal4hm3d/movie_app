import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:spot_app/types/featured_type.dart';
import 'package:spot_app/types/movie_data.dart';
import 'package:spot_app/types/studio_type.dart';

class ApiServices {
  Future<Featured> fetchFeatured() async {
    const String query = '''query MyQuery {
  movie(limit: 6, order_by: {created_at: desc}) {
    name
    background
    slug
  }
}''';
    var payload = json.encode({"query": query});
    var headers = {
      "content-type": "application/json",
      "x-hasura-admin-secret":
          "gBqMrUqjqVg8QFPSWeVjnziIFeMqWo1yttBHPFtIMr5CXWJviNfhuK5jxek4pdxI"
    };

    final response = await http.post(
      Uri.parse("https://actual-lamprey-36.hasura.app/v1/graphql"),
      headers: headers,
      body: payload,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Featured.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("failed to get data from api");
    }
  }

  Future<MovieType> fetchScene(String slug) async {
    String query = '''query MyQuery {
  movie_by_pk(slug: "$slug") {
    background
    name
    mega_link
    description
    movie_performers {
      performer {
        image
        name
      }
    }
  }
}''';
    var payload = json.encode({"query": query});
    var headers = {
      "content-type": "application/json",
      "x-hasura-admin-secret":
          "gBqMrUqjqVg8QFPSWeVjnziIFeMqWo1yttBHPFtIMr5CXWJviNfhuK5jxek4pdxI"
    };
    final response = await http.post(
        Uri.parse("https://actual-lamprey-36.hasura.app/v1/graphql"),
        headers: headers,
        body: payload);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return MovieType.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("failed to get data from api");
    }
  }

  Future<StudioType> getStudioData() async {
    String query = ''' 
query MyQuery {
  studio {
    name
    movies {
      slug
      name
      background
      mega_link
    }
  }
}
    ''';
    var payload = json.encode({"query": query});
    var headers = {
      "content-type": "application/json"
    };
    final response = await http.post(
        Uri.parse("https://hasura.app/v1/graphql"),
        headers: headers,
        body: payload);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return StudioType.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("failed to get data from api");
    }
  }
}

final apiProvider = Provider<ApiServices>(
  (ref) => ApiServices(),
);
