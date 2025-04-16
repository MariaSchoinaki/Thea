/// An interface that indicates each model can be constructed from JSON
/// and converted back to JSON.
abstract class BaseModel {
  Map<String, dynamic> toJson();
}
