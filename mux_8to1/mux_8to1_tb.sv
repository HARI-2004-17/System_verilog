// Interface

interface inter;
  logic [2:0] sel;
  logic [7:0] in;
  logic dout;
endinterface

//Generator
class generator;
  mailbox mbx;
  task run();
    for (int i = 0; i<8;i++) begin
      logic [2:0] sel = i;
      logic [7:0] in = $urandom_range(10,40);
      mbx.put({sel,in});
      $display("generated test cases : sel = %3b, in = %8b",sel,in);
    end
  endtask
endclass

//Driver

class driver;
  mailbox mbx;
  virtual inter mif;
  task run();
    forever begin
      logic [10:0] temp;
      logic [7:0] in;
      logic [2:0] sel;
      mbx.get(temp);
       in = temp[7:0];
      sel = temp[10:8];
      mif.in = in;
      mif.sel = sel;
      #10;
      $display("Driver received test cases : sel = %3b, in = %8b, mux o/p dout : %0b",sel,in,mif.dout);
    end
  endtask
endclass

//testbench

module tb;
  generator gen;
  driver div;
  mailbox mbx;
  inter aif();
  mux_8to1 dut (.sel(aif.sel),.in(aif.in),.dout(aif.dout));
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0,tb.dut);
    gen = new();
    div = new();
    mbx = new();
    gen.mbx = mbx;
    div.mbx = mbx;
    div.mif = aif;
    fork
      gen.run();
      div.run();
    join
  end
endmodule
      
