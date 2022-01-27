
import 'package:http/http.dart' as http;
class BestFreelancersApi{

  static Future getFreelancers() async{
    var url = Uri.parse("https://freelancermarket-backend.herokuapp.com/api/freelancers/getMostPopularFreelancers");
    return await http.get(url);
  }
}