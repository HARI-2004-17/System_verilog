// Demux 1 to 8

module demux_1to8(din,sel,dout);
  input din;
  input[2:0] sel;
  output reg[7:0] dout;
   always@(*) begin
    dout = 8'd0;
    case(sel)
      0: dout[0] = din;
      1: dout[1] = din;
      2: dout[2] = din;
      3: dout[3] = din;
      4: dout[4] = din;
      5: dout[5] = din;
      6: dout[6] = din;
      7: dout[7] = din;
      default : dout = 8'd0;
    endcase
  end
endmodule
