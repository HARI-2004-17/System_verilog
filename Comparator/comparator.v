// Comparator 4 bit

module comparator_4bit(a,b,a_lt,a_gt,a_eq);
  input [3:0] a,b;
  output a_lt,a_gt,a_eq;
  
  assign a_lt = a<b;
   assign a_gt = a>b;
  assign a_eq = a==b;
endmodule
