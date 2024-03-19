class Model{
  String _id="";
  String _name="";
  String _image="";

  String get name => _name;
  String get image => _image;
  String get id => _id;

  set id(String id){
    _id = id;
  }

  set name(String name){
    _name = name;
  }

  set image(String image){
    _image = image;
  }

  Map<String,dynamic> toMap(){
    return {
      'name':this._name,
      'image':this._image
    };
  }
}