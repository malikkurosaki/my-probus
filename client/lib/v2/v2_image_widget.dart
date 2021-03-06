import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_probus/config.dart';
import 'package:my_probus/v2/v2_config.dart';

class V2ImageWidget {
  static Widget androidDownload({double? height, double? width}) =>
      CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/android_download.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget chatBgV2({double? height, double? width}) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/chat-bg-v2.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget chatBg({double? height, double? width}) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/chat-bg.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget contribution({double? height, double? width}) =>
      CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/contribution.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget dashboard({double? height, double? width}) =>
      CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/dashboard.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget form({double? height, double? width}) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/form.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget jempol({double? height, double? width}) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/jempol.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget kecewa({double? height, double? width}) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/kecewa.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget kosong({double? height, double? width}) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/kosong.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget login({double? height, double? width}) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/login.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget logo({double? height, double? width}) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/logo.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget logout({double? height, double? width}) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/logout.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget mts({double? height, double? width}) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/mts.jpg",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget noImage({double? height, double? width}) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/no-image.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget noimage({double? height, double? width}) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/noimage.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget petunjuk({double? height, double? width}) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/petunjuk.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget profile({double? height, double? width}) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/profile.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget tos({double? height, double? width}) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "${Config.host}/images/tos.png",
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );
}
