import 'dart:math';

class Player {
  static String x = 'X';
  static String o = 'O';
  static String empty = '';
  static List playerX = [];
  static List playerO = [];
}

class Game {
  void playGame(int index, String activePlayer) {
    if (activePlayer == 'X') {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  Future<void> autoPlay(activePlayer) async {
    int index = 0;
    List<int> emptyCells = [];
    for (var i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
        emptyCells.add(i);
      }
    }
//LOGIC TO MAKE COMPUTER SMART
    for (var i = 0; i < 9; i + 3) {
      if (Player.playerO.containsAll(i, i + 1) && emptyCells.contains(i + 2)) {
        index = i + 2;
      } else if (Player.playerO.containsAll(i, i + 2) && emptyCells.contains(i + 1)) {
        index = i + 1;
      } else if (Player.playerO.containsAll(i + 2, i + 1) && emptyCells.contains(i)) {
        index = i;
      }
    }

    for (var i = 0; i < 9; i + 3) {
      if (Player.playerO.containsAll(i, i + 3) && emptyCells.contains(i + 6)) {
        index = i + 6;
      } else if (Player.playerO.containsAll(i, i + 6) && emptyCells.contains(i + 3)) {
        index = i + 3;
      } else if (Player.playerO.containsAll(i + 3, i + 6) && emptyCells.contains(i)) {
        index = i;
      }
    }
    for (var i = 0; i < 9; i + 3) {
      if (Player.playerX.containsAll(i, i + 1) && emptyCells.contains(i + 2)) {
        index = i + 2;
      } else if (Player.playerX.containsAll(i, i + 2) && emptyCells.contains(i + 1)) {
        index = i + 1;
      } else if (Player.playerX.containsAll(i + 2, i + 1) && emptyCells.contains(i)) {
        index = i;
      }
    }
    for (var i = 0; i < 2; i++) {
      if (Player.playerX.containsAll(i, i + 3) && emptyCells.contains(i + 6)) {
        index = i + 6;
      } else if (Player.playerX.containsAll(i, i + 6) && emptyCells.contains(i + 3)) {
        index = i + 3;
      } else if (Player.playerX.containsAll(i + 3, i + 6) && emptyCells.contains(i)) {
        index = i;
      }
    }

    if (emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerO.containsAll(0, 4) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playerO.containsAll(0, 7) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerO.containsAll(7, 4) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerO.containsAll(2, 4) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playerO.containsAll(6, 4) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playerO.containsAll(6, 2) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerX.containsAll(0, 4) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playerX.containsAll(0, 7) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerX.containsAll(7, 4) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerX.containsAll(2, 4) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playerX.containsAll(6, 4) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playerX.containsAll(6, 2) && emptyCells.contains(4)) {
      index = 4;
    } else {
      Random random = Random();
      int randomIndex = random.nextInt(emptyCells.length);
      index = emptyCells[randomIndex];
    }

    playGame(index, activePlayer);
  }

  String checkWinner() {
    String winner = '';
    for (var i = 0; i < 2; i++) {
      int c = 0;
      if (Player.playerX.containsAll(i + c, i + c + 1, i + c + 2) || Player.playerX.containsAll(i, i + 3, i + 6)) {
        c += 3;
        return winner = 'X';
      }
    }
    if (Player.playerX.containsAll(0, 4, 8) || Player.playerX.containsAll(2, 4, 6)) return winner = 'X';

    for (var i = 0; i < 2; i++) {
      int c = 0;
      if (Player.playerO.containsAll(i + c, i + c + 1, i + c + 2) || Player.playerO.containsAll(i, i + 3, i + 6)) {
        c += 3;
        return winner = 'O';
      }
    }
    if (Player.playerO.containsAll(0, 4, 8) || Player.playerO.containsAll(2, 4, 6)) return winner = 'O';

    return winner = '';
  }
}

extension ContainsAll on List {
  bool containsAll(int x, int y, [z]) {
    if (z == null)
      return this.contains(x) && this.contains(y);
    else
      return this.contains(x) && this.contains(y) && this.contains(z);
  }
}
