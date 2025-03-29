import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../../constants/endpoints.dart';

class ApiClient {
  late http.Client httpClient;

  final retryClient = RetryClient(http.Client());
  final dio = Dio();

  retry() async {
    final client = RetryClient(http.Client());
    try {
      print(await client.read(Uri.http('example.org', '')));
    } finally {
      client.close();
    }
  }

  // request timeout value
  int timeOutValue = 50;

  get(String endpoint) async {
    var response = await dio
        .get(
      endpoint,
      options: Options(validateStatus: (_) => true),
    )
        .timeout(
      Duration(seconds: timeOutValue),
      onTimeout: () {
        return retry();
      },
    );

    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      return get(endpoint);
    } else
      print('error');
  }

  getData({
    required String endpoint,
    required Map<String, dynamic> headers,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    var response = await dio
        .get(
      EndPoint.base_url + endpoint,
      queryParameters: query,
      data: data,
      options: Options(validateStatus: (_) => true, headers: headers),
    )
        .timeout(
      Duration(seconds: timeOutValue),
      onTimeout: () {
        return retry();
      },
    );

    print("ABC " +
        " " +
        endpoint.toString() +
        " " +
        query.toString() +
        " " +
        headers.toString() +
        " " +
        response.toString());
    print("ABC D " + headers.toString());

    if (response.statusCode == 200) {
      return response.toString();
    } else if (response.statusCode == 401) {
      // var token = await refreshToken(headers: headers);
      // headers['Authorization'] = "bearer " + token;
      return getData(endpoint: endpoint, headers: headers, query: query);
    } else {
      print('error');
    }
  }

  post(
      {required String endpoint,
      required Map<String, dynamic> headers,
      Map<String, dynamic>? query,
      Object? object}) async {
    Response response;
    response = await dio
        .post(
      EndPoint.base_url + endpoint,
      options: Options(validateStatus: (_) => true, headers: headers),
      data: object,
      queryParameters: query,
    )
        .timeout(
      Duration(seconds: timeOutValue),
      onTimeout: () {
        return retry();
      },
    );

    print(response);

    if (response.statusCode == 401) {
      // headers['Authorization'] = "bearer " + token;
      return post(endpoint: endpoint, headers: headers);
    } else {
      return response.toString();
    }
  }

  postMultiform({
    required String endpoint,
    required Map<String, String> headers,
    Map<String, dynamic>? query,
    required Map<String, String> object,
    String? path,
    required String fileName,
  }) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(EndPoint.base_url + endpoint),
    );

    request.headers["Accept"] = headers["Accept"]!;
    request.headers["authorization"] = headers["Authorization"]!;
    request.headers["Cookie"] = headers["Cookie"]!;

    headers['Content-Type'] = "application/json";

    request.fields.addAll(object);

    if (path != null) {
      var mimeType = lookupMimeType(path);
      request.files.add(
        await http.MultipartFile.fromPath(
          fileName,
          path,
          contentType: MediaType.parse(mimeType!),
        ),
      );
    }

    var response = await request.send().timeout(
      Duration(seconds: timeOutValue),
      onTimeout: () {
        return retry();
      },
    );

    if (response.statusCode == 401) {
      return postMultiform(
        endpoint: endpoint,
        headers: headers,
        object: object,
        path: path,
        fileName: fileName,
      );
    } else {
      var fullResponse = await http.Response.fromStream(response);
      return fullResponse.body.toString();
    }
  }

  put(String endpoint, Object? data) async {
    var response = await dio
        .put(
      EndPoint.base_url + endpoint,
      data: data,
      options: Options(validateStatus: (_) => true),
    )
        .timeout(
      Duration(seconds: timeOutValue),
      onTimeout: () {
        return retry();
      },
    );

    if (response.statusCode == 200) {
      print(response.toString());

      return response;
    } else if (response.statusCode == 401) {
      return get(endpoint);
    } else
      print('error');
  }

  delete(String endpoint) async {
    var response = await dio
        .delete(
      endpoint,
      options: Options(validateStatus: (_) => true),
    )
        .timeout(
      Duration(seconds: timeOutValue),
      onTimeout: () {
        return retry();
      },
    );

    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 401) {
      return get(endpoint);
    } else
      print('error');
  }
}
