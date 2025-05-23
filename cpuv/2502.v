module unused_reg
   #(
      parameter REG_ADDR_WIDTH = 5 
   )
   (
      input                                  reg_req, 
      output                                 reg_ack, 
      input                                  reg_rd_wr_L, 
      input [REG_ADDR_WIDTH - 1:0]           reg_addr, 
      output [`CPCI_NF2_DATA_WIDTH - 1:0]    reg_rd_data, 
      input [`CPCI_NF2_DATA_WIDTH - 1:0]     reg_wr_data, 
      input                                  clk, 
      input                                  reset 
   );
reg reg_req_d1;
assign reg_rd_data = 'h dead_beef;
assign reg_ack = reg_req && !reg_req_d1;
always @(posedge clk)
begin
   reg_req_d1 <= reg_req;
end
endmodule