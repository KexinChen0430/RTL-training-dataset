
module register_bank  #(parameter 
       DATA_WIDTH        = 16,
       REGISTER_ID_WIDTH = 4,
       REGISTER_COUNT    = 8)
  (input  clk_i,
   input  rst_i,
   input  alu_active_i,
   input  [(0-1)+DATA_WIDTH:0] alu_result_i,
   input  [REGISTER_ID_WIDTH+(0-1):0] choose_register_i1,
   input  [REGISTER_ID_WIDTH+(0-1):0] choose_register_i2,
   input  [(0-1)+DATA_WIDTH:0] load_value_i,
   input  mem_read_rdy_i,
   input  register_active_i,
   input  [(0-1)+DATA_WIDTH:0] register_input,
   output reg [(0-1)+DATA_WIDTH:0] register_output1,
   output reg [(0-1)+DATA_WIDTH:0] register_output2);

  reg  [(0-1)+DATA_WIDTH:0] registers[REGISTER_COUNT-1:0];
  integer index;

  
  always @* 
      begin
        register_output1 <= registers[choose_register_i1];
        register_output2 <= registers[choose_register_i2];
      end
  
  always @(posedge clk_i or posedge rst_i)
      begin
        if (rst_i == 1'b1) 
          begin
            for (index = 0; index < REGISTER_COUNT; index = index+1)
                begin
                  registers[index] <= 0;
                end
          end
        else 
          begin
            if (alu_active_i) 
              begin
                registers[choose_register_i1] <= alu_result_i;
              end
            else if (mem_read_rdy_i) 
              begin
                registers[choose_register_i1] <= load_value_i;
              end
            else if (register_active_i) 
              begin
                registers[choose_register_i1] <= register_input[(0-1)+DATA_WIDTH:0];
              end
              
          end
      end
endmodule

