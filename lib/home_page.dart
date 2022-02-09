import 'package:flutter/material.dart';
import 'game_logic.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _expanded(BuildContext context) {
    return Expanded(
      child: GridView.count(
          padding: EdgeInsets.all(10),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          children: List.generate(
            9,
            (index) => InkWell(
              onTap: endGame
                  ? null
                  : () async {
                      if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) && (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
                        game.playGame(index, activePlayer);
                        updateState();
                        if (!_isSwitched && !endGame && count != 9) {
                          await game.autoPlay(activePlayer);
                          updateState();
                        }
                      }
                    },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).shadowColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                    child: Text(
                        Player.playerX.contains(index)
                            ? 'X'
                            : Player.playerO.contains(index)
                                ? 'O'
                                : '',
                        style: TextStyle(
                          color: Player.playerX.contains(index) ? Colors.pink : Colors.blue,
                          fontSize: 50,
                        ))),
              ),
            ),
          )),
    );
  }

  List<Widget> lastBlock() {
    return [
      Text(result.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 42,
          ),
          textAlign: TextAlign.center),
      SizedBox(height: 10),
      ElevatedButton.icon(
        onPressed: () {
          reSet();
        },
        label: Text('repeat the game'),
        icon: Icon(Icons.replay),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(10)),
          backgroundColor: MaterialStateProperty.all(Theme.of(context).splashColor),
        ),
      ),
      SizedBox(height: 10),
    ];
  }

  List<Widget> firstBlock() {
    return [
      SwitchListTile.adaptive(
        title: const Text('Turn on/off Two players',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center),
        value: _isSwitched,
        onChanged: (bool newVal) {
          setState(() {
            _isSwitched = newVal;
          });
        },
      ),
      SizedBox(height: 10),
      Text(endGame ? '' : "it's ${activePlayer} turn".toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 54,
          ),
          textAlign: TextAlign.center),
    ];
  }

  int count = 0;
  String result = '';
  String activePlayer = 'X';
  bool endGame = false;
  bool _isSwitched = false;
  Game game = Game();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(
                children: [
                  ...firstBlock(),
                  _expanded(context),
                  ...lastBlock(),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...firstBlock(),
                        SizedBox(height: 20),
                        ...lastBlock(),
                      ],
                    ),
                  ),
                  _expanded(context),
                ],
              ),
      ),
    );
  }

  void reSet() {
    setState(() {
      count = 0;
      result = '';
      activePlayer = 'X';
      endGame = false;
      _isSwitched = false;
      Player.playerX = [];
      Player.playerO = [];
    });
  }

  void updateState() {
    count++;

    setState(() {
      activePlayer = activePlayer == 'X' ? 'O' : 'X';
      String winnerPlayer = game.checkWinner();
      if (winnerPlayer != '') {
        result = '$winnerPlayer IS WINNER';
        endGame = true;
      } else if (count == 9) {
        result = "IT'S DRAW";
        endGame = true;
      }
    });
  }
}
