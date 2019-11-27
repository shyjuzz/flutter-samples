import 'package:flutter/material.dart';
import 'package:gkcash/pages/homepage.dart';

class HomePageSlider extends StatefulWidget {
  @override
  _HomePageSliderState createState() => _HomePageSliderState();
}

class _HomePageSliderState extends State<HomePageSlider>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    animationController =
        new AnimationController(duration: Duration(seconds: 10), vsync: this);
    animation =
        IntTween(begin: 0, end: photos.length - 1).animate(animationController)
          ..addListener(() {
            setState(() {
              photoindex = animation.value;
            });
          });
    animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  int photoindex = 0;
  List<String> photos = [
    "assets/images/flutter1.png",
    "assets/images/Logomark.png",
  ];

  void _previousImage() {
    setState(() {
      photoindex = photoindex > 0 ? photoindex - 1 : 0;
    });
  }

  void _nextImage() {
    setState(() {
      photoindex = photoindex < photos.length - 1 ? photoindex + 1 : photoindex;
    });
  }

  @override
  Widget build(BuildContext context) {

    var listChildren = new List<Widget>();
    listChildren.add(Stack(
      children: <Widget>[
        Container(
          height: 210.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(photos[photoindex]),
                  fit: BoxFit.scaleDown)),
        ),
        Positioned(
          top: 180.0,
          left: 5.0,
          child: Row(
            children: <Widget>[
              SizedBox(width: 2.0),
              Text(
                '4.0',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4.0),
              SelectedPhoto(
                  photoIndex: photoindex, numberOfDots: photos.length)
            ],
          ),
        ),
      ],
    ));
    listChildren.add(CurvedListItem(
      title: 'GK Contest 1',
      time: 'TODAY 5:30 PM',
      color: Colors.red,
      nextColor: Colors.green,
    ));
    listChildren.add(CurvedListItem(
      title: 'GK Contest 2',
      time: 'TUESDAY 5:30 PM',
      color: Colors.green,
      nextColor: Colors.yellow,
    ),);
    listChildren.add(CurvedListItem(
      title: 'GK Contest 3',
      time: 'FRIDAY 6:00 PM',
      color: Colors.yellow,
    ));
    return new Scaffold(
      drawer: new Drawer(),
      appBar: AppBar(
        title: const Text('GKCash'),
      ),
//      appBar: AppBar(
//        title: Image(
//          image: AssetImage(
//            "assets/images/flutter1.png",
//          ),
//          height: 30.0,
//          fit: BoxFit.fitHeight,
//        ),
//        elevation: 0.0,
//        centerTitle: true,
//        backgroundColor: Colors.transparent,
//        leading: IconButton(
//            icon: Icon(Icons.arrow_back),
//            color: Colors.grey,
//            onPressed: () {
//              Navigator.of(context).pushReplacementNamed("/loginpage");
//            }),
//      ),
      body: ListView(
        children: listChildren
      ),
    );
  }
}

class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return new Container(
        child: new Padding(
      padding: const EdgeInsets.only(left: 3.0, right: 3.0),
      child: Container(
        height: 8.0,
        width: 8.0,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(4.0)),
      ),
    ));
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, spreadRadius: 0.0, blurRadius: 2.0)
              ]),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for (int i = 0; i < numberOfDots; ++i) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}
