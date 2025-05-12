
module input_pipeline(clk,clk_ena,in_stream,pipeline_reg_0,pipeline_reg_1,
                      pipeline_reg_2,pipeline_reg_3,pipeline_reg_4,pipeline_reg_5,
                      pipeline_reg_6,pipeline_reg_7,pipeline_reg_8,pipeline_reg_9,
                      pipeline_reg_10,pipeline_reg_11,pipeline_reg_12,
                      pipeline_reg_13,pipeline_reg_14,pipeline_reg_15,
                      pipeline_reg_16,pipeline_reg_17,pipeline_reg_18,reset);

  parameter  WIDTH = 1;
  input  clk;
  input  clk_ena;
  input  [(0-1)+WIDTH:0] in_stream;
  output [(0-1)+WIDTH:0] pipeline_reg_0;
  output [(0-1)+WIDTH:0] pipeline_reg_1;
  output [(0-1)+WIDTH:0] pipeline_reg_18;
  reg  [(0-1)+WIDTH:0] pipeline_reg_0;
  reg  [(0-1)+WIDTH:0] pipeline_reg_1;
  reg  [(0-1)+WIDTH:0] pipeline_reg_18;
  input  reset;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            pipeline_reg_0 <= 0;
            pipeline_reg_18 <= 0;
          end
        else 
          begin
            if (clk_ena) 
              begin
                pipeline_reg_0 <= in_stream;
                pipeline_reg_1 <= pipeline_reg_0;
                pipeline_reg_18 <= pipeline_reg_17;
              end
              
          end
      end
endmodule

