// ignore_for_file: non_constant_identifier_names

/*
* kategori list
* kategori getById
*/

class SubCategory{
  late int id;
  late int top_category_id;
  late String name;
  late String image;

  SubCategory(this.id, this.top_category_id, this.name, this.image);

// get 
  SubCategory.fromJson(Map json){
    id = json["id"];
    top_category_id = json["topCategoryId"];
    name = json["name"];
    image = json["imagePath"]?? "https://raw.githubusercontent.com/daddydemir/images/main/freelancer-market/PNG-4x/acik-zemin%404x.png";
  }

// post 
  Map toJson(){
    return {
      "id":id, 
      "topCategoryId":top_category_id, 
      "name":name,
      "image":image
      };
  }
  
}