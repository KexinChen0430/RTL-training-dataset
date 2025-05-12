
module sign_inverter  #(parameter  W = 32)
  (input  wire [(0-1)+W:0] data,
   input  wire [1:0] shift_region_flag,
   input  wire operation,
   output reg [(0-1)+W:0] data_out);

  
  always @* 
      begin
        if (operation == 1'b0) 
          begin
            if ((shift_region_flag == 2'b11) || 
                (shift_region_flag == 2'b00)) 
              begin
                data_out = data;
              end
            else 
              begin
                if ((shift_region_flag == 2'b01) && 
                    (data[(0-1)+W] == 1'b0)) 
                  begin
                    data_out = {1'b1,data[(-2)+W:0]};
                  end
                else if ((data[(0-1)+W] == 1'b1) && 
                         (shift_region_flag == 2'b01)) 
                  begin
                    data_out = {1'b0,data[(-2)+W:0]};
                  end
                else 
                  begin
                    data_out = data;
                  end
              end
          end
        else 
          begin
            if ((shift_region_flag == 2'b11) || 
                (shift_region_flag == 2'b00)) 
              begin
                data_out = data;
              end
            else 
              begin
                if ((shift_region_flag == 2'b10) && 
                    (data[(0-1)+W] == 1'b0)) 
                  begin
                    data_out = {1'b1,data[(-2)+W:0]};
                  end
                else if ((shift_region_flag == 2'b10) && 
                         (data[(0-1)+W] == 1'b1)) 
                  begin
                    data_out = {1'b0,data[(-2)+W:0]};
                  end
                else 
                  begin
                    data_out = data;
                  end
              end
          end
      end
endmodule

