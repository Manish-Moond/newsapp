import 'dart:convert';
import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future<dynamic> createAccount(String email, String password) async {
    Map data = {'email': email, 'password': password};

    if (Platform.isWindows) {
      try {
        var res = await http.post(Uri.parse("https://reqres.in/api/register"),
            body: data);
        print("account crreated for windows");
        // saving to the local
        final SharedPreferences sp = await SharedPreferences.getInstance();
        var user = UserModel.fromJson({
          'token': Res.fromJson(jsonDecode(res.body)).token,
          'email': email,
          'username': 'Desktop User'
        });
        sp.setString("User", jsonEncode(user.toJson()));
        sp.setBool("isLoggedin", true);
        return res;
      } catch (e) {
        print("Account creation failed");
      }
    } else {
      try {
        FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        final UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        final SharedPreferences sp = await SharedPreferences.getInstance();

        sp.setBool("isLoggedin", true);
        var user = UserModel.fromJson({
          'token': userCredential.user!.uid,
          'email': userCredential.user!.email,
          'username': "Mobile User"
        });
        sp.setString("User", jsonEncode(user.toJson()));
        print("Account created");
      } catch (e) {
        print("Creating account failed");
      }
    }
  }

  Future<dynamic> login(String email, String password) async {
    Map data = {'email': email, 'password': password};
    if (Platform.isWindows) {
      try {
        var res = await http.post(Uri.parse("https://reqres.in/api/login"),
            body: data);
        print("Login success");
        final SharedPreferences sp = await SharedPreferences.getInstance();
        var user = UserModel.fromJson({
          'token': Res.fromJson(jsonDecode(res.body)).token,
          'email': email,
          'username': 'Desktop User'
        });
        sp.setString("User", jsonEncode(user.toJson()));
        sp.setBool("isLoggedin", true);
      } catch (e) {
        print("Login failed");
      }
    } else {
      try {
        FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        final UserCredential userCredential = await firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);
        // save user to local
        final SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setBool("isLoggedin", true);
        var user = UserModel.fromJson({
          'token': userCredential.user!.uid,
          'email': userCredential.user!.email,
          'username': "Mobile User"
        });
        sp.setString("User", jsonEncode(user.toJson()));
      } catch (e) {
        print("Login failed$e");
      }
    }
  }

  Future<void> logout() async {
    // remove user detilas from shared pre
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("User");
    sp.setBool("isLoggedin", false);
    if (!Platform.isWindows) {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      firebaseAuth.signOut();

      // logout from firebase
    }
  }

  Future<dynamic> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    print(googleSignInAccount);
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        // Save user to local
        final SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setBool("isLoggedin", true);
        var user = UserModel.fromJson({
          'token': userCredential.user!.uid,
          'email': userCredential.user!.email,
          'username': "Mobile User"
        });
        sp.setString("User", jsonEncode(user.toJson()));
        return true;
      } catch (e) {
        print(e.toString());
      }
    }
  }
}

class Res {
  int? id;
  String? token;

  Res({this.id, this.token});

  Res.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['token'] = token;
    return data;
  }
}
