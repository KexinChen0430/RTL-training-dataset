
module DeBouncer(input  clk,n_reset,button_in,
                 output reg DB_out);

  parameter  N = 23;
  reg  [(0-1)+N:0] q_reg;
  reg  [(0-1)+N:0] q_next;
  reg  DFF1,DFF2;
  wire q_add;
  wire q_reset;

  assign q_reset = DFF2 ^ DFF1;
  assign q_add = ~q_reg[(0-1)+N];
  
  always @(q_reset or q_add or q_reg)
      case ({q_reset,q_add})

        2'b00: q_next <= q_reg;

        2'b01: q_next <= 1+q_reg;

        default: q_next <= {N{1'b0}};

      endcase

  
  always @(posedge clk)
      if (n_reset == 1'b1) 
        begin
          DFF1 <= 1'b0;
          DFF2 <= 1'b0;
          q_reg <= {N{1'b0}};
        end
      else 
        begin
          DFF1 <= button_in;
          DFF2 <= DFF1;
          q_reg <= q_next;
        end
  
  always @(posedge clk)
      if (q_reg[(0-1)+N] == 1'b1) DB_out <= DFF2;
      else DB_out <= DB_out;
endmodule

