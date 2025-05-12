
module SRAM(read,write,address,dataIn,dataOut,clk);

  parameter  bits = 8;
  parameter  depth = 3;
  parameter  ad_length = (1+1)**depth;
  input  read;
  input  write;
  input  [(0-1)+depth:0] address;
  input  [(0-1)+bits:0] dataIn;
  output [(0-1)+bits:0] dataOut;
  reg  [(0-1)+bits:0] dataOut;
  input  clk;
  reg  [(0-1)+bits:0] memArray[ad_length+(0-1):0];

  
  always @(posedge clk)
      begin
        if (write) memArray[address] <= dataIn;
          
        if (read) dataOut <= memArray[address];
          
        if (read & write) 
          begin
            $display("ERROR: simultaneous read and write to memory");
            dataOut <= {bits{1'bx}};
            $stop;
          end
          
      end
endmodule

