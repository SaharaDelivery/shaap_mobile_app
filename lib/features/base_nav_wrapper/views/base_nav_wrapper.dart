import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaap_mobile_app/features/base_nav_wrapper/widgets/nav_bar_widget.dart';
import 'package:shaap_mobile_app/features/favourites/views/favourites_view.dart';
import 'package:shaap_mobile_app/features/home/views/home_view.dart';
import 'package:shaap_mobile_app/features/orders/views/orders_view.dart';
import 'package:shaap_mobile_app/theme/palette.dart';

class BaseNavWrapper extends ConsumerStatefulWidget {
  const BaseNavWrapper({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseNavWrapperState();
}

class _BaseNavWrapperState extends ConsumerState<BaseNavWrapper> {
  List<Widget> pages = const [
    HomeView(),
    FavouritesView(),
    OrdersView(),
    Center(child: Text('profile view')),
  ];

  final ValueNotifier<int> _page = ValueNotifier(0);

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // pages
      body: ValueListenableBuilder(
        valueListenable: _page,
        builder: (context, value, child) => pages[_page.value],
      ),

      // nav bar
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _page,
        builder: (context, value, child) => Material(
          elevation: 5,
          // nav bar content
          child: Container(
            color: Pallete.whiteColor,
            padding: EdgeInsets.only(top: 17.h, left: 17.w, right: 17.w),
            height: 80.h,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //! Notes
                NavBarWidget(
                  onTap: () => _page.value = 0,
                  icon: _page.value == 0 ? 'home-filled' : 'home',
                  label: 'Home',
                  iconColor:
                      _page.value == 0 ? Pallete.yellowColor : Pallete.textGrey,
                  color:
                      _page.value == 0 ? Pallete.yellowColor : Pallete.textGrey,
                  fontWeight: _page.value == 0 ? FontWeight.w600 : null,
                ),

                //! Insights
                NavBarWidget(
                  onTap: () => _page.value = 1,
                  icon: _page.value == 1 ? 'favourite-filled' : 'favourite',
                  label: 'Favourite',
                  iconColor:
                      _page.value == 1 ? Pallete.yellowColor : Pallete.textGrey,
                  color:
                      _page.value == 1 ? Pallete.yellowColor : Pallete.textGrey,
                  fontWeight: _page.value == 1 ? FontWeight.w600 : null,
                ),

                //! Home
                NavBarWidget(
                  onTap: () => _page.value = 2,
                  icon: _page.value == 2 ? 'orders-filled' : 'orders',
                  label: 'Orders',
                  iconColor:
                      _page.value == 2 ? Pallete.yellowColor : Pallete.textGrey,
                  color:
                      _page.value == 2 ? Pallete.yellowColor : Pallete.textGrey,
                  fontWeight: _page.value == 2 ? FontWeight.w600 : null,
                ),

                //! Help
                NavBarWidget(
                  onTap: () => _page.value = 3,
                  icon: _page.value == 3 ? 'profile-filled' : 'profile',
                  label: 'Profile',
                  iconColor:
                      _page.value == 3 ? Pallete.yellowColor : Pallete.textGrey,
                  color:
                      _page.value == 3 ? Pallete.yellowColor : Pallete.textGrey,
                  fontWeight: _page.value == 3 ? FontWeight.w600 : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
