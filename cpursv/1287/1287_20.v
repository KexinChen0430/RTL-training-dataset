
module arriaiigz_round_block(datain,round,datain_width,dataout);

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
        if (round == 1'b0) 
          begin
            dataout_value = datain;
          end
        else 
          begin
            j = 0;
            sign = 0;
            dataout_value = datain;
            if (datain_width > round_width) 
              begin
                for (i = (0-round_width)+datain_width; i < datain_width; i = i+1)
                    begin
                      result_tmp[j] = datain[i];
                      j = j+1;
                    end
                for (i = 0; i < (((0-round_width)+datain_width)-1); i = i+1)
                    begin
                      sign = datain[i] | sign;
                      dataout_value[i] = 1'bX;
                    end
                dataout_value[((0-round_width)+datain_width)-1] = 1'bX;
                if (datain[((0-round_width)+datain_width)-1] == 1'b0) 
                  begin
                    dataout_tmp = result_tmp;
                  end
                else if ((sign == 1'b1) && 
                         (datain[((0-round_width)+datain_width)-1] == 1'b1)) 
                  begin
                    dataout_tmp = result_tmp+1'b1;
                  end
                else 
                  begin
                    if (round_mode == nearest_even) 
                      begin
                        if (result_tmp%1<<1) 
                          begin
                            dataout_tmp = result_tmp+1'b1;
                          end
                        else 
                          begin
                            dataout_tmp = result_tmp;
                          end
                      end
                    else 
                      begin
                        dataout_tmp = result_tmp+1'b1;
                      end
                  end
                j = 0;
                for (i = (0-round_width)+datain_width; i < datain_width; i = i+1)
                    begin
                      dataout_value[i] = dataout_tmp[j];
                      j = j+1;
                    end
              end
              
          end
      end
endmodule

