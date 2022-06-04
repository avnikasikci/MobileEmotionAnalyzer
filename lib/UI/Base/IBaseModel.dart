abstract class IBaseModel<T> {
  Map<String, dynamic>? toJson();
  fromJson(Map<String, dynamic> json);
}
