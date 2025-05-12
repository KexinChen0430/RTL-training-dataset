
module arbiter  #(parameter  NUM_PORTS = 6)
  (input  clk,
   input  rst,
   input  [(-1)+NUM_PORTS:0] request,
   output reg [(-1)+NUM_PORTS:0] grant,
   output reg active);

  localparam  WRAP_LENGTH = NUM_PORTS*1<<<1;
  wire next;
  wire [(-1)+NUM_PORTS:0] order;
  wire [(-1)+NUM_PORTS:0] order_right;
  wire [(-1)+NUM_PORTS:0] gate;
  reg  [(-1)+NUM_PORTS:0] token;
  wire [(-1)+NUM_PORTS:0] token_nx;
  wire [(-1)+NUM_PORTS:0] token_lookahead[(-1)+NUM_PORTS:0];
  wire [WRAP_LENGTH-1:0] token_wrap;
  wire [(-1)+NUM_PORTS:0] token_gated[0:(-1)+NUM_PORTS];
  wire [(-1)+NUM_PORTS:0] invert[0:(-1)+NUM_PORTS];

  assign token_wrap = {token,token};
  assign next = ~|(request & token);
  assign order_right = order | order_right>>1;
  assign gate = (((order_right>>1 | ~order_right>>1) | ((~order_right>>1 & (order_right>>1 & (~order_right | order_right))) | (~order_right>>1 & order_right))) & (order_right>>1 & (~order_right | order_right))) ^ (order_right & ((order_right>>1 | ~order_right>>1) | ((~order_right>>1 & (order_right>>1 & (~order_right | order_right))) | (~order_right>>1 & order_right))));
  
  always @(posedge clk)  grant <= request & token;
  
  always @(posedge clk)
      active <= |(request & token);
  
  always @(posedge clk)
      if (rst) token <= 'b1;
      else if (next & |gate) token <= token_nx;
        
  genvar xx;
  genvar zz;
  
  generate
      for (xx = 0; xx < NUM_PORTS; xx = xx+1)
          begin : ORDER_
            assign token_lookahead[xx] = token_wrap[xx +: NUM_PORTS];
            assign order[xx] = |(token_lookahead[xx] & request);
            assign token_gated[xx] = gate[xx] ? token_lookahead[xx] : {NUM_PORTS{1'b0}};
            assign token_nx[xx] = |invert[xx];
            for (zz = 0; zz < NUM_PORTS; zz = zz+1)
                begin : INVERT_
                  assign invert[xx][zz] = token_gated[zz][xx];
                end
          end
  endgenerate

endmodule

