import '../../../constant/service_path.dart';
import 'api_base_service.dart';

class VoteeService extends ApiBaseService {
  factory VoteeService() => _instance ??= VoteeService._();

  VoteeService._() : super(WordleServicePath.voteeServicePath);

  static VoteeService? _instance;
}
