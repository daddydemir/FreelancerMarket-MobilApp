// ignore_for_file: non_constant_identifier_names

/*
* Advert list
* Advert create 
* Advert delete
*/

class Advert{
  late int id;
  late int freelancer_id;
  late int sub_category_id;
  late String title;
  late double price;
  late String info;
  late String image_path;
  late DateTime date;

  Advert(this.id, this.freelancer_id, this.sub_category_id, this.title, this.price, this.info, this.image_path ,this.date);

  // json ile gelen verileri parse edip advert create ermek icin kullanılacak
  Advert.fromJson(Map json){
    id = json["id"];
    freelancer_id = json["freelancerId"];
    sub_category_id = json["subCategoryId"];
    title = json["title"];
    info = json["info"];
    image_path = json["imagePath"];
    date = json["date"];
  }

  // sanırım json veri upload edilirken kullanılacak olabilir ? 
  Map toJson(){
    return{
      "id":id,
      "freelancerId":freelancer_id,
      "subCategoryId":sub_category_id,
      "title":title,
      "info":info,
      "imagePath":image_path,
      "date":date
    };
  }
}