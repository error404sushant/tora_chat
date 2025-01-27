import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tora_chat/model/api_error_response_message.dart';
import 'package:tora_chat/util/app_constants/app_constants.dart';
import 'package:tora_chat/util/app_constants/app_strings.dart';

class ApiCallService {
  final Dio _dio = Dio(BaseOptions(
    contentType: "application/json",
    connectTimeout: Duration(seconds: 10), // 10 seconds
  ));

  //region Api exception handle
  Future<String> apiExceptionHandle({
    required Response response,
    required Map<String, dynamic> body,
  }) async {
    // Check if response body is empty
    if (response.data == null || response.data.toString().isEmpty) {
      return AppStrings.commonErrorMessage;
    }

    // Handle specific status codes (400, 403, 404, 500)
    else if (response.statusCode == 400 ||
        response.statusCode == 403 ||
        response.statusCode == 404 ||
        response.statusCode == 500) {
      // If body contains is_custom and is_custom is true, return custom message
      if (body['is_custom'] != null && body['is_custom'] == true) {
        return body['message'];
      } else {
        return AppStrings.commonErrorMessage;
      }
    }

    // Return default error message for other cases
    return AppStrings.commonErrorMessage;
  }

  // endregion

  ///With header
  //region Get Api Call with header
  Future<Map<String, dynamic>> getApiCall(String apiUrl) async {
    Map<String, dynamic> jsonResponse = {};

    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppConstants.accessToken}',
      };

      debugPrint(apiUrl);
      // Execute Dio GET request with headers
      final response = await _dio.get(
        apiUrl,
        options: Options(headers: headers),
      );

      debugPrint(apiUrl);

      // Decode response data
      jsonResponse = response.data is Map
          ? Map<String, dynamic>.from(response.data)
          : json.decode(response.data.toString());

      // Check for non-200 status codes and throw exception if necessary
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiErrorResponseMessage(
          message:
              await apiExceptionHandle(response: response, body: jsonResponse),
        );
      }
    } on DioException catch (dioError) {
      debugPrint(dioError.message);
      // Handle Dio-specific errors
      if (dioError.error is SocketException) {
        throw ApiErrorResponseMessage(message: AppStrings.noInternet);
      } else if (dioError.response != null) {
        throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
      } else {
        throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
      }
    } catch (e) {
      throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
    }

    return jsonResponse;
  }

//endregion

  //region Post Api call
  Future<Map<String, dynamic>> postApiCall({
    required Map<String, dynamic> param,
    required String apiUrl,
  }) async {
    Map<String, dynamic> jsonResponse = {};

    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppConstants.accessToken}',
      };

      debugPrint(apiUrl);
      debugPrint(param.toString());

      // Execute Dio POST request
      final response = await _dio.post(apiUrl,
          data: json.encode(param), options: Options(headers: headers));

      // Decode response data
      jsonResponse = response.data is Map
          ? Map<String, dynamic>.from(response.data)
          : json.decode(response.data.toString());

      // Check for non-200 status codes and throw exception if necessary
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiErrorResponseMessage(
          message:
              await apiExceptionHandle(response: response, body: jsonResponse),
        );
      }
    } on DioException catch (dioError) {
      debugPrint(dioError.message);
      // Handle Dio-specific errors
      if (dioError.error is SocketException) {
        throw ApiErrorResponseMessage(message: AppStrings.noInternet);
      } else if (dioError.response != null) {
        throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
      } else {
        throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
      }
    } catch (e) {
      throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
    }

    return jsonResponse;
  }

//endregion

  //region Delete Api call
  Future<Map<String, dynamic>> deleteApiCall({
    required String apiUrl,
  }) async {
    Map<String, dynamic> jsonResponse = {};

    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppConstants.accessToken}',
      };

      debugPrint(apiUrl);

      // Execute Dio DELETE request
      final response = await _dio.delete(
        apiUrl,
        options: Options(headers: headers),
      );

      // Decode response data
      jsonResponse = response.data is Map
          ? Map<String, dynamic>.from(response.data)
          : json.decode(response.data.toString());

      // Check for non-200 status codes and throw exception if necessary
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiErrorResponseMessage(
          message:
              await apiExceptionHandle(response: response, body: jsonResponse),
        );
      }
    } on DioException catch (dioError) {
      debugPrint(dioError.message);
      // Handle Dio-specific errors
      if (dioError.error is SocketException) {
        throw ApiErrorResponseMessage(message: AppStrings.noInternet);
      } else if (dioError.response != null) {
        throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
      } else {
        throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
      }
    } catch (e) {
      throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
    }

    return jsonResponse;
  }

