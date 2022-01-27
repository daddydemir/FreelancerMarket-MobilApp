class TopCategory{
  late int id;
  late String name;

  TopCategory(this.id, this.name);

// get 
  TopCategory.fromJson(Map json){
    id = json["id"];
    name = json["name"];
  }

// post 
  Map toJson(){
    return {"id":id, "name":name};
  }
  
}