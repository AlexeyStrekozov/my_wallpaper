part of '../feature.dart';

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Wallpaper",
          style: _theme.theme.textStyles.regular32.copyWith(
            color: _theme.theme.colors.whiteColor,
          ),
        ),
        backgroundColor: _theme.theme.colors.appBackground,
        centerTitle: true,
      ),
      backgroundColor: _theme.theme.colors.appBackground,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
        ),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is LoadingHomeState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SuccessHomeState) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 15,
                ),
                itemCount: state.responsePhoto?.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => ModalLargerImage(
                          photo: state.responsePhoto![index] ,
                        ),
                      );
                    },
                    child: Image.network(
                        state.responsePhoto?[index].src?.medium ?? ""),
                  );
                });
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}

class _SquareButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final String? assetsIcon;

  const _SquareButton(
      {Key? key, required this.title, this.onTap, this.assetsIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = context.read<ThemeProvider>();

    return Container(
      padding: const EdgeInsets.only(right: 12, left: 12, top: 12, bottom: 2),
      width: MediaQuery.of(context).size.width / 2 - 44,
      height: 92,
      decoration: BoxDecoration(
        color: _theme.theme.colors.grayScaleWhiteOrBlack,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: _theme.theme.colors.borderDividers),
        boxShadow: [
          BoxShadow(
            color: _theme.theme.colors.primaryMain.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 12,
            offset: const Offset(0, 8), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (assetsIcon != null)
              SvgPicture.asset(
                assetsIcon ?? '',
                width: 32,
                height: 32,
              ),
            const SizedBox(height: 4),
            Expanded(
              child: Text(
                title,
                style: _theme.theme.textStyles.medium12,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
