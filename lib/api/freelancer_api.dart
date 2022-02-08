import 'package:http/http.dart' as http;
class FreelancerApi {
  
  static Future getFreelancerById(int index) async {
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/freelancers/getById?id="+ index.toString());
    return await http.get(url);
  }
  
}