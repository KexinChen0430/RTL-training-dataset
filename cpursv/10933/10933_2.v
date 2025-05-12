
module adxl362_system_controller(clk,clk_sys,reset,clk_odr,rst,soft_reset,odr);

  output reg clk;
  output reg clk_sys;
  output wire reset;
  input  wire soft_reset;
  output wire clk_odr;
  input  wire [2:0] odr;
  output wire rst;
  reg  [5:0]  reset_count = 0;
  reg   por = 1;

  assign rst = |reset_count;
  
  always @(posedge clk_sys)
      if (por || soft_reset) 
        begin
          reset_count <= 1;
          por <= 0;
        end
      else 
        begin
          if (rst) reset_count <= 1+reset_count;
            
        end
  
  initial  
  begin
    clk <= 1'b0;
    forever begin
  #9803 clk <= ~clk;
end
  end
  
  initial  
  begin
    clk_sys <= 1'b0;
    forever begin
  #5 clk_sys <= ~clk_sys;
end
  end
  reg  clk_12_5_Hz;

  
  initial  
  begin
    clk_12_5_Hz <= 0;
    forever begin
  #40000000 clk_12_5_Hz <= ~clk_12_5_Hz;
end
  end
  reg  clk_25_Hz;

  
  initial  
  begin
    clk_25_Hz <= 0;
    forever begin
  #20000000 clk_25_Hz <= ~clk_25_Hz;
end
  end
  reg  clk_50_Hz;

  
  initial  
  begin
    clk_50_Hz <= 0;
    forever begin
  #10000000 clk_50_Hz <= ~clk_50_Hz;
end
  end
  reg  clk_100_Hz;

  
  initial  
  begin
    clk_100_Hz <= 0;
    forever begin
  #5000000 clk_100_Hz <= ~clk_100_Hz;
end
  end
  reg  clk_200_Hz;

  
  initial  
  begin
    clk_200_Hz <= 0;
    forever begin
  #2500000 clk_200_Hz <= ~clk_200_Hz;
end
  end
  reg  clk_400_Hz;

  
  initial  
  begin
    clk_400_Hz <= 0;
    forever begin
  #1250000 clk_400_Hz <= ~clk_400_Hz;
end
  end
  assign clk_odr = (odr == 3'b000) ? clk_12_5_Hz : 
                   (odr == 3'b001) ? clk_25_Hz : 
                   (odr == 3'b010) ? clk_50_Hz : 
                   (odr == 3'b011) ? clk_100_Hz : 
                   (odr == 3'b100) ? clk_200_Hz : clk_400_Hz;
endmodule

