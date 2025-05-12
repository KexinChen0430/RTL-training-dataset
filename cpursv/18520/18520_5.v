
module counter_load_out_collaps_free(clk,rst,clk_ena,clk_ena_job,load,carry,dfload,dout);

  parameter  MOD_COUNT = 7;
  parameter  WIDTH = 8;
  input  clk,rst,clk_ena;
  input  clk_ena_job;
  input  load;
  input  [(0-1)+WIDTH:0] dfload;
  output carry;
  reg  carry_tmp;

  assign carry = carry_tmp;
  wire  loco = load & clk_ena_job;

  reg  [(0-1)+WIDTH:0] count;

  output [(0-1)+WIDTH:0] dout;

  
  always @(posedge clk or posedge rst)
      begin
        if (rst) count <= 0;
        else if (clk_ena) 
          begin
            if (load) count <= 0;
              
            if (clk_ena_job) count <= count+1;
              
            if (load & clk_ena_job) count <= 1;
              
          end
          
      end
  
  always @(count)
      begin
        if (count == ((0-1)+MOD_COUNT)) carry_tmp = 'b1;
        else carry_tmp = 'b0;
      end
  assign dout = count;
endmodule

