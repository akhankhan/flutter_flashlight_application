part of screens;

class HomPage extends StatefulWidget {
  const HomPage({Key? key}) : super(key: key);

  @override
  State<HomPage> createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  Color color = Colors.white;
  double fontSize = 20;
  bool isClicked = true;
  final controller = TorchController();

  final DecorationTween decorationTween = DecorationTween(
    begin: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
              color: Colors.white,
              spreadRadius: 5,
              blurRadius: 20,
              offset: Offset(0, 0))
        ],
        border: Border.all(color: Colors.black)),
    end: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
        boxShadow: const [
          BoxShadow(
              color: Colors.red,
              spreadRadius: 30,
              blurRadius: 15,
              offset: Offset(0, 0))
        ]),
  );

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (isClicked) {
                    _animationController.forward();
                    fontSize = 40;
                    color = Colors.red;
                    HapticFeedback.lightImpact();
                  } else {
                    _animationController.reverse();
                    fontSize = 24;
                    color = Colors.white;
                    HapticFeedback.lightImpact();
                  }
                  isClicked = !isClicked;
                  controller.toggle();
                  setState(() {});
                },
                child: Center(
                  child: DecoratedBoxTransition(
                    position: DecorationPosition.background,
                    decoration: decorationTween.animate(_animationController),
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Center(
                        child: Icon(
                          Icons.power_settings_new,
                          color: isClicked ? Colors.black : Colors.red,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.4,
                  alignment: Alignment.bottomCenter,
                  child: AnimatedDefaultTextStyle(
                      curve: Curves.ease,
                      child:
                          Text(!isClicked ? 'Flashlight ON' : 'Flashlight OFF'),
                      style: TextStyle(
                          color: color,
                          fontSize: fontSize,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold),
                      duration: const Duration(milliseconds: 200)),
                ),
              )
            ],
          ),
        ));
  }
}
