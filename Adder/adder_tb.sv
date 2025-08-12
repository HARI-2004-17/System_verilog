// interface 

interface inter;
  logic [3:0] a,b;
  logic [4:0]c;
endinterface

// Generatotr

class generator;
  mailbox mbx;
  task run();
    repeat(15) begin
      logic [3:0] a = $urandom_range(0,15);
      logic [3:0] b = $urandom_range(0,15);
      mbx.put({a,b});
      $display("Generator test cases : a = %4b, b = %4b",a,b);
    end
  endtask
endclass

//Driver 

class driver;
  mailbox mbx;
  virtual inter vif;
  task run();
    forever begin
      logic [7:0] temp;
      mbx.get(temp);
      vif.a = temp[7:4];
      vif.b = temp[3:0];
      #10;
      $display("Driver obtained data : a = %4b, b = %4b, adder output c = %5b",vif.a,vif.b,vif.c);
    end
  endtask
endclass

// Testbench

module tb;
  generator gen;
  driver div;
  mailbox mbx;
  inter aif();
  adder uut (.a(aif.a),.b(aif.b),.c(aif.c));
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb.uut);
    gen = new();
    div = new();
    mbx = new();
    gen.mbx = mbx;
    div.mbx = mbx;
    div.vif = aif;
    fork
      gen.run();
      div.run();
    join
  end
endmodule
 
