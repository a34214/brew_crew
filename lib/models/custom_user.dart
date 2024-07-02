class CustomUser {
  final String? uid;
  CustomUser({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData(
      {required this.uid,
      this.name = 'new_crew_member',
      this.sugars = '0',
      this.strength = 100});
}
