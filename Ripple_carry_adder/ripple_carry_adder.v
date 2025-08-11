// Code for full  adder/adder
module fa (a,b,c,sum,carry);
  input  a,b,c;
  output sum,carry;
  assign sum = a^b^c;
  assign carry = (a&b) | (b&c) | (c&a);
endmodule


// ripple carry adder
module ripple_adder(a,b,cin,sum,cout);
  input [3:0]a,b;
  input cin;
  output [3:0]sum;
  output cout;
  wire [2:0]c;
  
  fa fa0(.a(a[0]),.b(b[0]),.c(cin),.sum(sum[0]),.carry(c[0]));
          
  fa fa1(.a(a[1]),.b(b[1]),.c(c[0]),.sum(sum[1]),.carry(c[1]));
           
  fa fa2(.a(a[2]),.b(b[2]),.c(c[1]),.sum(sum[2]),.carry(c[2]));
          
  fa fa3(.a(a[3]),.b(b[3]),.c(c[2]),.sum(sum[3]),.carry(cout));  
          
endmodule
