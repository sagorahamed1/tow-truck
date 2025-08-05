import 'dart:io';

import '../services/api_client.dart';

class UploadAppFile {
 static uploadFile({required File file}) async {
    List<MultipartBody> files = [MultipartBody("file", file)];

    var response =
        await ApiClient.postMultipartData("/upload", {}, multipartBody: files);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body["data"]["path"];
    } else {
      return "";
    }
  }
}
