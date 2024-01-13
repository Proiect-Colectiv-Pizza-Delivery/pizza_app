import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizza_app/data/domain/user.dart';
import 'package:pizza_app/data/repository/secure_local_storage/secure_local_storage.dart';


class AuthRepository {
  final SecureLocalStorage _secureLocalStorage;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthRepository(this._secureLocalStorage);

  Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}
