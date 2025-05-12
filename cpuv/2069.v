module etx_protocol (
   etx_rd_wait, etx_wr_wait, tx_packet, tx_access, tx_burst,
   reset, clk, etx_access, etx_packet, tx_enable, gpio_data,
   gpio_enable, tx_io_wait, tx_rd_wait, tx_wr_wait
   );
parameter PW = 104; 
parameter AW = 32;  
parameter DW = 32;  
parameter ID = 12'h000; 
input reset; 
input clk; 
input etx_access; 
input [PW-1:0] etx_packet; 
output etx_rd_wait; 
output etx_wr_wait; 
input tx_enable; 
input [8:0] gpio_data; 
input gpio_enable; 
output [PW-1:0] tx_packet; 
output tx_access; 
output tx_burst; 
input tx_io_wait; 
input tx_rd_wait; 
input tx_wr_wait; 
reg tx_burst; 
reg tx_access; 
reg [PW-1:0] tx_packet; 
reg tx_rd_wait_sync; 
reg tx_wr_wait_sync; 
wire etx_write; 
wire [1:0] etx_datamode; 
wire [3:0] etx_ctrlmode; 
wire [AW-1:0] etx_dstaddr; 
wire [DW-1:0] etx_data; 
wire last_write; 
wire [1:0] last_datamode; 
wire [3:0] last_ctrlmode; 
wire [AW-1:0] last_dstaddr; 
wire etx_valid; 
reg etx_io_wait; 
wire burst_match; 
wire burst_type_match; 
wire [31:0] burst_addr; 
wire burst_addr_match; 
reg etx_rd_wait_reg; 
reg etx_wr_wait_reg; 
packet2emesh p2m0 (.access_out (),
                   .write_out (etx_write),
                   .datamode_out (etx_datamode[1:0]),
                   .ctrlmode_out (etx_ctrlmode[3:0]),
                   .dstaddr_out (etx_dstaddr[31:0]),
                   .data_out (),
                   .srcaddr_out (),
                   .packet_in (etx_packet[PW-1:0]));
assign etx_valid = (tx_enable &
                    etx_access &
                    ~((etx_dstaddr[31:20]==ID) & (etx_dstaddr[19:16]!=`EGROUP_RR)) &
                    ((etx_write & ~tx_wr_wait_sync) | (~etx_write & ~tx_rd_wait_sync)));
always @ (posedge clk)
  if(reset)
    begin
       tx_packet[PW-1:0] <= 'b0;
       tx_access         <= 1'b0;
    end
  else if(~tx_io_wait)
    begin
       tx_packet[PW-1:0] <= etx_packet[PW-1:0];
       tx_access         <= etx_valid;
    end
packet2emesh p2m1 (.access_out (last_access),
                   .write_out (last_write),
                   .datamode_out (last_datamode[1:0]),
                   .ctrlmode_out (last_ctrlmode[3:0]),
                   .dstaddr_out (last_dstaddr[31:0]),
                   .data_out (),
                   .srcaddr_out (),
                   .packet_in (tx_packet[PW-1:0]));
assign burst_addr[31:0]  = (last_dstaddr[31:0] + 4'd8);
assign burst_addr_match  = (burst_addr[31:0] == etx_dstaddr[31:0]);
assign burst_type_match  = {last_ctrlmode[3:0],last_datamode[1:0],last_write}
                           ==
                           {etx_ctrlmode[3:0],etx_datamode[1:0], etx_write};
always @ (posedge clk)
   if(reset) begin
   tx_wr_wait_sync <= 1'b0;
   tx_rd_wait_sync <= 1'b0;
   end
   else begin
      tx_wr_wait_sync <= tx_wr_wait;
      tx_rd_wait_sync <= tx_rd_wait;
   end
always @ (posedge clk) begin
   etx_wr_wait_reg <= tx_wr_wait | tx_io_wait;
   etx_rd_wait_reg <= tx_rd_wait | tx_io_wait;
end
assign etx_wr_wait = etx_wr_wait_reg;
assign etx_rd_wait = etx_rd_wait_reg;
endmodule