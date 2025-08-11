// Interface

interface haif();
  logic a;
  logic b;
  logic s;
   logic c;
endinterface 

// sv tb upto dut 
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
    $display("Data in Driver: a=%0b,b = %0b, sum =%0b ,carry = %0b",a,b,vif.s,vif.c);
    end
  endtask
endclass


  
module tb;
  generator gen;
  driver div;
  mailbox mbx;
  haif aif();
  
  ha uut (.a(aif.a),.b(aif.b),.s(aif.s),.c(aif.c));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb.uut);
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
