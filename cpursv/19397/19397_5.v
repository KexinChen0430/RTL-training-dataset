
module DataDelay(clk,in_data,out_data);

  parameter  data_width = 8;
  parameter  delay = 1;
  input  clk;
  input  [(-1)+data_width:0] in_data;
  output [(-1)+data_width:0] out_data;

  genvar i;
  
  generate
      for (i = 0; i < delay; i = 1+i)
          begin : pip
            reg  [(-1)+data_width:0] tmp;

            if (i == 0) 
              begin
                
                always @(posedge clk)
                    tmp <= in_data;
              end
            else 
              begin
                
                always @(posedge clk)
                    tmp <= pip[i+(-1)].tmp;
              end
          end
      assign out_data = pip[(-1)+delay].tmp;
  endgenerate

endmodule

