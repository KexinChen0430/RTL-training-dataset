module initiator
  (input  wire        clk,
   input  wire        rst,
   output reg  `REQ   req,
   input  wire `RES   res);
   parameter  name = 1;
   reg [31:0] counter, data;
   reg [31:0] dataExpect;
   reg        dataValid;
   wire       pause = ^counter[1:0];
   always @(posedge clk)
     if (rst) begin
        counter <= name << 16;
        req     <= 0;
        dataValid <= 0;
        dataExpect <= 0;
     end else begin
        dataExpect <= data;
        dataValid <= req`R & ~res`WAIT;
        if (dataValid) begin
           if (dataExpect != res`RD)
             $display("%6d init%d got %x, expected %x !!! BAD!",
                      $time, name, res`RD, dataExpect);
           else
             $display("%6d init%d got %x as expected", $time, name, res`RD);
        end
        if (~res`WAIT) begin
           counter <= counter + 1;
           if (pause) begin
              req`R   <= 0;
           end else begin
              req`R   <= 1;
              req`A   <= counter;
              data    <= counter;
              $display("%6d init%d requests %x", $time, name, counter);
           end
        end
     end
endmodule