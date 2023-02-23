pragma circom 2.0.0;

template Multiplier2() {
  signal input a;
  signal input b;

  signal output out;

  out <== a * b;
}

template MultiplierN(N) {
  assert(N > 1);

  signal input a[N];
  signal intermediate[N - 1];
  signal output out;

  // component mult[N - 1];
  // for(var i = 0; i < N - 1; i++) {
  //    mult[i] = Multiplier2();
  //    ...
  // }

  intermediate[0] <== a[0] * a[1];
  for(var i = 2; i < N; i++) {
    intermediate[i - 1] <== intermediate[i - 2] * a[i];
  }

  log("Final value", intermediate[N - 2]);

  out <== intermediate[N - 2];
}

component main = MultiplierN(5);