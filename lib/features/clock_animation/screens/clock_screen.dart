import 'package:flutter/material.dart';
import 'package:flutter_micro_interactions/features/features.dart';
import 'package:flutter_svg/svg.dart';



class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> with TickerProviderStateMixin{
  int selectedIndex = 0;
  bool isIconTapped = true;

  late AnimationController _animationController;
  late Animation<double>_animation;
  late Animation<double>_secondAnimation;
  late AnimationController _secondAnimationController;

  void handleButtonPress(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    ///define animation controller properties
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _secondAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    ///add listener so that when the animation reaches the end, it reverses the widget
    ///to the start
    _animation = Tween(begin: 1.0, end: 0.9).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _secondAnimation = Tween(begin: 1.0, end: 0.9).animate(_secondAnimationController)
      ..addListener(() {
        setState(() {});
      });
    ///reverses the animated widget to the beginning state,
    ///ie to show that animation has been completed
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });
    _secondAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _secondAnimationController.reverse();
      }
    });
    super.initState();
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: UiColors.lightBlueBG,
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30, top: 30, left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: SvgPicture.asset(
                          'assets/images/menu_bar.svg',
                      ),
                      ),
                    const UiTexts(text: 'WORLD CLOCK', size: 25,),
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              const UiTexts(text: '04:45:11 AM', size: 45),
              Container(
                height: 350,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: UiColors.lightBlueCard, width: 10,),
                    boxShadow:
                    [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(4, 4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4, -4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ]
                ),
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    //fix bug on button, not changing color when tapped
                    Transform.scale(
                      scale: _secondAnimation.value,
                      child: Button(
                        title: 'LONDON',
                        onPressed: (){
                          handleButtonPress(0);
                          _secondAnimationController.forward();
                        },
                        isSelected: selectedIndex==0,
                        animation: _secondAnimation,
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Transform.scale(
                      scale: _animation.value,
                      child: Button(
                        title: 'NEW YORK',
                        onPressed: (){
                          handleButtonPress(1);
                          _animationController.forward();

                          },
                          isSelected: selectedIndex==1,
                          animation: _animation,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),

    );
  }
}




