pragma circom 2.0.0;

template Multiplier2() {
   signal input a;
   signal input b;
   signal output out;

   out <== a * b;
}

template Multiplier3 () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;
   signal input c;
   
   signal output out;

   component mult1 = Multiplier2();
   component mult2 = Multiplier2();

   mult1.a <== a;
   mult1.b <== b;

   mult2.a <== mult1.out;
   mult2.b <== c;

   out <== mult2.out;
}

component main {public[a, b, c]} = Multiplier3();