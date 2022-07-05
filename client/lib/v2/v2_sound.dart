import 'package:soundpool/soundpool.dart';

class V2Sound {
  static final pool = Soundpool.fromOptions(options: SoundpoolOptions.kDefault);
  static late int soundId1;

  static playNotif()async{
    await pool.play(soundId1);
  }

  static init() async {
    soundId1 = await pool.loadUri("https://cdn.freesound.org/previews/350/350876_5450487-lq.mp3");
    
  }
}
