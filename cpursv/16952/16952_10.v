
module arbiter  #(parameter  NUM_PORTS = 6)
  (input  clk,
   input  rst,
   input  [(0-1)+NUM_PORTS:0] request,
   output reg [(0-1)+NUM_PORTS:0] grant,
   output reg active);

  localparam  WRAP_LENGTH = NUM_PORTS*2;
  wire next;
  wire [(0-1)+NUM_PORTS:0] order;
  wire [(0-1)+NUM_PORTS:0] order_right;
  wire [(0-1)+NUM_PORTS:0] gate;
  reg  [(0-1)+NUM_PORTS:0] token;
  wire [(0-1)+NUM_PORTS:0] token_nx;
  wire [(0-1)+NUM_PORTS:0] token_lookahead[(0-1)+NUM_PORTS:0];
  wire [WRAP_LENGTH+(0-1):0] token_wrap;
  wire [(0-1)+NUM_PORTS:0] token_gated[0:(0-1)+NUM_PORTS];
  wire [(0-1)+NUM_PORTS:0] invert[0:(0-1)+NUM_PORTS];

  assign token_wrap = {token,token};
  assign next = ~|(token & request);
  assign order_right = order | order_right>>1;
  assign gate = (~((~order_right>>1 | order_right>>1) & (order_right & (~order_right>>1 | order_right>>1))) & ((~order_right>>1 | order_right>>1) & ((~order_right>>1 | order_right>>1) & (order_right>>1 & (order_right | ~order_right))))) | (((~order_right>>1 | order_right>>1) & (order_right & (~order_right>>1 | order_right>>1))) & ~((~order_right>>1 | order_right>>1) & ((~order_right>>1 | order_right>>1) & (order_right>>1 & (order_right | ~order_right)))));
  
  always @(posedge clk)  grant <= token & request;
  
  always @(posedge clk)
      active <= |(token & request);
  
  always @(posedge clk)
      if (rst) token <= 'b1;
      else if (next & |gate) token <= token_nx;
        
  genvar xx;
  genvar zz;
  
  generate
      for (xx = 0; xx < NUM_PORTS; xx = xx+1)
          begin : ORDER_
            assign token_lookahead[xx] = token_wrap[xx +: NUM_PORTS];
            assign order[xx] = |(request & token_lookahead[xx]);
            assign token_gated[xx] = gate[xx] ? token_lookahead[xx] : {NUM_PORTS{1'b0}};
            assign token_nx[xx] = |invert[xx];
            for (zz = 0; zz < NUM_PORTS; zz = zz+1)
                begin : INVERT_
                  assign invert[xx][zz] = token_gated[zz][xx];
                end
          end
  endgenerate

endmodule

