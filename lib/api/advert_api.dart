import 'package:http/http.dart' as http;
class AdvertApi{

  static Future getAllAdverts() async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/adverts/getAll");
    return await http.get(url);
  }

  static Future getBySubCategoryId(int index) async {
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/adverts/getBySubCategoryId?subCategoryId="+ index.toString());
    return await http.get(url);
  }
}