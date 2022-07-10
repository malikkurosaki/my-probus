import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:my_probus/v2/v2_developer.dart';
import 'package:my_probus/v2/v2_form_todo.dart';
import 'package:my_probus/v2/v2_issue_create_view.dart';
import 'package:my_probus/v2/v2_home_detail_view.dart';
import 'package:my_probus/v2/v2_issue_list.dart';
import 'package:my_probus/v2/v2_login_view.dart';
import 'package:my_probus/v2/v2_root_view.dart';
import 'v2_home_view.dart';


class V2Routes {
    V2Routes._();
    late String key;

    GetPage getPage({
        Widget ? page
    }) => GetPage(
        name: key,
        page: () => Material(
            child: page ?? Text(key),
        ),
    );

    // a1 do not remove this line
    V2Routes.formTodo(): key = '/form-todo';
    V2Routes.developer(): key = '/developer';
    V2Routes.issueList(): key = '/issue-list';
    V2Routes.root(): key = '/root';
    V2Routes.login(): key = '/login';
    V2Routes.register(): key = '/register';
    V2Routes.home(): key = '/home';
    V2Routes.profile(): key = '/profile';
    V2Routes.logout(): key = '/logout';
    V2Routes.about(): key = '/about';
    V2Routes.contact(): key = '/contact';
    V2Routes.development(): key = '/development';
    V2Routes.issues(): key = '/issues';
    V2Routes.createIssue(): key = '/create-issue';
    V2Routes.issueDetail(): key = '/issue-detail';

    // a2 do not remove this line
    static final all = < GetPage > [
        V2Routes.formTodo().getPage(page: V2FormTodo()),
        V2Routes.developer().getPage(page: V2Developer()),
        V2Routes.issueList().getPage(page: V2IssueList()),
        V2Routes.root().getPage(page: V2RootView()),
        V2Routes.login().getPage(page: V2LoginView()),
        V2Routes.register().getPage(),
        V2Routes.home().getPage(page: V2HomeView()),
        V2Routes.profile().getPage(),
        V2Routes.logout().getPage(),
        V2Routes.about().getPage(),
        V2Routes.contact().getPage(),
        V2Routes.development().getPage(),
        V2Routes.issues().getPage(),
        V2Routes.createIssue().getPage(page: V2IssueCreateView()),
        V2Routes.issueDetail().getPage(page: V2HomeDetailView()),
    ];


}