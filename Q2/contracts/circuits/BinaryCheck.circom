pragma circom 2.0.0;

template BinaryCheck() {
  signal input in;
  signal output out;

  in * (in - 1) === 0;

  out <== in;
}

component main = BinaryCheck();