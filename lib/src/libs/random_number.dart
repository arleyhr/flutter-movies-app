import 'dart:math';

final _random = new Random();

int randomNumber([int min = 1, int max = 100000]) => min + _random.nextInt(max - min);