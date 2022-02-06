import 'package:http/http.dart' as http;
class SubCategoryApi{

  static Future getAllCategories() async {
    var url = Uri.parse("http://freelancermarket-backend.herokuapp.com/api/subCategories/getAll");
    return await http.get(url);
  }

  static Future getByTopCategoryId(int topCategory) async {
    var url = Uri.parse("http://freelancermarket-backend.herokuapp.com/api/subCategories/getByTopCategoryId?id="+topCategory.toString());
    return await http.get(url);
  }
}