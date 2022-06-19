import 'package:dalal_app/constants/imports.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeView extends StatefulWidget {
  const YoutubeView({Key? key}) : super(key: key);

  @override
  _YoutubeViewState createState() => _YoutubeViewState();
}

class _YoutubeViewState extends State<YoutubeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(string.appName),
        backgroundColor: myColors.colorPrimaryColor,
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder(
          stream:
          FirebaseFirestore.instance.collection('YoutubeLink').orderBy("Date",descending: true).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((document) {
                var url = document['Link'];

                YoutubePlayerController _controller = YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId(url).toString(),
                  flags: const YoutubePlayerFlags(
                    autoPlay: false,
                    mute: false,
                  ),
                );

                return Center(
                  child: Container(
                    padding: syv10,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(
                      children: <Widget>[
                        YoutubePlayer(
                          controller: _controller,
                          liveUIColor: myColors.colorPrimaryColor,
                        ),
                        Padding(
                          padding: syh20v5 + syv10,
                          // child: Text(document['Title']),
                          child: InkWell(
                            onTap: () => {launch(document['Link'])},
                            child: BoldText(
                              "Click Here => " + document['Title'],
                            ),
                            highlightColor: myColors.btnRemove,
                            focusColor: myColors.colorPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
