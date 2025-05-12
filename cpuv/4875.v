module dut (
    input wire  clk, 
    input wire  rst_n, 
    output wire done 
);
   reg [3:0] counter; 
   always @(posedge clk or negedge rst_n) begin
      if (rst_n & ! clk) begin
         $display("[%0t] %%Error: Oh dear! 'always @(posedge clk or negedge rst_n)' block triggered with clk=%0d, rst_n=%0d.",
                  $time, clk, rst_n);
         $stop;
      end
      if (! rst_n) begin
         counter <= 4'd0;
      end else begin
         counter <= counter < 4'd15 ? counter + 4'd1 : counter;
      end
   end
   assign done = rst_n & (counter == 4'd15);
endmodule