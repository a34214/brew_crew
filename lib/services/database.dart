import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/custom_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewColloection =
      FirebaseFirestore.instance.collection('brews');

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Brew(
        name: data['name'] ?? '',
        sugars: data['sugars'] ?? '0',
        strength: data['strength'] ?? 0,
      );
    }).toList();
  }

  // user data from snapshot
  UserData? _userDataFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>?;
    if (uid == null) {
      return null;
    }
    if (data != null) {
      return UserData(
        uid: uid!,
        name: data['name'] ?? 'new_crew_member',
        sugars: data['sugars'] ?? '0',
        strength: data['strength'] ?? 100,
      );
    }
    return null;
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewColloection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData?> get userData {
    return brewColloection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future<void> createUserData(
      String? name, String? sugars, int? strength) async {
    return await brewColloection
        .doc(uid)
        .set({'name': name, 'sugars': sugars, 'strength': strength});
  }

  Future<void> updateUserData(String name, String sugars, int strength) async {
    return await brewColloection
        .doc(uid)
        .update({'name': name, 'sugars': sugars, 'strength': strength});
  }
}
