
module input_pipeline(clk,clk_ena,in_stream,pipeline_reg_0,pipeline_reg_1,
                      pipeline_reg_2,pipeline_reg_3,pipeline_reg_4,pipeline_reg_5,
                      pipeline_reg_6,pipeline_reg_7,pipeline_reg_8,pipeline_reg_9,
                      pipeline_reg_10,pipeline_reg_11,pipeline_reg_12,
                      pipeline_reg_13,pipeline_reg_14,pipeline_reg_15,
                      pipeline_reg_16,pipeline_reg_17,pipeline_reg_18,
                      pipeline_reg_19,pipeline_reg_20,pipeline_reg_21,
                      pipeline_reg_22,pipeline_reg_23,pipeline_reg_24,
                      pipeline_reg_25,reset);

  parameter  WIDTH = 1;
  input  clk;
  input  clk_ena;
  input  [(0-1)+WIDTH:0] in_stream;
  output [(0-1)+WIDTH:0] pipeline_reg_0;
  output [(0-1)+WIDTH:0] pipeline_reg_1;
  output [(0-1)+WIDTH:0] pipeline_reg_2;
  output [(0-1)+WIDTH:0] pipeline_reg_3;
  output [(0-1)+WIDTH:0] pipeline_reg_4;
  output [(0-1)+WIDTH:0] pipeline_reg_5;
  output [(0-1)+WIDTH:0] pipeline_reg_6;
  output [(0-1)+WIDTH:0] pipeline_reg_7;
  output [(0-1)+WIDTH:0] pipeline_reg_8;
  output [(0-1)+WIDTH:0] pipeline_reg_9;
  output [(0-1)+WIDTH:0] pipeline_reg_10;
  output [(0-1)+WIDTH:0] pipeline_reg_11;
  output [(0-1)+WIDTH:0] pipeline_reg_12;
  output [(0-1)+WIDTH:0] pipeline_reg_13;
  output [(0-1)+WIDTH:0] pipeline_reg_14;
  output [(0-1)+WIDTH:0] pipeline_reg_15;
  output [(0-1)+WIDTH:0] pipeline_reg_16;
  output [(0-1)+WIDTH:0] pipeline_reg_17;
  output [(0-1)+WIDTH:0] pipeline_reg_18;
  output [(0-1)+WIDTH:0] pipeline_reg_19;
  output [(0-1)+WIDTH:0] pipeline_reg_20;
  output [(0-1)+WIDTH:0] pipeline_reg_21;
  output [(0-1)+WIDTH:0] pipeline_reg_22;
  output [(0-1)+WIDTH:0] pipeline_reg_23;
  output [(0-1)+WIDTH:0] pipeline_reg_24;
  output [(0-1)+WIDTH:0] pipeline_reg_25;
  reg  [(0-1)+WIDTH:0] pipeline_reg_0;
  reg  [(0-1)+WIDTH:0] pipeline_reg_1;
  reg  [(0-1)+WIDTH:0] pipeline_reg_2;
  reg  [(0-1)+WIDTH:0] pipeline_reg_3;
  reg  [(0-1)+WIDTH:0] pipeline_reg_4;
  reg  [(0-1)+WIDTH:0] pipeline_reg_5;
  reg  [(0-1)+WIDTH:0] pipeline_reg_6;
  reg  [(0-1)+WIDTH:0] pipeline_reg_7;
  reg  [(0-1)+WIDTH:0] pipeline_reg_8;
  reg  [(0-1)+WIDTH:0] pipeline_reg_9;
  reg  [(0-1)+WIDTH:0] pipeline_reg_10;
  reg  [(0-1)+WIDTH:0] pipeline_reg_11;
  reg  [(0-1)+WIDTH:0] pipeline_reg_12;
  reg  [(0-1)+WIDTH:0] pipeline_reg_13;
  reg  [(0-1)+WIDTH:0] pipeline_reg_14;
  reg  [(0-1)+WIDTH:0] pipeline_reg_15;
  reg  [(0-1)+WIDTH:0] pipeline_reg_16;
  reg  [(0-1)+WIDTH:0] pipeline_reg_17;
  reg  [(0-1)+WIDTH:0] pipeline_reg_18;
  reg  [(0-1)+WIDTH:0] pipeline_reg_19;
  reg  [(0-1)+WIDTH:0] pipeline_reg_20;
  reg  [(0-1)+WIDTH:0] pipeline_reg_21;
  reg  [(0-1)+WIDTH:0] pipeline_reg_22;
  reg  [(0-1)+WIDTH:0] pipeline_reg_23;
  reg  [(0-1)+WIDTH:0] pipeline_reg_24;
  reg  [(0-1)+WIDTH:0] pipeline_reg_25;
  input  reset;

  
  always @(posedge clk or posedge reset)
      begin
        if (reset) 
          begin
            pipeline_reg_0 <= 0;
            pipeline_reg_1 <= 0;
            pipeline_reg_25 <= 0;
          end
        else 
          begin
            if (clk_ena) 
              begin
                pipeline_reg_0 <= in_stream;
                pipeline_reg_1 <= pipeline_reg_0;
                pipeline_reg_25 <= pipeline_reg_24;
              end
              
          end
      end
endmodule

