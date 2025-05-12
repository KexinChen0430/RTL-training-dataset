
module stratixiii_termination_aux_clock_div(clk,reset,clkout);

  input  clk;
  input  reset;
  output clkout;
  parameter  clk_divide_by = 1;
  parameter  extra_latency = 0;
  integer clk_edges,m;
  reg  [extra_latency<<<1:0] div_n_register;

  
  initial  
  begin
    div_n_register = 'b0;
    clk_edges = -1;
    m = 0;
  end
  
  always @(posedge clk or negedge clk or posedge reset)
      begin
        if (reset === 1'b1) 
          begin
            clk_edges = -1;
            div_n_register <= 'b0;
          end
        else 
          begin
            if (clk_edges == -1) 
              begin
                div_n_register[0] <= clk;
                if (clk == 1'b1) clk_edges = 0;
                  
              end
            else if ((clk_edges%clk_divide_by) == 0) div_n_register[0] <= ~div_n_register[0];
              
            if ((clk_edges >= 0) || (clk == 1'b1)) 
              clk_edges = (((((((((((((((((((((((((((clk_edges%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)+((((((((((((((((((((((((((1%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1)%clk_divide_by<<1))%clk_divide_by<<1;
              
          end
        for (m = 0; m < extra_latency<<<1; m = 1+m)
            div_n_register[1+m] <= div_n_register[m];
      end
  assign clkout = div_n_register[extra_latency<<<1];
endmodule

