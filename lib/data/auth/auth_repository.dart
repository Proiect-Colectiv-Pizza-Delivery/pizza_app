import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizza_app/data/domain/user.dart';
import 'package:pizza_app/data/repository/secure_local_storage/secure_local_storage.dart';
import 'package:pizza_app/data/service/auth_service.dart';


class AuthRepository {
  final SecureLocalStorage _secureLocalStorage;
  final AuthService _authService;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthRepository(this._secureLocalStorage, this._authService);

  Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  void sendAccountInfo(GoogleSignInAccount account){
    if(_googleSignIn.currentUser != null) _authService.sendAccountInformation(_googleSignIn.currentUser!);
  }
}
