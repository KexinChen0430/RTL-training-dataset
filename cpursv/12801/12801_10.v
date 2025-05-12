
module t_ff(q_out,t_in,clock,clear);

  input  t_in,clock,clear;
  output reg q_out;

  
  always @(posedge clock or negedge clear)
      begin
        if (~clear) q_out <= 1'b0;
        else 
          q_out <= ((q_out | t_in) & (t_in ^ (t_in & q_out))) ^ (((t_in & (~q_out | (q_out | t_in))) & q_out) ^ q_out);
      end
endmodule

