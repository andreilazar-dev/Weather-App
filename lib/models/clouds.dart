import 'package:equatable/equatable.dart';

class Clouds  extends Equatable{
  int? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    all
  ];
}