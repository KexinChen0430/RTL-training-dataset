
module e16_arbiter_priority(grant,arb_wait,clk,clk_en,reset,hold,request);

  parameter  ARW = 99;
  input  clk;
  input  clk_en;
  input  reset;
  input  hold;
  input  [(0-1)+ARW:0] request;
  output [(0-1)+ARW:0] grant;
  output [(0-1)+ARW:0] arb_wait;
  wire [(0-1)+ARW:0] grant_mask;
  wire [(0-1)+ARW:0] request_mask;
  reg  [(0-1)+ARW:0] grant_hold;

  
  always @(posedge clk or posedge reset)
      if (reset) grant_hold[(0-1)+ARW:0] <= {ARW{1'b0}};
      else if (clk_en) grant_hold[(0-1)+ARW:0] <= grant[(0-1)+ARW:0] & {ARW{hold}};
        
  genvar i;
  
  generate
      for (i = 0; i < ((0-1)+ARW); i = i+1)
          begin : gen_block
            assign request_mask[i] = ~|grant_hold[(0-1)+ARW:i+1] & request[i];
          end
      assign request_mask[(0-1)+ARW] = request[(0-1)+ARW];
  endgenerate

  genvar j;
  assign grant_mask[0] = 1'b0;
  
  generate
      for (j = (0-1)+ARW; j >= 1; j = (0-1)+j)
          begin : gen_arbiter
            assign grant_mask[j] = |request_mask[(0-1)+j:0];
          end
  endgenerate

  assign grant[(0-1)+ARW:0] = request_mask[(0-1)+ARW:0] & ~grant_mask[(0-1)+ARW:0];
  assign arb_wait[(0-1)+ARW:0] = request[(0-1)+ARW:0] & ((request[(0-1)+ARW:0] & ~grant[(0-1)+ARW:0]) | {ARW{hold}});
  
  always @* 
      if (((|(grant_hold[(0-1)+ARW:0] & ~request[(0-1)+ARW:0]) & ~reset) & $time) > 0) 
        begin
          $display("ERROR>>Request not held steady in cell %m at time %0d",
                   $time);
        end
        
endmodule

