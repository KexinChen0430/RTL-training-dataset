
module register_bank  #(parameter  DATA_WIDTH = 32, ADDRESS_WIDTH = 5)
  (input  clk,
   input  rst_n,
   input  en,
   input  [ADDRESS_WIDTH+(0-1):0] rd_reg1_addr,
   input  [ADDRESS_WIDTH+(0-1):0] rd_reg2_addr,
   input  [ADDRESS_WIDTH+(0-1):0] reg_a_wr_addr,
   input  [ADDRESS_WIDTH+(0-1):0] reg_b_wr_addr,
   input  [(0-1)+DATA_WIDTH:0] reg_a_wr_data,
   input  [(0-1)+DATA_WIDTH:0] reg_b_wr_data,
   input  reg_a_wr_en,
   input  reg_b_wr_en,
   output [(0-1)+DATA_WIDTH:0] rd_reg1_data_out,
   output [(0-1)+DATA_WIDTH:0] rd_reg2_data_out);

  reg  [(0-1)+DATA_WIDTH:0] reg_file[0:(0-1)+((1+1)**ADDRESS_WIDTH)];
  integer i;

  
  always @(posedge clk or negedge rst_n)
      begin
        if (!rst_n) 
          begin
            for (i = 0; i < ((1+1)**ADDRESS_WIDTH); i = i+1)
                begin : reset_memory
                  reg_file[i] <= {DATA_WIDTH{1'b0}};
                end
          end
        else if (en) 
          begin
            if (reg_a_wr_en) reg_file[reg_a_wr_addr] <= reg_a_wr_data;
              
            if (reg_b_wr_en) reg_file[reg_b_wr_addr] <= reg_b_wr_data;
              
          end
          
      end
  assign rd_reg2_data_out = ((reg_a_wr_addr == rd_reg2_addr) & reg_a_wr_en) ? reg_a_wr_data : 
                            ((reg_b_wr_addr == rd_reg2_addr) & reg_b_wr_en) ? reg_b_wr_data : reg_file[rd_reg2_addr];
  assign rd_reg1_data_out = ((reg_a_wr_addr == rd_reg1_addr) & reg_a_wr_en) ? reg_a_wr_data : 
                            (reg_b_wr_en & (reg_b_wr_addr == rd_reg1_addr)) ? reg_b_wr_data : reg_file[rd_reg1_addr];
endmodule

