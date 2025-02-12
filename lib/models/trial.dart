
import 'package:json_annotation/json_annotation.dart';
part 'trial.g.dart';

@JsonSerializable()
class Trial {
  final int id;
  final String name;


  Trial({required this.id, required this.name});
  
}