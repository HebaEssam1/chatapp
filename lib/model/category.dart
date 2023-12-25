class Category{
  static const String sportsId='sports';
  static const String moviesId='movies';
  static const String musicId='music';
  String id;
  late String title;
  late String image;
  Category({required this.id,required this.title,
  required this.image});

  Category.from(this.id){
    if(id==sportsId){
      title='Sports';
      image='assets/images/sports.png';
    }
    else if(id==moviesId){
      title='Movies';
      image='assets/images/movies.png';
    }
    else{
      title='Music';
      image='assets/images/music.png';
    }
  }
  static List<Category> getCategories(){
    return [
      Category.from(sportsId),
      Category.from(moviesId),
      Category.from(musicId),
    ];
  }
}
