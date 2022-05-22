import 'package:equatable/equatable.dart';

class Rain  extends Equatable{
  num? d3h;

  Rain({this.d3h});

  Rain.fromJson(Map<String, dynamic> json) {
    d3h = json['3h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['3h'] = this.d3h;
    return data;
  }

  @override
  List<Object?> get props => [d3h];
}
