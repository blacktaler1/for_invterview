part of '../data.dart';

abstract class RemoteSource {
  @protected
  final Dio client;

  RemoteSource({required this.client});

  @protected
  D Function(Json json) dataFactory<D extends JsonDto>(
    D Function(Json json) factory,
  ) {
    return (json) => factory(switch (json) {
          {"data": Json data} => data,
          _ => json,
        });
  }

  @protected
  Future<Safed<BaseException, Json>> apiGet({
    required String path,
    required RemoteRequest request,
  }) async {
    return apiFetch(
      path: path,
      method: 'GET',
      request: request,
    );
  }

  @protected
  Future<Safed<BaseException, Json>> apiPost({
    required String path,
    required RemoteRequest request,
  }) async {
    return apiFetch(
      path: path,
      method: 'POST',
      request: request,
    );
  }

  @protected
  Future<Safed<BaseException, Json>> apiPatch({
    required String path,
    required RemoteRequest request,
  }) async {
    return apiFetch(
      path: path,
      method: 'PATCH',
      request: request,
    );
  }

  @protected
  Future<Safed<BaseException, Json>> apiPut({
    required String path,
    required RemoteRequest request,
  }) async {
    return apiFetch(
      path: path,
      method: 'PUT',
      request: request,
    );
  }

  @protected
  Future<Safed<BaseException, Json>> apiDelete({
    required String path,
    required RemoteRequest request,
  }) async {
    return apiFetch(
      path: path,
      method: 'DELETE',
      request: request,
    );
  }

  @protected
  Future<Safed<BaseException, Json>> apiFetch({
    required String path,
    required String method,
    required RemoteRequest request,
  }) async {
    try {
      final computedPath = request.path().entries.fold(
            path,
            (computed, entry) => computed.replaceAll(
              '{${entry.key}}',
              entry.value,
            ),
          );

      final response = await client.fetch<Json>(
        Options(
          method: method,
          responseType: ResponseType.json,
        ).compose(
          client.options,
          computedPath,
          queryParameters: request.query(),
          data: method.toLowerCase() == "get" ? null : request.data(),
        ),
      );

      if (response.data case Json json) return Success(json);

      return Failure(
        NetworkException(
          title: "Invalid response",
          description: "The response is not a valid JSON object"
              ":\n${response.data}",
          code: response.statusCode ?? 0,
          origin: response.data,
          stackTrace: StackTrace.current,
        ),
      );
    } on DioException catch (e) {
      // TODO: handle all possible errors/exceptions types
      return Failure(
        NetworkException(
          title: "Network error",
          description: e.message,
          code: e.response?.statusCode ?? 0,
          origin: e,
          stackTrace: e.stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return Failure(
        NetworkException(
          title: "Unknown error",
          description: e.toString(),
          code: 0,
          origin: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
