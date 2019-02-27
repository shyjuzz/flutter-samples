import 'package:dailyquotes/uploader.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dailyquotes/fullscreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class QuotesScreen extends StatefulWidget {
  QuotesScreen({this.firestore});
  final Firestore firestore;
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['quotes', 'motivational', 'positive'],
    childDirected: true,
  );
  BannerAd _bannerAd;

  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpapersList;
  final CollectionReference collectionReference =
      Firestore.instance.collection("quotesdb");

  @override
  void initState() {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-8110850961447933~6429782373");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        wallpapersList = datasnapshot.documents;
        print('Length : ${datasnapshot.documents.length}');
      });
    });
    super.initState();
  }

  BannerAd createBannerAd() {
    return new BannerAd(
        adUnitId: 'ca-app-pub-8110850961447933/2298965672',//BannerAd.testAdUnitId,
        size: AdSize.banner,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {
          print("Banner event : $event");
        });
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
    ).createShader(Rect.fromLTWH(0.0,  0.0, 200.0, 70.0));
    return new Scaffold(
        drawer: new Drawer(
            child: new ListView(children: <Widget>[
          DrawerHeader(
            child: Text(' '),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              image: DecorationImage(
                  image: AssetImage("assets/holder.png"), fit: BoxFit.cover),
            ),
          ),
          new ListTile(
              leading: new Icon(Icons.star, color: Colors.blueGrey),
              title:
                  new Text('Rate Us', style: TextStyle(color: Colors.blueGrey)),
              onTap: () async {
                Navigator.pop(context);
                const url =
                    "https://play.google.com/store/apps/details?id=com.lifetips.dailymot";
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
                //Navigator.of(context).pushNamed('/about');
              }),
          Divider(),
          new ListTile(
              leading: new Icon(Icons.share, color: Colors.blueGrey),
              title: new Text('Share App',
                  style: TextStyle(color: Colors.blueGrey)),
              onTap: () {
                Navigator.pop(context);
                final RenderBox box = context.findRenderObject();
                Share.share(
                    'Install daily motivational quotes app now, https://play.google.com/store/apps/details?id=com.lifetips.dailymot',
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size);
                //Navigator.of(context).pushNamed('/about');
              }),

              Divider(),
          new ListTile(
              leading: new Icon(Icons.file_upload, color: Colors.blueGrey),
              title:
              new Text('Upload', style: TextStyle(color: Colors.blueGrey)),
              onTap: () async {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                        new MyHomePage(widget.firestore)));
                //Navigator.of(context).pushNamed('/about');
              }),
        ])),
        appBar: new AppBar(
          iconTheme: new IconThemeData(color: Colors.blueGrey),
          backgroundColor: Colors.white,
          title: Text("DailyMot",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = linearGradient)),
          titleSpacing: 2.0,
        ),
        body: wallpapersList != null
            ? new StaggeredGridView.countBuilder(
                padding: const EdgeInsets.all(8.0),
                crossAxisCount: 4,
                itemCount: wallpapersList.length,
                itemBuilder: (context, i) {
                  String imgPath = wallpapersList[i].data['url'];
                  return new Material(
                    elevation: 8.0,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(8.0)),
                    child: new InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new FullScreenImagePage(imgPath)));
                      },
                      child: new Hero(
                        tag: imgPath,
                        child: new FadeInImage(
                          image: new NetworkImage(imgPath),
                          fit: BoxFit.cover,
                          placeholder: new AssetImage("assets/holder.png"),
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (i) =>
                    new StaggeredTile.count(2, i.isEven ? 2 : 3),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              )
            : new Center(
                child: new CircularProgressIndicator(),
              ));
  }
}
