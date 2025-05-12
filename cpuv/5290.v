module writer
  (input  wire        clk,
   input  wire        rst,
   output reg  `REQ   req,
   input  wire `RES   res);
   parameter  name = 1;
   reg [31:0] counter, data;
   wire       pause = ^counter[2:1];
   always @(posedge clk)
     if (rst) begin
        counter <= name << 16;
        req     <= 0;
     end else begin
        if (~res`WAIT) begin
           counter <= counter + name;
           if (pause) begin
              req`W   <= 0;
           end else begin
              req`W   <= 1;
              req`A   <= counter;
              req`WD  <= counter;
              if (`WRITER_LOG)
                $display("%6d writer%1d requests %x", $time, name, counter);
           end
        end else begin
           if (`WRITER_LOG)
             $display("%6d writer%1d waits", $time, name);
        end
     end
endmodule