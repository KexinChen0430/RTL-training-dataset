
module axis_register  #(parameter  DATA_WIDTH = 8)
  (input  wire clk,
   input  wire rst,
   input  wire [DATA_WIDTH-1:0] input_axis_tdata,
   input  wire input_axis_tvalid,
   output wire input_axis_tready,
   input  wire input_axis_tlast,
   input  wire input_axis_tuser,
   output wire [DATA_WIDTH-1:0] output_axis_tdata,
   output wire output_axis_tvalid,
   input  wire output_axis_tready,
   output wire output_axis_tlast,
   output wire output_axis_tuser);

  reg   input_axis_tready_reg = 0;
  reg  [DATA_WIDTH-1:0]  output_axis_tdata_reg = 0;
  reg   output_axis_tvalid_reg = 0;
  reg   output_axis_tlast_reg = 0;
  reg   output_axis_tuser_reg = 0;
  reg  [DATA_WIDTH-1:0]  temp_axis_tdata_reg = 0;
  reg   temp_axis_tvalid_reg = 0;
  reg   temp_axis_tlast_reg = 0;
  reg   temp_axis_tuser_reg = 0;

  assign input_axis_tready = input_axis_tready_reg;
  assign output_axis_tdata = output_axis_tdata_reg;
  assign output_axis_tvalid = output_axis_tvalid_reg;
  assign output_axis_tlast = output_axis_tlast_reg;
  assign output_axis_tuser = output_axis_tuser_reg;
  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            input_axis_tready_reg <= 0;
            output_axis_tdata_reg <= 0;
            output_axis_tvalid_reg <= 0;
            output_axis_tlast_reg <= 0;
            output_axis_tuser_reg <= 0;
            temp_axis_tdata_reg <= 0;
            temp_axis_tvalid_reg <= 0;
            temp_axis_tlast_reg <= 0;
            temp_axis_tuser_reg <= 0;
          end
        else 
          begin
            input_axis_tready_reg <= (~temp_axis_tvalid_reg & (~output_axis_tvalid_reg | ~input_axis_tvalid)) | output_axis_tready;
            if (input_axis_tready_reg) 
              begin
                if (~output_axis_tvalid_reg | output_axis_tready) 
                  begin
                    output_axis_tdata_reg <= input_axis_tdata;
                    output_axis_tvalid_reg <= input_axis_tvalid;
                    output_axis_tlast_reg <= input_axis_tlast;
                    output_axis_tuser_reg <= input_axis_tuser;
                  end
                else 
                  begin
                    temp_axis_tdata_reg <= input_axis_tdata;
                    temp_axis_tvalid_reg <= input_axis_tvalid;
                    temp_axis_tlast_reg <= input_axis_tlast;
                    temp_axis_tuser_reg <= input_axis_tuser;
                  end
              end
            else if (output_axis_tready) 
              begin
                output_axis_tdata_reg <= temp_axis_tdata_reg;
                output_axis_tvalid_reg <= temp_axis_tvalid_reg;
                output_axis_tlast_reg <= temp_axis_tlast_reg;
                output_axis_tuser_reg <= temp_axis_tuser_reg;
                temp_axis_tdata_reg <= 0;
                temp_axis_tvalid_reg <= 0;
                temp_axis_tlast_reg <= 0;
                temp_axis_tuser_reg <= 0;
              end
              
          end
      end
endmodule

