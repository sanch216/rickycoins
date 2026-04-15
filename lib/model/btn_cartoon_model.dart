class BtnCartoonModel {
  String url;
  String image;
  BtnCartoonModel({required this.url, required this.image});

  static List<BtnCartoonModel> getListCartoonModels() {
    List<BtnCartoonModel> mainListCartoon = [];

    mainListCartoon = [
      BtnCartoonModel(
        url: 'https://www.youtube.com/@NickelodeonCyrillic',
        image: 'images/images/nickelodion_logo.jpeg',
      ),
      BtnCartoonModel(
        url: 'https://www.boomerangtv.co.uk/videos',
        image: 'images/images/boomerang_logo01.jpeg',
      ),
      BtnCartoonModel(
        url: 'https://www.cartoonnetwork.co.uk/videos',
        image: 'images/images/c_n_cartoon_image.jpeg',
      ),
      BtnCartoonModel(
        url: 'https://www.youtube.com/watch?v=JgTbF05edtM',
        image: 'images/images/fanny_cartoon_logo.jpeg',
      ),
    ];

    return mainListCartoon;
  }

}
