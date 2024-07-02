import 'package:brew_crew/models/brew.dart';
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

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewColloection.snapshots().map(_brewListFromSnapshot);
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