//endregion

  ///Without header

  //region Get Api Call without header
  Future<Map<String, dynamic>> getApiCallWithoutHeader(
    String apiUrl,
  ) async {
    Map<String, dynamic> jsonResponse = {};

    try {
      // Execute Dio GET request
      final response = await _dio.get(apiUrl);

      debugPrint(apiUrl);
      // Decode response data
      jsonResponse = response.data is Map
          ? Map<String, dynamic>.from(response.data)
          : json.decode(response.data.toString());

      // Check for non-200 status codes and throw exception if necessary
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiErrorResponseMessage(
          message:
              await apiExceptionHandle(response: response, body: jsonResponse),
        );
      }
    } on DioException catch (dioError) {
      debugPrint(dioError.message);
      // Handle Dio-specific errors
      if (dioError.error is SocketException) {
        throw ApiErrorResponseMessage(message: AppStrings.noInternet);
      } else if (dioError.response != null) {
        throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
      } else {
        throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
      }
    } catch (e) {
      throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
    }

    return jsonResponse;
  }

//endregion

  //region Post Api Call without header
  Future<Map<String, dynamic>> postApiCallWithoutHeader(
    Map<String, dynamic> param,
    String apiUrl,
  ) async {
    Map<String, dynamic> jsonResponse = {};

    try {
      // Execute Dio POST request
      final response = await _dio.post(apiUrl, data: json.encode(param));

      debugPrint(apiUrl);
      debugPrint(param.toString());
      // Decode response data
      jsonResponse = response.data is Map
          ? Map<String, dynamic>.from(response.data)
          : json.decode(response.data.toString());

      // Check for non-200 status codes and throw exception if necessary
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiErrorResponseMessage(
          message:
              await apiExceptionHandle(response: response, body: jsonResponse),
        );
      }
    } on DioException catch (dioError) {
      debugPrint(dioError.message);
      // Handle Dio-specific errors
      if (dioError.error is SocketException) {
        throw ApiErrorResponseMessage(message: AppStrings.noInternet);
      } else if (dioError.response != null) {
        throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
      } else {
        throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
      }
    } catch (e) {
      throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
    }

    return jsonResponse;
  }

//endregion

  //region Put api with form
  Future<Map<String, dynamic>> putApiWithForm({
    required String apiUrl,
    required Map<String, dynamic> formData,
    File? icon, // Optional image file
  }) async {
    Map<String, dynamic> jsonResponse = {};

    try {
      final headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${AppConstants.accessToken}',
      };

      debugPrint(apiUrl);

      // Creating form data
      FormData data = FormData.fromMap(formData);

      // Add icon (image) if it's not null
      if (icon != null) {
        data.files
            .add(MapEntry('icon', await MultipartFile.fromFile(icon.path)));
      }

      // Execute Dio PUT request
      final response = await _dio.put(
        apiUrl,
        data: data,
        options: Options(headers: headers),
      );

      // Decode response data
      jsonResponse = response.data is Map
          ? Map<String, dynamic>.from(response.data)
          : json.decode(response.data.toString());

      // Check for non-200 status codes and throw exception if necessary
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiErrorResponseMessage(
          message:
              await apiExceptionHandle(response: response, body: jsonResponse),
        );
      }
    } on DioException catch (dioError) {
      debugPrint(dioError.message);
      if (dioError.error is SocketException) {
        throw ApiErrorResponseMessage(message: AppStrings.noInternet);
      } else if (dioError.response != null) {
        throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
      } else {
        throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
      }
    } catch (e) {
      throw ApiErrorResponseMessage(message: AppStrings.commonErrorMessage);
    }

    return jsonResponse;
  }
//endregion
}
