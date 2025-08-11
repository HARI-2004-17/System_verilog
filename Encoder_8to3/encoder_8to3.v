// Encoder 8 to 3 

module encoder_8to3(din,dout);
  input [7:0]din;
  output reg [2:0]dout;
  always@(*) begin
    case(din)
      1: dout = 0;
      2: dout = 1;
      4: dout = 2;
      8: dout = 3;
      16:dout = 4;
      32:dout = 5;
      64:dout = 6;
      128:dout = 7;
      default : dout = 8'bx;
    endcase
  end
endmodule
      
  
