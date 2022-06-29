import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_probus/v2/v2_config.dart';

class V2ImageWidget {
  static Widget androidDownload({double? height}) => CachedNetworkImage(
        height: height,
        imageUrl: "${V2Config.host}/images/android_download.png",
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget contribution({double? height}) => CachedNetworkImage(
        height: height,
        imageUrl: "${V2Config.host}/images/contribution.png",
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget dashboard({double? height}) => CachedNetworkImage(
        height: height,
        imageUrl: "${V2Config.host}/images/dashboard.png",
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget form({double? height}) => CachedNetworkImage(
        height: height,
        imageUrl: "${V2Config.host}/images/form.png",
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget jempol({double? height}) => CachedNetworkImage(
        height: height,
        imageUrl: "${V2Config.host}/images/jempol.png",
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget kosong({double? height}) => CachedNetworkImage(
        height: height,
        imageUrl: "${V2Config.host}/images/kosong.png",
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget login({double? height}) => CachedNetworkImage(
        height: height,
        imageUrl: "${V2Config.host}/images/login.png",
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget logo({double? height}) => CachedNetworkImage(
        height: height,
        imageUrl: "${V2Config.host}/images/logo.png",
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget logout({double? height}) => CachedNetworkImage(
        height: height,
        imageUrl: "${V2Config.host}/images/logout.png",
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget noImage({double? height}) => CachedNetworkImage(
        height: height,
        imageUrl: "${V2Config.host}/images/no-image.png",
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget noimage({double? height}) => CachedNetworkImage(
        height: height,
        imageUrl: "${V2Config.host}/images/noimage.png",
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget petunjuk({double? height}) => CachedNetworkImage(
        height: height,
        imageUrl: "${V2Config.host}/images/petunjuk.png",
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget profile({double? height}) => CachedNetworkImage(
        height: height,
        imageUrl: "${V2Config.host}/images/profile.png",
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );

  static Widget tos({double? height}) => CachedNetworkImage(
        height: height,
        imageUrl: "${V2Config.host}/images/tos.png",
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        filterQuality: FilterQuality.low,
        memCacheHeight: 100,
        memCacheWidth: 100,
      );
}
