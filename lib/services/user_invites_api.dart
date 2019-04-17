import 'package:Openbook/services/httpie.dart';
import 'package:Openbook/services/string_template.dart';
import 'package:meta/meta.dart';

class UserInvitesApiService {
  HttpieService _httpService;
  StringTemplateService _stringTemplateService;

  String apiURL;

  static const GET_USER_INVITES_PATH = 'api/invites/';
  static const CREATE_USER_INVITE_PATH = 'api/invites/';
  static const UPDATE_USER_INVITE_PATH = 'api/invites/{userInviteId}/';
  static const DELETE_INVITE_PATH = 'api/invites/{userInviteId}/';
  static const EMAIL_INVITE_PATH = 'api/invites/{userInviteId}/email/';


  void setHttpService(HttpieService httpService) {
    _httpService = httpService;
  }

  void setStringTemplateService(StringTemplateService stringTemplateService) {
    _stringTemplateService = stringTemplateService;
  }

  void setApiURL(String newApiURL) {
    apiURL = newApiURL;
  }

  Future<HttpieStreamedResponse> createUserInvite(
      {@required String nickname}) {
    Map<String, dynamic> body = {};

    if (nickname != null) {
      body['nickname'] = nickname;
    }

    return _httpService.putMultiform(_makeApiUrl(CREATE_USER_INVITE_PATH),
        body: body, appendAuthorizationToken: true);
  }

  Future<HttpieStreamedResponse> updateUserInvite(
      {@required String nickname, @required int userInviteId}) {
    Map<String, dynamic> body = {};

    if (nickname != null) {
      body['nickname'] = nickname;
    }
    String path = _stringTemplateService.parse(UPDATE_USER_INVITE_PATH, {'userInviteId': userInviteId});
    return _httpService.patchMultiform(_makeApiUrl(path),
        body: body, appendAuthorizationToken: true);
  }

  Future<HttpieResponse> getUserInvites(
      { int offset,
        int count}) {
    Map<String, dynamic> queryParams = {};

    if (count != null) queryParams['count'] = count;
    if (offset != null) queryParams['offset'] = offset;

    return _httpService.get(_makeApiUrl(GET_USER_INVITES_PATH),
        queryParameters: queryParams,
        appendAuthorizationToken: true);
  }

  Future<HttpieResponse> deleteUserInvite(int userInviteId) {
    String path = _stringTemplateService.parse(DELETE_INVITE_PATH, {'userInviteId': userInviteId});
    return _httpService.delete(_makeApiUrl(path),
        appendAuthorizationToken: true);
  }

  Future<HttpieResponse> emailUserInvite(
      {@required int userInviteId, @required String email}) {
    String path = _stringTemplateService.parse(EMAIL_INVITE_PATH, {'userInviteId': userInviteId});
    Map<String, dynamic> body = {};

    if (email != null) {
      body['email'] = email;
    }

    return _httpService.post(_makeApiUrl(path),
        body: body,
        appendAuthorizationToken: true);
  }

  String _makeApiUrl(String string) {
    return '$apiURL$string';
  }
}
