import 'package:amuzic/core/theme/app_theme.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

Widget miniSeekBar(BuildContext ctx) {
  final lTheme = DynamicTheme.of(ctx)!.themeId == 0 ? true : false;

  return player.builderRealtimePlayingInfos(builder: (ctx, infos) {
    Duration currentPosition = infos.currentPosition;
    Duration totalDuration = infos.duration;
    return SizedBox(
      // margin: EdgeInsets.only(
      //   left: MediaQuery.of(ctx).size.height / 8,
      // ),
      child: ProgressBar(
        onSeek: (to) {
          player.seek(to);
        },
        progressBarColor: lTheme ? MyTheme.blueDark : MyTheme.light,
        barCapShape: BarCapShape.square,
        thumbRadius: 1,
        timeLabelLocation: TimeLabelLocation.none,
        barHeight: 3,
        baseBarColor: lTheme ? Colors.grey.shade400 : MyTheme.d_light,
        progress: currentPosition,
        total: totalDuration,
      ),
    );
  });
}

Widget mainSeekBar(BuildContext ctx) {
  final lTheme = DynamicTheme.of(ctx)!.themeId == 0 ? true : false;

  return player.builderRealtimePlayingInfos(builder: (ctx, infos) {
    Duration currentPosition = infos.currentPosition;
    Duration totalTime = infos.duration;
    return ProgressBar(
      timeLabelLocation: TimeLabelLocation.sides,
      barHeight: 5,
      thumbColor: Colors.red.shade400,
      baseBarColor: lTheme ? Colors.grey.shade500 : Colors.grey.shade400,
      progressBarColor: lTheme ? MyTheme.blueDark : MyTheme.d_blueDark,
      // barCapShape: BarCapShape.square,
      progress: currentPosition,
      total: totalTime,
      onSeek: ((to) {
        player.seek(to);
      }),
    );
  });
}
