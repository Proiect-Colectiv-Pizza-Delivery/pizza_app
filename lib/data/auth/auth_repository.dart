import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizza_app/common/remote/auth_service.dart';
import 'package:pizza_app/data/domain/user.dart';
import 'package:pizza_app/data/repository/secure_local_storage/secure_local_storage.dart';


class AuthRepository {
  final SecureLocalStorage _secureLocalStorage;
  final AuthService _authService;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthRepository(this._secureLocalStorage, this._authService);

  Future<GoogleSignInAccount?> loginGoogle() => _googleSignIn.signIn();

  Future<User?> login(String username, String password) => _authService.logIn(username, password);

  void sendAccountInfo(GoogleSignInAccount account){
    // if(_googleSignIn.currentUser != null) _authService.sendAccountInformation(_googleSignIn.currentUser!);
  }

  Future<void> registerUser(User user){
    return _authService.signUp(user);
  }
}
