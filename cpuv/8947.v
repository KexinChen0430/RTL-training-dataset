module clock_0_bit_pipe (
  input            clk1,          
  input            clk2,          
  input            data_in,       
  input            reset_clk1_n,  
  input            reset_clk2_n,  
  output           data_out       
);
reg              data_in_d1 ;
reg              data_out ;
always @(posedge clk1 or negedge reset_clk1_n)
  begin
    if (reset_clk1_n == 0)       
        data_in_d1 <= 0;         
    else if (1)                  
        data_in_d1 <= data_in;   
  end
always @(posedge clk2 or negedge reset_clk2_n)
  begin
    if (reset_clk2_n == 0)       
        data_out <= 0;           
    else if (1)                  
        data_out <= data_in_d1;  
  end
endmodule