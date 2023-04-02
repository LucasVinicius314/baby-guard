import 'package:baby_guard/utils/constants.dart';
import 'package:baby_guard/widgets/base_page.dart';
import 'package:dyn_mouse_scroll/dyn_mouse_scroll.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const route = '/';

  // Widget _getQuickActions() {
  //   final menuOptions =
  //       Constants.menuOptions.where((element) => element.isEnabled);

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     child: Builder(
  //       builder: (context) {
  //         if (menuOptions.isEmpty) {
  //           return Text(
  //             'There\'s nothing here yet.',
  //             style: Theme.of(context).textTheme.bodySmall,
  //           );
  //         }

  //         return Wrap(
  //           spacing: 16,
  //           runSpacing: 16,
  //           children: menuOptions.map((e) {
  //             return IntrinsicWidth(
  //               child: AspectRatio(
  //                 aspectRatio: 1,
  //                 child: SizedBox(
  //                   width: 140,
  //                   child: Card(
  //                     margin: EdgeInsets.zero,
  //                     clipBehavior: Clip.antiAlias,
  //                     child: InkWell(
  //                       onTap: () async {
  //                         await Navigator.of(context)
  //                             .pushReplacementNamed(e.route);
  //                       },
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(16),
  //                         child: Center(
  //                           child: Text(
  //                             e.label,
  //                             textAlign: TextAlign.center,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: DynMouseScroll(
        builder: (context, controller, physics) {
          return SingleChildScrollView(
            physics: physics,
            controller: controller,
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Home',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Text('Welcome to ${Constants.appName}!'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Quick actions',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    // _getQuickActions(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
