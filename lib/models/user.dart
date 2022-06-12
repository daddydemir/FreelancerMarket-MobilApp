
class User{
  late int? id;
  late String name;
  late String surname;
  late String username;
  late String email;
  late String image;
  late String appellation;

  
  User.empyt();
  User.forComments(this.id,this.username,this.image);

  User.forLocalDb(this.name, this.surname, this.username, this.email,);
  User.forLocalDbWithId(this.id, this.name, this.surname, this.username, this.email);
 
 User.forCommentsFromJson(Map jsn){
   id = int.tryParse(jsn["id"].toString());
   username = jsn["userName"];
   image = jsn["imagePath"];
 }

 User.forFreelancerFromJson(Map jsn){
   id = jsn["id"];
   username = jsn["userName"];
   image = jsn["imagePath"];
   appellation = jsn["appellation"] ?? "-";
 }
  
}