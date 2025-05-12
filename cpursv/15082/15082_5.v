
module arriaii_round_block(datain,round,datain_width,dataout);

  parameter  round_mode = nearest_integer;
  parameter  operation_mode = output_only;
  parameter  round_width = 15;
  input  [71:0] datain;
  input  round;
  input  [7:0] datain_width;
  output [71:0] dataout;
  reg  sign;
  reg  [71:0] result_tmp;
  reg  [71:0] dataout_tmp;
  reg  [71:0] dataout_value;
  integer i,j;

  
  initial  
  begin
    result_tmp = {72{1'b0}};
  end
  assign dataout = dataout_value;
  
  always @(datain or round)
      begin
        if (round == 1'b0) dataout_value = datain;
        else 
          begin
            j = 0;
            sign = 0;
            dataout_value = datain;
            if (datain_width > round_width) 
              begin
                for (i = datain_width-round_width; i < datain_width; i = 1+i)
                    begin
                      result_tmp[j] = datain[i];
                      j = 1+j;
                    end
                for (i = 0; i < (datain_width+((-round_width)+(0-1))); i = 1+i)
                    begin
                      sign = datain[i] | sign;
                      dataout_value[i] = 1'bX;
                    end
                dataout_value[datain_width+((-round_width)+(0-1))] = 1'bX;
                if (datain[datain_width+((-round_width)+(0-1))] == 1'b0) 
                  begin
                    dataout_tmp = result_tmp;
                  end
                else if ((sign == 1'b1) && 
                         (datain[datain_width+((-round_width)+(0-1))] == 1'b1)) 
                  begin
                    dataout_tmp = result_tmp+1'b1;
                  end
                else 
                  begin
                    if (round_mode == nearest_even) 
                      begin
                        if (result_tmp%2) dataout_tmp = result_tmp+1'b1;
                        else dataout_tmp = result_tmp;
                      end
                    else 
                      begin
                        dataout_tmp = result_tmp+1'b1;
                      end
                  end
                j = 0;
                for (i = datain_width-round_width; i < datain_width; i = 1+i)
                    begin
                      dataout_value[i] = dataout_tmp[j];
                      j = 1+j;
                    end
              end
              
          end
      end
endmodule

