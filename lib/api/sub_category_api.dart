import 'package:freelancer_market/models/top_category.dart';
import 'package:http/http.dart' as http;
class SubCategoryApi{

  static Future getAllCategories() async {
    var url = Uri.parse("http://freelancermarket-backend.herokuapp.com/api/subCategories/getAll");
    return await http.get(url);
  }

  static Future getByTopCategoryId(TopCategory top_category) async {
    var url = Uri.parse("http://freelancermarket-backend.herokuapp.com/api/subCategories/getByTopCategoryId?id="+top_category.id.toString());
    return await http.get(url);
  }
}