
module arbiter  #(parameter  NUM_PORTS = 6)
  (input  clk,
   input  rst,
   input  [NUM_PORTS+(-1):0] request,
   output reg [NUM_PORTS+(-1):0] grant,
   output reg active);

  localparam  WRAP_LENGTH = NUM_PORTS<<1;
  integer yy;
  wire next;
  wire [NUM_PORTS+(-1):0] order;
  reg  [NUM_PORTS+(-1):0] token;
  wire [NUM_PORTS+(-1):0] token_lookahead[NUM_PORTS+(-1):0];
  wire [(-1)+WRAP_LENGTH:0] token_wrap;

  assign token_wrap = {token,token};
  assign next = ~|(request & token);
  
  always @(posedge clk)  grant <= request & token;
  
  always @(posedge clk)
      active <= |(request & token);
  
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
            assign order[xx] = |(token_lookahead[xx] & request);
          end
  endgenerate

endmodule

