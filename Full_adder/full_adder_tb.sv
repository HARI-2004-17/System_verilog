
// Interface

interface faif();
  logic a;
  logic b;
  logic c;
   logic sum;
  logic carry;
endinterface 

// Generator 

class generator;
  mailbox mbx;
  task run();
    for (int i = 0; i<8; i++) begin
    bit a = i[2];
    bit b = i[1];
    bit c = i[0];
    mbx.put({a,b,c});
    $display (" Generator test cases : a=%0b, b=%0b , c=%0b", a,b,c);
    end
  endtask
endclass
// Driver
class driver;
  mailbox mbx;
  virtual faif vif;
  task run();
    forever begin
    bit [2:0] temp;
    bit a,b,c;
    mbx.get(temp);
    a = temp[2];
    b = temp[1];
    c = temp[0];
    vif.a = a;
    vif.b = b;
    vif.c = c;
    #10;
    $display("The received test cases a =%0b, b =%0b, c =%0b, Dut o/p sum =%0b, carry =%0b",a,b,c,vif.sum,vif.carry);
    end
  endtask
endclass
// Test bench
module tb;
  generator gen;
  driver div;
  mailbox mbx;
  
  faif aif();
  fa uut (.a(aif.a),.b(aif.b),.c(aif.c),.sum(aif. sum),.carry(aif.carry));
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
    
    
  
    
    
  
    
    

