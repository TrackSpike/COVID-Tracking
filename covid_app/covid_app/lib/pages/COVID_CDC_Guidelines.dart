import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CovidCdcGuidelinesPage extends StatefulWidget {
  CovidCdcGuidelinesPage({Key key}) : super(key: key);

  @override
  _CovidCdcGuidelinesPageState createState() => _CovidCdcGuidelinesPageState();
}

class _CovidCdcGuidelinesPageState extends State<CovidCdcGuidelinesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CDC Guidelines'),
      ),
      body:ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  height: 50,
                  color: Colors.amber[600],
                  child: const Center(child: Text('"Wash and Sanitize your hands after touching surfaces. Wash Hands with handwash and sanitize hands with at least 60% alcohol based sanitizer"')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text(':Avoid touching your eyes, nose, and mouth with unwashed hands')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text(':Wash your hands for at least 20 seconds with soap and water or santizer. Wash hands before eating and before/after using bathroom')),
                ),
                Container(
                  height: 250,
                  color: Colors.amber[500],
                  child: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: 'GQ-zpQEPq_U', //Add videoID.
                      flags: YoutubePlayerFlags(
                        hideControls: false,
                        controlsVisibleAtStart: true,
                        autoPlay: false,
                        mute: false,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[100],
                  child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Image.asset(
                        'assets/Handwashing.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      )
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Cover Coughs and Sneezes')),
                ),
                Container(
                  height: 250,
                  color: Colors.amber[500],
                  child: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: 'dp9z3yaxkSI', //Add videoID.
                      flags: YoutubePlayerFlags(
                        hideControls: false,
                        controlsVisibleAtStart: true,
                        autoPlay: false,
                        mute: false,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[100],
                  child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Image.asset(
                        'assets/cough.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      )
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Always cover your mouth and nose with a tissue when you cough or sneeze or use the inside of your elbow and do not spit.')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Clean and Disinfect frequently touched surfaces with Chlorox. Frequently touched surfaces include Doorknobs, tables and switches')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Monitor your health daily for symptoms such as headache, fever,cough, loss of smell and taste')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Do not travel unless absolutely needed')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Avoid gatherings in big groups outside your household')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Avoid crowds and poorly ventilated spaces')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Stay six feet away from others outside your household ')),
                ),
                Container(
                  height: 250,
                  color: Colors.amber[500],
                  child: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: 'nOa8wIhQdzo', //Add videoID.
                      flags: YoutubePlayerFlags(
                        hideControls: false,
                        controlsVisibleAtStart: true,
                        autoPlay: false,
                        mute: false,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[100],
                  child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Image.asset(
                        'assets/socialdistancing.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      )
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Get vaccinated immediately when eligible, but continue taking daily precautions till our recommendations change')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Wear a mask in addition to staying six feet apart')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Everyone 2 years and older should wear masks in public.')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('If someone in your household is infected, people in the household should take precautions by wearing masks')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Wash your hands or use sanitizer before putting mask')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Wear your mask over your nose and mouth and secure it under your chin.')),
                ),
        Container(
          height: 50,
          color: Colors.amber[500],
          child: const Center(child: Text('Fit the mask snugly against the sides of your face, slipping the loops over your ears or tying the strings behind your head.')),
        ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('If you have to continually adjust your mask, it doesn’t fit properly, and you might need to find a different mask type or brand.')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Make sure you can breathe easily. Double masking is recommended in crowded places. Double masking with one cloth mask/one surgical mask is appropiate or one surgical mask/one N95 mask is appropiate')),
                ),
                Container(
                  height: 250,
                  color: Colors.amber[500],
                  child: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: 'qNzXb-GmptM', //Add videoID.
                      flags: YoutubePlayerFlags(
                        hideControls: false,
                        controlsVisibleAtStart: true,
                        autoPlay: false,
                        mute: false,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[100],
                  child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Image.asset(
                        'assets/mask.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      )
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[100],
                  child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Image.asset(
                        'assets/doublemasking.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                      )
                  ),
                ),
              ],
            )
    );
  }
}
