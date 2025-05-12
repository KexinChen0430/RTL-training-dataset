
module clockcounter(input  clk,
                    input  rst,
                    output [31:0] data_a,
                    input  [31:0] addr_a,
                    output [31:0] data_b,
                    output strobe_b,
                    input  [31:0] addr_b,
                    input  [31:0] data_b_in,
                    input  [31:0] data_b_we);

  reg  [31:0] counter;

  assign strobe_b = addr_b == 65542;
  assign data_b = counter;
  
  always @(posedge clk)
      if (~rst) 
        begin
          counter <= 0;
        end
      else 
        begin
          counter <= counter+1;
          if (data_b_we & (addr_b == 65542)) 
            $display(">> Clock cycles: %d",counter);
            
        end
endmodule

