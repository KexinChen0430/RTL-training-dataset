
module e16_arbiter_priority(grant,arb_wait,clk,clk_en,reset,hold,request);

  parameter  ARW = 99;
  input  clk;
  input  clk_en;
  input  reset;
  input  hold;
  input  [(-1)+ARW:0] request;
  output [(-1)+ARW:0] grant;
  output [(-1)+ARW:0] arb_wait;
  wire [(-1)+ARW:0] grant_mask;
  wire [(-1)+ARW:0] request_mask;
  reg  [(-1)+ARW:0] grant_hold;

  
  always @(posedge clk or posedge reset)
      if (reset) grant_hold[(-1)+ARW:0] <= {ARW{1'b0}};
      else if (clk_en) grant_hold[(-1)+ARW:0] <= {ARW{hold}} & grant[(-1)+ARW:0];
        
  genvar i;
  
  generate
      for (i = 0; i < ((-1)+ARW); i = i+1)
          begin : gen_block
            assign request_mask[i] = request[i] & ~|grant_hold[(-1)+ARW:i+1];
          end
      assign request_mask[(-1)+ARW] = request[(-1)+ARW];
  endgenerate

  genvar j;
  assign grant_mask[0] = 1'b0;
  
  generate
      for (j = (-1)+ARW; j >= 1; j = j+(-1))
          begin : gen_arbiter
            assign grant_mask[j] = |request_mask[j+(-1):0];
          end
  endgenerate

  assign grant[(-1)+ARW:0] = ~grant_mask[(-1)+ARW:0] & request_mask[(-1)+ARW:0];
  assign arb_wait[(-1)+ARW:0] = ({ARW{hold}} & request[(-1)+ARW:0]) | (request[(-1)+ARW:0] & ~grant[(-1)+ARW:0]);
  
  always @* 
      if (($time & (|(grant_hold[(-1)+ARW:0] & ~request[(-1)+ARW:0]) & ~reset)) > 0) 
        begin
          $display("ERROR>>Request not held steady in cell %m at time %0d",
                   $time);
        end
        
endmodule

