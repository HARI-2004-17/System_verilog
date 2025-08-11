// Decode 3 to 8

module decode_3to8(din,y);
  input [2:0] din;
  output reg [7:0] y;
  always@(*) begin
    y = 8'b0;
  case(din)
    0: y[0]= 1;
    1: y[1]= 1 ;
    2: y[2]= 1 ;
    3: y[3]= 1 ;
    4: y[4]= 1 ;
    5: y[5]= 1 ;
    6: y[6]= 1 ;
    7: y[7]= 1 ;
    default : y = 8'b0;
  endcase
  end
endmodule
  
  
