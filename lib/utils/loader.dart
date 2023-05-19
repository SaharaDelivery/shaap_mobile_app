import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shaap_mobile_app/theme/palette.dart';

// class Loader extends StatelessWidget {
//   const Loader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: LoadingAnimationWidget.halfTriangleDot(
//         color: Pallete.whiteColor,
//         size: 60.w,
//       ),
//     );
//   }
// }

class Loader extends ConsumerWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currenTheme = ref.watch(themeNotifierProvider);
    return const Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator(
          color: Pallete.yellowColor,
        ),
        // child: LoadingAnimationWidget.halfTriangleDot(
        //    color: currenTheme.textTheme.bodyMedium!.color!,
        //   size: 60,
        // ),
      ),
    );
  }
}

class NLoader extends ConsumerWidget {
  const NLoader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currenTheme = ref.watch(themeNotifierProvider);
    return Center(
      child: SizedBox(
        height: 14,
        width: 14,
        child: LoadingAnimationWidget.flickr(
          leftDotColor: Pallete.yellowColor,
          rightDotColor: Pallete.blackColor,
          size: 60,
        ),
      ),
    );
  }
}
