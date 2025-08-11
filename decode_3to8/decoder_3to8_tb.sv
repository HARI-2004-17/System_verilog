// interface

interface inter;
  logic [2:0] din;
  logic [7:0]y;
endinterface

//Generator

class generator;
  mailbox mbx;
  logic [2:0]data;
  task run();
  for (int i = 0; i<8;i++) begin
    data = i;
    mbx.put(data);
    $display("Generated test cases : %3b",data);
  end
    endtask
endclass

// Driver

class driver;
  mailbox mbx;
  virtual inter vif;
  task run();
    forever begin
      logic [2:0] data2;
      mbx.get(data2);
      vif.din = data2;
      #10;
      $display("Received Test cases : %3b, output of decoder : %8b",data2,vif.y);
    end
  endtask
endclass

//test bench

module tb;
  generator gen;
  driver div;
  mailbox mbx;
  inter dif();
  decode_3to8 dut (.din(dif.din),.y(dif.y));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb.dut);
    gen = new();
    div =  new();
    mbx = new();
    gen.mbx = mbx;
    div.mbx = mbx;
    div.vif = dif;
    fork
      gen.run();
      div.run();
    join
  end
endmodule
    
  
