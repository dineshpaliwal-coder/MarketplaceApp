import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MarketplaceFirebaseUser {
  MarketplaceFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

MarketplaceFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MarketplaceFirebaseUser> marketplaceFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<MarketplaceFirebaseUser>(
        (user) => currentUser = MarketplaceFirebaseUser(user));
