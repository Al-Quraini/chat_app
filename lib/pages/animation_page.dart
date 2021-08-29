import 'package:flutter/material.dart';


class AnimationPage extends StatefulWidget {
  static const String id = '/animation_page';

  const AnimationPage({Key? key}) : super(key: key);

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> with
    SingleTickerProviderStateMixin{



  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 0),
    end: const Offset(2, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInCubic,
  ));

  @override
  void initState() {
    super.initState();


  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _offsetAnimation,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FlutterLogo(size: 150.0),
              ),
            ),

            ElevatedButton(onPressed: (){
              _controller.forward();
              // _fadeController!.forward();
            },
                child: Text(
                  'Animate'
                ))
          ],
        ),
      ),
    );
  }
}
