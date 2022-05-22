import 'package:equatable/equatable.dart';

class Sys extends Equatable{
  String? pod;

  Sys({this.pod});

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json['pod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pod'] = this.pod;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [pod];
}
