import "package:flutter/material.dart";

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("G.J Care"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            Text(
              "Daejin Univ. 건.전 Care ",
              textAlign: TextAlign.center,
            ),
            Text(
              "== 프로젝트 팀 원 ==",
              textAlign: TextAlign.center,
            ),
            Text(
              "이규태",
              textAlign: TextAlign.center,
            ),
            Text(
              "김 솔",
              textAlign: TextAlign.center,
            ),
            Text(
              "윤휘로",
              textAlign: TextAlign.center,
            ),
            Text(
              "강주협",
              textAlign: TextAlign.center,
            ),
            Text(
              "안찬형",
              textAlign: TextAlign.center,
            ),
            Text(
              "== 프로젝트 지도교수님들 ==",
              textAlign: TextAlign.center,
            ),
            Text(
              "휴먼IT공과대학 전자공학과 정 목 근 교수님",
              textAlign: TextAlign.center,
            ),
            Text(
              "휴먼IT공과대학 AI융합학부 컴퓨터공학전공 김 정 민 교수님",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
