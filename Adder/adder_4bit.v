//  4 bit adder

module adder(a,b,c);
  input [3:0]a,b;
  output [4:0]c;
  assign c = a+b;
endmodule
