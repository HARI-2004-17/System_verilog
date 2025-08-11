

// Interface

interface haif();
  logic a;
  logic b;
  logic d;
   logic bo;
endinterface 


// Generator
class generator;
  mailbox mbx;
  
  task run();
    for (int i = 0; i<4;i++) begin
    bit a = i[1];//msb
    bit b = i[0];//lsb
    mbx.put({a,b}); // here mailbox acepts only packed data so mbx.put(a,b) gives error
    $display("generator inputs: a= %0b,b= %0b",a,b);
    end
  endtask
endclass

//Driver

class driver;
  mailbox mbx;
  virtual haif vif;
  
  task run();
    forever begin
    bit [1:0] temp;
    bit a,b;
    mbx.get(temp);
    a = temp[1];
    b = temp[0];
    vif.a = a;
    vif.b = b;
    #10; // here dealay is given for dut o/p to process
      $display("Data in Driver: a=%0b,b = %0b, diff =%0b ,bout = %0b",a,b,vif.d,vif.bo);
    end
  endtask
endclass


  
module tb;
  generator gen;
  driver div;
  mailbox mbx;
  haif aif();
  
  ha uut (.a(aif.a),.b(aif.b),.d(aif.d),.bo(aif.bo));
  
  initial begin
     $dumpfile("dump.vcd");
      $dumpvars;
    
    gen=new();
    div=new();
    mbx=new();
    gen.mbx = mbx;
    div.mbx = mbx; // assigned single mailbox to both generator and driver
    div.vif = aif; // equating interface 
   fork 
    gen.run();
    div.run();
   join
  end
    
endmodule
