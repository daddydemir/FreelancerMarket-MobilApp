import 'package:http/http.dart' as http;
class TopCategoryApi{

  static Future getAllCategories() async {
    var url = Uri.parse("http://freelancermarket-backend.herokuapp.com/api/topCategories/getAll");
    return await http.get(url);
  }
}