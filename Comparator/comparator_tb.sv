// interface 

interface inter;
  logic [3:0] a,b;
  logic a_lt,a_gt,a_eq;
endinterface

//Generator

class generator;
  mailbox mbx;
  task run();
    repeat(10) begin
      logic [3:0] a = $urandom_range(0,15);
      logic [3:0] b = $urandom_range(0,15);
      mbx.put({a,b});
      $display("Generated test cases : a = %4b , b = %4b",a,b);
    end
  endtask
endclass

// Driver 

class driver;
  mailbox mbx;
  virtual inter vif;
  logic [7:0] temp;
  logic [3:0] a,b;
  task run();
    forever begin
      mbx.get(temp);
      a = temp[7:4];
      b = temp[3:0];
      vif.a = a;
      vif.b = b;
      #10;
      $display("Driver obtained test cases : a = %4b , b = %4b ,output : a_lt = %0b, a_gt = %0b, a_eq = %0b ", vif.a,vif.b,vif.a_lt,vif.a_gt,vif.a_eq);
    end
  endtask
endclass

//Testbench

module tb;
  generator gen;
  driver div;
  mailbox mbx;
  inter cif();
  comparator_4bit dut (.a(cif.a),.b(cif.b),.a_lt(cif.a_lt),.a_gt(cif.a_gt),.a_eq(cif.a_eq));
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb.dut);
    gen = new();
    div = new();
    mbx = new();
    gen.mbx = mbx;
    div.mbx = mbx;
    div.vif = cif;
    fork 
      gen.run();
      div.run();
    join
    
  end
endmodule
