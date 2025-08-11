// Interface 
interface inter;
  logic [7:0]din;
  logic [2:0]dout;
endinterface

//Generator

class generator;
  mailbox mbx;
  task run();
    repeat (15) begin
      logic [7:0]din = $urandom_range(1,255);
      mbx.put(din);
      $display("Generated test cases : din = %8b",din);
    end
  endtask
endclass

// Driver

class driver;
  mailbox mbx;
  virtual inter vif;
  logic [7:0] din2;
  task run();
    forever begin
      mbx.get(din2);
      vif.din= din2;
      #10;
      $display("Test cases drived :  din = %8b , dout = %3b",vif.din,vif.dout);
    end
  endtask
endclass

// Testbench

module tb;
  generator gen;
  driver div;
  mailbox mbx;
  inter eif();
  priencoder_8to3 dut(.din(eif.din),.dout(eif.dout));
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb.dut);
    gen = new();
    div = new();
    mbx = new();
    gen.mbx = mbx;
    div.mbx = mbx;
    div.vif = eif;
    fork 
      gen.run();
      div.run();
    join
  end
endmodule
