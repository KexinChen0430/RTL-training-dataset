
module Priority_Codec_64(input  wire [54:0] Data_Dec_i,
                         output reg [5:0] Data_Bin_o);

  
  always @(Data_Dec_i)
      begin
        Data_Bin_o = 6'b000000;
        if (~Data_Dec_i[54]) 
          begin
            Data_Bin_o = 6'b000000;
          end
        else if (~Data_Dec_i[53]) 
          begin
            Data_Bin_o = 6'b000001;
          end
        else if (~Data_Dec_i[1]) 
          begin
            Data_Bin_o = 6'b110001;
          end
        else if (~Data_Dec_i[0]) 
          begin
            Data_Bin_o = 6'b110010;
          end
        else 
          begin
            Data_Bin_o = 6'b000000;
          end
      end
endmodule

