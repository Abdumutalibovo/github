import 'dart:convert';
import 'dart:developer';

class UserModel {
  String name;
  String login;
  String blog;
  int followers;
  int following;
  String avatar_url;

  UserModel({
    required this.name,
    required this.login,
    required this.blog,
    required this.followers,
    required this.following,
    required this.avatar_url,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    String name = jsonData['name'] as String;
    String login = jsonData['login'] as String;
    String blog = jsonData['blog'] as String;
    int followers = jsonData['followers'] as int;
    int following = jsonData['following'] as int;
    String avatar_url = jsonData['avatar_url'] as String;
    
    return UserModel(
      name: name,
      login: login,
      blog: blog,
      followers: followers,
      following: following,
      avatar_url: avatar_url,
    );
  }
}
