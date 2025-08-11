// Code for full  subtractor
module full_sub (a,b,c,diff,bout);
  input  a,b,c;
  output diff,bout;
  assign diff = a^b^c;
  assign bout = (~a&b) | (b&c) | (c&~a);
endmodule
