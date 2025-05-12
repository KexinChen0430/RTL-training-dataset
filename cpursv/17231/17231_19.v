
module e16_arbiter_priority(grant,arb_wait,clk,clk_en,reset,hold,request);

  parameter  ARW = 99;
  input  clk;
  input  clk_en;
  input  reset;
  input  hold;
  input  [ARW-1:0] request;
  output [ARW-1:0] grant;
  output [ARW-1:0] arb_wait;
  wire [ARW-1:0] grant_mask;
  wire [ARW-1:0] request_mask;
  reg  [ARW-1:0] grant_hold;

  
  always @(posedge clk or posedge reset)
      if (reset) grant_hold[ARW-1:0] <= {ARW{1'b0}};
      else if (clk_en) grant_hold[ARW-1:0] <= {ARW{hold}} & grant[ARW-1:0];
        
  genvar i;
  
  generate
      for (i = 0; i < (ARW-1); i = 1+i)
          begin : gen_block
            assign request_mask[i] = ~|grant_hold[ARW-1:1+i] & request[i];
          end
      assign request_mask[ARW-1] = request[ARW-1];
  endgenerate

  genvar j;
  assign grant_mask[0] = 1'b0;
  
  generate
      for (j = ARW-1; j >= 1; j = (-1)+j)
          begin : gen_arbiter
            assign grant_mask[j] = |request_mask[(-1)+j:0];
          end
  endgenerate

  assign grant[ARW-1:0] = request_mask[ARW-1:0] & ~grant_mask[ARW-1:0];
  assign arb_wait[ARW-1:0] = (request[ARW-1:0] & ~grant[ARW-1:0]) | (request[ARW-1:0] & {ARW{hold}});
  
  always @* 
      if ((|(grant_hold[ARW-1:0] & ~request[ARW-1:0]) & (~reset & $time)) > 0) 
        begin
          $display("ERROR>>Request not held steady in cell %m at time %0d",
                   $time);
        end
        
endmodule

