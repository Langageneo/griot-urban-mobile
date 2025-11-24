import 'package:flutter_js/flutter_js.dart';
import 'package:audioplayers/audioplayers.dart';

class IvoirianBeat {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static JavascriptRuntime? _jsRuntime;

  // Initialise Tone.js pour générer le beat
  static Future<void> initialize() async {
    _jsRuntime = getJavascriptRuntime();
    await _jsRuntime!.evaluate('''
      // Charge Tone.js (version légère)
      const Tone = (await import('https://cdn.jsdelivr.net/npm/tone@14.7.77/+esm'));

      // Crée les instruments
      const kick = new Tone.MembraneSynth({pitchDecay: 0.05, octaves: 2}).toDestination();
      const snare = new Tone.NoiseSynth({noise: {type: 'pink'}, envelope: {attack: 0.001, decay: 0.2}}).toDestination();
      const djembe = new Tone.MembraneSynth({
        pitchDecay: 0.1,
        octaves: 1.5,
        envelope: {attack: 0.001, decay: 0.4}
      }).toDestination();
      const hiHat = new Tone.NoiseSynth({noise: {type: 'white'}, envelope: {attack: 0.001, decay: 0.05}}).toDestination();

      // Pattern coupé-décalé (inspiré du flow ivoirien)
      const pattern = [
        {time: '0:0:0', drum: 'kick', note: 'C2'},    // Kick lourd
        {time: '0:0:2', drum: 'djembe', note: 'D3'},  // Djembé mandingue
        {time: '0:1:0', drum: 'snare'},               // Snare sec
        {time: '0:1:2', drum: 'djembe', note: 'E3'},  // Djembé variation
        {time: '0:2:0', drum: 'kick', note: 'C2'},
        {time: '0:2:2', drum: 'hiHat'},               // Hi-hat rapide
        {time: '0:3:0', drum: 'snare'},
        {time: '0:3:2', drum: 'djembe', note: 'F3'},
      ];

      // Fonction pour jouer le beat
      window.playIvoirianBeat = function() {
        const now = Tone.now();
        pattern.forEach((step) => {
          const [bars, beats, sixteenths] = step.time.split(':').map(Number);
          const time = now + (bars * 4 + beats + sixteenths * 0.25);
          if (step.drum === 'kick') kick.triggerAttackRelease(step.note || 'C2', '8n', time);
          else if (step.drum === 'snare') snare.triggerAttackRelease(time);
          else if (step.drum === 'djembe') djembe.triggerAttackRelease(step.note, '8n', time);
          else if (step.drum === 'hiHat') hiHat.triggerAttackRelease('16n', time);
        });
        Tone.Transport.start();
        Tone.Transport.scheduleOnce(() => Tone.Transport.stop(), '4n'); // 5 sec
      };
    ''');
  }

  // Joue le beat ivoirien (5 sec)
  static Future<void> play() async {
    if (_jsRuntime == null) await initialize();
    await _jsRuntime!.evaluate('window.playIvoirianBeat()');
  }

  // Arrête le beat
  static Future<void> stop() async {
    if (_jsRuntime != null) {
      await _jsRuntime!.evaluate('Tone.Transport.stop()');
    }
  }
}
