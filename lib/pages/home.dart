import 'dart:async'; // Provides asynchronous programming using Future and Stream
import 'dart:math'; // Provides mathematical constants and functions
import 'dart:developer' as dev; // Provides logging for development purposes

import 'package:flutter/foundation.dart'; // Foundation library for Flutter framework
import 'package:flutter/material.dart'; // Flutter framework for building UI
import 'package:gap/gap.dart'; // Provides spacing widgets
import 'package:whackmole/widgets/mole_button.dart'; // Importing the MoleButton widget from your project

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Score of the game
  int _score = 0;

  // Visibility state of the start button
  bool _startButtonVisible = true;

  // Timer for the game countdown
  late Timer _timer;

  // Timer for the mole's appearance
  late Timer _moleTick;

  // Countdown time in seconds
  int _countDown = 30;

  // Position of the mole (0 to 8)
  int _molePosition = 0;

  // Starts the game
  startGame() {
    _score = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _countDown--;
      dev.log('count down = $_countDown');
      if (_countDown == 0) {
        _timer.cancel();
        _moleTick.cancel();
        setState(() {
          _countDown = 30;
          _startButtonVisible = true;
        });
      }
    });

    _moleTick = Timer.periodic(
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
                // Gap for spacing
                const Gap(16.0),
                // Displays the score
                Text(
                  'Score = $_score',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.blue),
                ),
                const Gap(16.0),

                // Displays the countdown timer
                Text(
                  'Timer : $_countDown Sec',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Colors.red),
                ),

                const Gap(24.0),

                // Grid of mole buttons
                GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: 9,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemBuilder: (context, index) {
                    return MoleButton(
                      active: (_molePosition == index) && (_countDown != 30),
                      onTap: () {
                        if ((_molePosition == index) && (_countDown <= 30)) {
                          _score++;
                        }
                      },
                    );
                  },
                ),

                const Gap(16.0),

                // Start button
                Visibility(
                  visible: _startButtonVisible,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    width: MediaQuery.sizeOf(context).width,
                    height: 48.0,
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green),
                      ),
                      onPressed: () {
                        // Starts the game
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
