/*
* kategori list
* kategori getById
*/

class SubCategory{
  late int id;
  late int top_category_id;
  late String name;

  SubCategory(this.id, this.top_category_id, this.name);

// get 
  SubCategory.fromJson(Map json){
    id = json["id"];
    top_category_id = json["topCategoryId"];
    name = json["name"];
  }

// post 
  Map toJson(){
    return {
      "id":id, 
      "topCategoryId":top_category_id, 
      "name":name
      };
  }
  
}