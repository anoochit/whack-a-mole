import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:whackmole/widgets/mole_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _score = 0;
  bool _startButtonVisible = true;

  late Timer timer;
  late Timer moleTick;

  int _countDown = 30;
  int _molePosition = 0;

  startGame() {
    _score = 0;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _countDown--;
      dev.log('count down = $_countDown');
      if (_countDown == 0) {
        timer.cancel();
        moleTick.cancel();
        setState(() {
          _countDown = 30;
          _startButtonVisible = true;
        });
      }
    });

    moleTick = Timer.periodic(
      const Duration(milliseconds: 350),
      (timer) {
        setState(() {
          _startButtonVisible = false;
          _molePosition = Random().nextInt(9);
          dev.log('mole position = $_molePosition');
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _molePosition = Random().nextInt(9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: (kIsWeb) ? 420 : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // score
                const Gap(16.0),
                Text(
                  'Score = $_score',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const Gap(16.0),

                Text(
                  'Timer : $_countDown Sec',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const Gap(24.0),

                // mole buttons
                GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: 9,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  ),
                  itemBuilder: (context, index) {
                    return MoleButton(
                      active: (_molePosition == index),
                      onTap: () {
                        if ((_molePosition == index) && (_countDown <= 30)) {
                          _score++;
                        }
                      },
                    );
                  },
                ),

                const Gap(16.0),

                // start button
                Visibility(
                  visible: _startButtonVisible,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    width: MediaQuery.sizeOf(context).width,
                    height: 48.0,
                    child: FilledButton(
                      onPressed: () {
                        // start game
                        startGame();
                      },
                      child: Text(
                        'Start!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.surface,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
