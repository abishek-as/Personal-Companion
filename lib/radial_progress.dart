import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:vector_math/vector_math_64.dart' as math;

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

String status = 'LOADING', steps = '800';

class RadialProgress extends StatefulWidget {
  const RadialProgress({Key? key}) : super(key: key);

  //final double goalCompleted = 0.5;

  @override
  _RadialProgressState createState() => _RadialProgressState();

  get x => double.parse(steps) / 3000;
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  var count = 0;
  final Duration fadeInDuration = const Duration(milliseconds: 500);
  final Duration fillDuration = const Duration(seconds: 2);
  double progressDegrees = 0;

  late Stream<PedestrianStatus> _pedestrianStatusStream;
  late Animation<double> _progressAnimation;
  late AnimationController _radialProgressAnimationController;
  late Stream<StepCount> _stepCountStream;

  @override
  void dispose() {
    _radialProgressAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          progressDegrees = widget.x * _progressAnimation.value;
        });
      });

    _radialProgressAnimationController.forward();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      steps = event.steps.toString();
    });
    print(steps);
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      status = event.status;
    });
    print(status);
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      status = 'Pedestrian Status not available';
    });
    print(status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    //RadialProgress rp = new RadialProgress();
    return CustomPaint(
      child: Container(
        height: 350.0,
        width: 350.0,
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: AnimatedOpacity(
          opacity: progressDegrees > 30 ? 1.0 : 0.0,
          duration: fadeInDuration,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Text(
                status.toUpperCase(),
                style: const TextStyle(
                    fontSize: 45.0,
                    letterSpacing: 1.5,
                    fontFamily: 'GoogleRegular',
                    color: Colors.black),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Container(
                height: 5.0,
                width: 120.0,
                decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                steps,
                style: const TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'GoogleBold',
                    color: Colors.black),
              ),
              Text(
                'STEPS',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.lightBlueAccent[400],
                    letterSpacing: 1.5,
                    fontFamily: 'GoogleRegular'),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                'GOAL - 3000',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.deepOrangeAccent[400],
                    letterSpacing: 1.5,
                    fontFamily: 'GoogleRegular'),
              ),
            ],
          ),
        ),
      ),
      painter: RadialPainter(progressDegrees),
    );
  }
}

class RadialPainter extends CustomPainter {
  RadialPainter(this.progressInDegrees);

  double progressInDegrees;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9.0;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, paint);

    Paint progressPaint = Paint()
      ..shader = const LinearGradient(
              colors: [Colors.red, Colors.purple, Colors.purpleAccent])
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9.0;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90),
        math.radians(progressInDegrees),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
