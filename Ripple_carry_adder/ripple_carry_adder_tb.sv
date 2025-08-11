// Interface

interface inter();
  logic [3:0]a;
  logic [3:0]b;
  logic cin;
   logic [3:0]sum;
  logic cout;
endinterface 

// generator

class generator;
  mailbox mbx;
  logic [3:0] a,b;
  logic cin;
  task run();
    repeat(10) begin
      a = $urandom_range(1,15);
      b = $urandom_range(1,15);
      cin = 0;
      mbx.put({a,b,cin});
      $display (" Generator test cases : a=%4b, b=%4b , cin=%0b", a,b,cin);
    end
  endtask 
endclass

//Driver
class driver;
  mailbox mbx;
  virtual inter vif;
  task run();
    forever begin
      bit [8:0] temp;
      logic [3:0] a,b;
      logic cin;
    mbx.get(temp);
      a = temp[8:5];
      b = temp[4:1];
    cin = temp[0];
    vif.a = a;
    vif.b = b;
    vif.cin = cin;
    #10;
      $display("The received test cases a =%4b, b =%4b, c =%0b, Dut o/p sum =%4b, carry =%0b",a,b,cin,vif.sum,vif.cout);
    end
  endtask
endclass


// testbench
module tb;
  generator gen;
  driver div;
  mailbox mbx;
  
  inter aif();
  ripple_adder uut (.a(aif.a),.b(aif.b),.cin(aif.cin),.sum(aif. sum),.cout(aif.cout));
  initial begin
    gen =new();
    div = new();
    mbx = new();
    gen.mbx = mbx;
    div. mbx = mbx;
    div.vif = aif;
    fork
      gen.run();
      div.run();
    join
  end
  
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0,tb.uut);
  end
endmodule



