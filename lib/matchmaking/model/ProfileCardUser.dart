import 'package:Okuna/matchmaking/model/User.dart' as firebase;
import 'package:Okuna/models/user.dart';

class ProfileCardUser {
  User extendedInformation;
  firebase.User basicInformation;

  ProfileCardUser({this.basicInformation, this.extendedInformation});
}