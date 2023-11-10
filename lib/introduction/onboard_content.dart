class ContentsOnBoard {
  final String title;
  final String image;
  final String desc;

  ContentsOnBoard(
      {required this.title, required this.image, required this.desc});
}

List<ContentsOnBoard> contents = [
  ContentsOnBoard(
      title: "Demeter Attendances",
      image: "asset/images/onboard1.png",
      desc:
          "Demeter offers the easiest of way to record your attendances with ease."),
  ContentsOnBoard(
      title: "Demeter solves it.",
      image: "asset/images/onboard2.png",
      desc: "Easily accessible across devices anywhere, and everywhere!"),
  ContentsOnBoard(
      title: "Launch to Action!",
      image: "asset/images/onboard3.png",
      desc: "So what're you waiting for? Get started now!"),
];
