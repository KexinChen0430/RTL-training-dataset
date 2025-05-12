
module arbiter  #(parameter  NUM_PORTS = 6)
  (input  clk,
   input  rst,
   input  [(0-1)+NUM_PORTS:0] request,
   output reg [(0-1)+NUM_PORTS:0] grant,
   output reg active);

  localparam  WRAP_LENGTH = 2*NUM_PORTS;
  integer yy;
  wire next;
  wire [(0-1)+NUM_PORTS:0] order;
  reg  [(0-1)+NUM_PORTS:0] token;
  wire [(0-1)+NUM_PORTS:0] token_lookahead[(0-1)+NUM_PORTS:0];
  wire [WRAP_LENGTH-1:0] token_wrap;

  assign token_wrap = {token,token};
  assign next = ~|(token & request);
  
  always @(posedge clk)  grant <= token & request;
  
  always @(posedge clk)
      active <= |(token & request);
  
  always @(posedge clk)
      if (rst) token <= 'b1;
      else if (next) 
        begin
          for (yy = 0; yy < NUM_PORTS; yy = 1+yy)
              begin : TOKEN_
                if (order[yy]) 
                  begin
                    token <= token_lookahead[yy];
                  end
                  
              end
        end
        
  genvar xx;
  
  generate
      for (xx = 0; xx < NUM_PORTS; xx = 1+xx)
          begin : ORDER_
            assign token_lookahead[xx] = token_wrap[xx +: NUM_PORTS];
            assign order[xx] = |(request & token_lookahead[xx]);
          end
  endgenerate

endmodule

