// import 'package:flutter/material.dart';
// import 'package:routemaster/routemaster.dart';

// final loggedOutRoute =
//     RouteMap(routes: {'/': (_) => const MaterialPage(child: LoginScreen())});

// final loggedInRoute = RouteMap(
//   routes: {
//     '/': (_) => const MaterialPage(
//           child: BaseNavWrapper(),
//         ),
//     // '/create-community': (_) => const MaterialPage(
//     //       child: CreateCommunityScreen(),
//     //     ),
//     // '/kom/:name': (route) => MaterialPage(
//     //       child: CommnunityScreen(
//     //         name: route.pathParameters['name']!,
//     //       ),
//     //     ),
//     // '/mod-tools/:name': (routeDate) => MaterialPage(
//     //       child: ModToolsScreen(
//     //         name: routeDate.pathParameters['name']!,
//     //       ),
//     //     ),
//     // '/edit-komyuniti/:name': (routeData) => MaterialPage(
//     //       child: EditCommunityScreen(
//     //         name: routeData.pathParameters['name']!,
//     //       ),
//     //     ),
//     // '/add-mods/:name': (routeData) => MaterialPage(
//     //       child: AddModsScreen(
//     //         name: routeData.pathParameters['name']!,
//     //       ),
//     //     ),
//     // '/user-profile/:uid': (routeData) => MaterialPage(
//     //       child: UserProfileScreen(
//     //         uid: routeData.pathParameters['uid']!,
//     //       ),
//     //     ),
//     // '/edit-profile/:uid': (routeData) => MaterialPage(
//     //       child: EditProfileScreen(
//     //         uid: routeData.pathParameters['uid']!,
//     //       ),
//     //     ),
//     // // '/add-post': (_) => const MaterialPage(
//     // //       child: AddPostScreen(),
//     // //     ),
//     // '/add-post/:type': (routeData) => MaterialPage(
//     //       child: AddPostTypeScreen(
//     //         type: routeData.pathParameters['type']!,
//     //       ),
//     //     ),
//     // '/post/:postId/comments': (routeData) => MaterialPage(
//     //       child: CommentsScreen(
//     //         postId: routeData.pathParameters['postId']!,
//     //       ),
//     //     ),
//     // '/chat-list/:uid': (routeData) => MaterialPage(
//     //         child: ChatListScreen(
//     //       uid: routeData.pathParameters['uid']!,
//     //     )),
//   },
// );