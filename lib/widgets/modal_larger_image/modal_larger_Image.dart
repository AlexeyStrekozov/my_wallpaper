import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wallpaper/common/network/models/response/photos_model.dart';
import 'package:my_wallpaper/common/providers/theme_provider.dart';
import 'package:my_wallpaper/widgets/default_circular_progress_indicator.dart';
import 'package:my_wallpaper/widgets/snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/wallpaper.dart';

class ModalLargerImage extends StatefulWidget {
  final Photo photo;

  const ModalLargerImage({Key? key, required this.photo}) : super(key: key);

  @override
  State<ModalLargerImage> createState() => _ModalLargerImageState();
}

class _ModalLargerImageState extends State<ModalLargerImage> {
  String home = "Home Screen",
      lock = "Lock Screen",
      both = "Both Screen",
      system = "System";

  late Stream<String> progressString;
  late String res;

  bool downloading = false;

  Future<bool> fileCheck() async {
    final dir = await getTemporaryDirectory();
    String path = '${dir.path}/${widget.photo.id.toString()}.jpeg';

    if (await File(path).exists()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeProvider>().theme;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: theme.colors.whiteColor.withOpacity(0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200,
              height: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.photo.src?.medium ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _Button(
              downloading: downloading,
              func: () async {
                if (await fileCheck()) {
                  snackBar(
                    context: context,
                    theme: theme,
                    title: "File downloaded",
                  );
                } else {
                  progressString = Wallpaper.imageDownloadProgress(
                    widget.photo.src?.large ?? "",
                    imageName: widget.photo.id.toString(),
                  );
                  progressString.listen((data) {
                    setState(() {
                      res = data;
                      downloading = true;
                    });
                    print("DataReceived: " + data);
                  }, onDone: () async {
                    setState(() {
                      downloading = false;
                    });
                    snackBar(
                      context: context,
                      theme: theme,
                      error: false,
                      backgroundColor: theme.colors.greenSuccess,
                      title: "File downloaded",
                    );
                    print("Task Done");
                  }, onError: (error) {
                    setState(() {
                      downloading = false;
                    });
                    print("Some Error");
                  });
                }
              },
              textButton: "Save",
            ),
            _Button(
              downloading: downloading,
              func: () async {
                if (await fileCheck()) {
                  await Wallpaper.homeScreen(
                    imageName: widget.photo.id.toString(),
                    options: RequestSizeOptions.RESIZE_CENTRE_CROP,
                    width: width,
                    height: height,
                  );
                  snackBar(
                    context: context,
                    theme: theme,
                    backgroundColor: theme.colors.greenSuccess,
                    title: "Home screen installed",
                    error: false,
                  );
                } else {
                  snackBar(
                    context: context,
                    theme: theme,
                    title: " Need to download a picture",
                  );
                }
              },
              textButton: home,
            )
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final void Function()? func;
  final String textButton;
  final bool downloading;
  const _Button({
    Key? key,
    this.func,
    required this.textButton,
    required this.downloading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.read<ThemeProvider>().theme;

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: theme.colors.whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: theme.colors.grayScaleWhiteOrBlack,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: func,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: downloading
                ? const Center(
                    child: SizedBox(
                        width: 19,
                        height: 19,
                        child: DefaultCircularProgressIndicators(
                          strokeWidth: 2,
                        )))
                : Text(
                    textButton,
                    style: theme.textStyles.medium14.copyWith(
                      color: theme.colors.primaryDarkOrWhite,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
