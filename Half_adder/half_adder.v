// Code for half  adder
module ha (a,b,s,c);
  input  a,b;
  output s,c;
  assign s = a^b;
  assign c = a&b;
endmodule
