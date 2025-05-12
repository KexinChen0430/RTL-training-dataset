
module stratixiv_n_cntr(clk,reset,cout,modulus);

  input  clk;
  input  reset;
  input  [31:0] modulus;
  output cout;
  integer count;
  reg  tmp_cout;
  reg  first_rising_edge;
  reg  clk_last_value;
  reg  cout_tmp;

  
  initial  
  begin
    count = 1;
    first_rising_edge = 1;
    clk_last_value = 0;
  end
  
  always @(reset or clk)
      begin
        if (reset) 
          begin
            count = 1;
            tmp_cout = 0;
            first_rising_edge = 1;
          end
        else 
          begin
            if ((clk_last_value !== clk) && 
                (first_rising_edge && (clk == 1))) 
              begin
                first_rising_edge = 0;
                tmp_cout = clk;
              end
            else if (first_rising_edge == 0) 
              begin
                if (count < modulus) count = 1+count;
                else 
                  begin
                    count = 1;
                    tmp_cout = ~tmp_cout;
                  end
              end
              
          end
        clk_last_value = clk;
      end
  assign cout = tmp_cout;
endmodule

