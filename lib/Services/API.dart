import 'dart:convert';
import 'dart:io';
import 'package:cobed/Models/Hospital.dart';
import 'package:cobed/Models/User.dart';
import 'package:cobed/Services/SharedPreferences.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';

class API {
  Future coronaCases() async {
    try {
      final response = await http.get(Constants.coronaApiURL);
      if (response.statusCode == 200)
        return json.decode(response.body);
    } catch (e) {
      print('error:' + e.message.toString());
    }
  }

  Future<String> register({@required Hospital hospital,@required String password}) async {
    try {
      Map<String,num> coordinates = {
        "latitude": hospital.orgLocation.latitude,
        "longitude": hospital.orgLocation.longitude
      };
      final response = await http.post(
          Constants.baseURL + 'users/signup',
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "username": hospital.userName,
            "password": password,
            "name": hospital.orgName,
            "phoneNumber": hospital.orgPhoneNumber,
            "city": hospital.city,
            "coordinates": coordinates,
            "totalBeds": hospital.totalBeds,
            "coronaBeds": hospital.totalCoronaBeds,
            "totalAvailableBeds": hospital.availableBeds,
            "coronaAvailableBeds": hospital.availableCoronaBeds
          })
      );
      if (response.statusCode == 200)
        return 'done';
      final err=jsonDecode(response.body);
      if(err['err']['message'].toString() ==
          "A user with the given username is already registered")
        return 'This user name already exists';
    } catch (e) {
      print(e.message.toString());
      return 'Try again';
    }
    return 'Try again';
  }

  Future<String> login({@required String userName,@required String password}) async {
    try {
      final response = await http.post(
          Constants.baseURL + 'users/login',
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "username": userName,
            "password": password
          })
      );
      if (response.statusCode == 200)
        return response.body;
    } catch (e) {
      print('error'+e.message.toString());
    }
    return 'Unauthorized';
  }

  Future<bool> addPost({Map body, File image}) async {
    try {
      if(image != null){
        Map imgInfo = await uploadImageToDrive(image: image);
        body.addAll(imgInfo);
      }
      User user = await SharedPreferenceHandler.getUserData();
      final response = await http.post(
          Constants.baseURL + 'posts',
          headers: {
            "Authorization": 'bearer ' + user.accessToken,
            'Content-Type': 'application/json'
          },
          body: jsonEncode(body)
      );
      if (response.statusCode == 200)
        return true;
    } catch (e) {
      print(e.message.toString());
      return false;
    }
    return false;
  }

  Future<bool> editInfo({Map body,File image,String urlCompleter}) async {
    try {
      if(image != null){
        Map imgInfo = await uploadImageToDrive(image: image);
        body.addAll(imgInfo);
      }
      User user = await SharedPreferenceHandler.getUserData();
      final response = await http.put(
          Constants.baseURL + urlCompleter,
          headers: {
            "Authorization": 'bearer ' + user.accessToken,
            'Content-Type': 'application/json'
          },
          body: jsonEncode(body)
      );
      print(response.body);
      if (response.statusCode == 200)
        return true;
    } catch (e) {
      print(e.message.toString());
      return false;
    }
    return false;
  }

  Future<Map> uploadImageToDrive({File image}) async {
    Map map;
    try {
      final accountCredentials = new ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "co-bed",
        "private_key_id": "c21320bdcbe3ad4df36fa97c5d2d4531ad00d5d4",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDDdRzESnBmLqR4\nVhybND4WMj3i+AhUvPlqyVustBXG6eJcnIKNcbaPEjxfx1rF+GFASCM5rywri/U2\nNUvWq1dGBi3Zqf36yqIJsUi/DyIVfkpvhuj2IljToNMcMr70ztB+QCfNbohys1Dm\nRGan1kTfSjNOZNR9BZZU0IUXi6dCpN8S3viqvAxj0ErJ8Xqhb2Cilf4+3xZ+26Vy\nJPOjQhaEtXF4ON9ARYVogBstlLicUN7GUZrceughmbRLAZ9agfYRlF91d46wFyAM\nSuVkREJ0j2haXmx6/nbdiUaUQ135/E/lh5wB21FnW1bQC1s46phUCjn6dK4o+x8q\nQRZFUDSHAgMBAAECggEAQ2+/Jpx2TlMObPRs90GdoEPiZVJlcXMn7OefSSVzFAez\nEXfwdUPEFHXavcMG9yH8z9Rzzt249CdcScE2stC4ElFkdWJ43hQWtxhjPIRIorjJ\njtQxwWZVVmL5I5QAnW9TsROKiA74ZfanVWNJNeQwLAgqToRsadxJI2c0XEzTPyMP\nL83E0gC1Vtz1MWkmoS43pK0ml/UxDHJlh2WdYdKtzmrrj4ubtOwoh9z+zjyHobch\ncnF6thJ6ZiTf7Fxt8YWBgHa/6cKoU6xaLMl4Z1lWtgk+hbX6WKdNflmbrLZAQXK+\nJJmwxfIiKdUnLGEWRqLa1qDtEYmv8c90SILs3uoYaQKBgQD3TD1g4rW/5kb7lF9L\nR1H4X9IWWWlsKeUmt3oL1Q9F3WGJQ0GgcrcYgpKuVtUxnYRkPygjK5fchWIToop0\nsNCO/EPBqpH7siFu7uSdWcjDiRC8CX7nQGWkiDUZ+OwQfFLvBMC0FEopb4FjF+KB\noDYK/0OrIFJr6kMTX7expJuVaQKBgQDKVd+feKo+ep+SpfaKMYAG1VaEuRBqYrDm\npzQ6gs/8mPx+H4sUs/WmuS2g4chx06BRDNlgU/7/tyYBLxlNBlJioOcSTFHWMZiJ\n8ikRkZqUKSin8j2tLQmeJmY585Dle2icnOqwhhrfKKwpVTGiQ9S0trpM0Z9oowZB\nTyDLIV2MbwKBgQCgDYfsHM7k1HU8flrurcovplSiglvo1XSqCjXDUrH/1bg6zny7\nC4PVKS0mCK0S34/AEeA4Yw52ex1u99QEkitpX3u67FpvPGrHEXaFIIb/hsZ97Odl\nZBhk1IMJvEGMqepDKCBQbJFTIAftypeercJMe8mgB9tQXN3svBZ3ssG/gQKBgBMs\nI+52fptA/1HkDAJ4Qktjd7lH1/hctaqFeXt53b9vt60zy/gAPWy460vtWRMAHJbR\ngt+P1f/hGObP0bPsv229FWg0dyS2ul+H5MBXbbBQXhvb5mA8fkbQGKuxGq/EC9ub\nOtnTO0SeFAIuom9fwg4Fqo2Q52wA1pzlpJPa64RdAoGBAJB+9zJO11IoinBa/rxx\nra/hiuAh98WTnPefEWthzucIUx0V7BnIfhBW7kczflo4Xa3O3KUsIykmbC5CTI/I\ntwUTLWgbm8KKM5I/HPLyF3FWw5ZzEex90kAzyDWvMbGJYma+uDrKvhkSmzxqALqQ\nOK3eC/vmYwzs5F2CyvXZT7bZ\n-----END PRIVATE KEY-----\n",
        "client_email": "co-bed@co-bed.iam.gserviceaccount.com",
        "client_id": "110000913276989050319",
      });
      AuthClient client = await clientViaServiceAccount(
          accountCredentials,
          ['https://www.googleapis.com/auth/drive']);

      String imageName = path.basename(image.path);
      var driveApi = drive.DriveApi(client);
      var fileToUpload = image;
      var driveFile = new drive.File();
      driveFile.name = imageName;
      driveFile.parents = ["1R-d0IsG-SLM99rN5kHaD2-K4wHaCM2BJ"];

      var response = await driveApi.files.create(driveFile,
          uploadMedia: drive.Media(fileToUpload.openRead(), fileToUpload.lengthSync())
      );

      print(response.id + '--' + response.mimeType);
      Map imgMap = {
        'id':response.id,
        'mimetype':response.mimeType
      };
      map = {'image': imgMap};
      return map;
    } catch (error) {
      print(error.toString());
    }
    return map;
  }

  Future getAllOrganizations({@required String city}) async {
    try {
      var params = {"city": city};
      Uri uri = Uri.parse(Constants.baseURL + 'search');
      final newURI = uri.replace(queryParameters: params);
      var response = await http.get(newURI);
      print(response.statusCode);
      if (response.statusCode == 200)
        return jsonDecode(response.body);
      else
        return false;
    } catch (e) {
      print(e.message.toString());
    }
  }

  Future getOrganizationInfo({@required String id}) async {
    try {
      final response = await http.get(
          Constants.baseURL + 'search/' + id);
      print(response.statusCode);
      if (response.statusCode == 200)
        return jsonDecode(response.body);
    } catch (e) {
      print(e.message.toString());
      return false;
    }
    return false;
  }

  Future<bool> deletePost({@required String id}) async {
    try {
      User user = await SharedPreferenceHandler.getUserData();
      final response = await http.delete(
        Constants.baseURL + 'posts/' + id,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'bearer ' + user.accessToken
        },
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200)
        return true;
    } catch (e) {
      print(e.message.toString());
      return false;
    }
    return false;
  }
}