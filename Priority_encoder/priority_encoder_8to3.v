// priority encoder
module priencoder_8to3(din,dout);
  input [7:0]din;
  output reg [2:0]dout;
  always@(*) begin
    casex(din)
      8'b0000_0001: dout = 0;
      8'b0000_001x: dout = 1;
      8'b0000_01xx: dout = 2;
      8'b0000_1xxx: dout = 3;
      8'b0001_xxxx: dout = 4;
      8'b001x_xxxx:dout = 5;
      8'b01xx_xxxx:dout = 6;
      8'b1xxx_xxxx:dout = 7;
      default : dout = 8'bx;
    endcase
  end
endmodule
