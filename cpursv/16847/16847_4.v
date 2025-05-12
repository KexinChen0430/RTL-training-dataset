
module input_pipeline(clk,clk_ena,in_stream,pipeline_reg_0,pipeline_reg_21,reset);

  parameter  WIDTH = 1;
  input  clk;
  input  clk_ena;
  input  [WIDTH+(-1):0] in_stream;
  output [WIDTH+(-1):0] pipeline_reg_0;
  output [WIDTH+(-1):0] pipeline_reg_21;
  input  reset;
  reg  [WIDTH+(-1):0] pipeline_reg_0;
  reg  [WIDTH+(-1):0] pipeline_reg_21;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            pipeline_reg_0 <= 0;
            pipeline_reg_21 <= 0;
          end
        else 
          begin
            if (clk_ena) 
              begin
                pipeline_reg_0 <= in_stream;
                pipeline_reg_1 <= pipeline_reg_0;
                pipeline_reg_21 <= pipeline_reg_20;
              end
              
          end
      end
endmodule

