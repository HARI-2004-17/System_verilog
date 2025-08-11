// Mux 8 to 1

module mux_8to1(sel,dout,in);
  input [2:0] sel;
  input [7:0] in;
  output dout;
  
  assign dout = in[sel];
endmodule
