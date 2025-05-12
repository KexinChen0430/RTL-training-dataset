module e_mmu (
   mi_data_out, emesh_access_out, emesh_write_out, emesh_datamode_out,
   emesh_ctrlmode_out, emesh_dstaddr_out, emesh_srcaddr_out,
   emesh_data_out,
   clk, mmu_en, mi_access, mi_write, mi_addr, mi_data_in,
   emesh_access_in, emesh_write_in, emesh_datamode_in,
   emesh_ctrlmode_in, emesh_dstaddr_in, emesh_srcaddr_in,
   emesh_data_in
   );
   parameter DW   = 32;        
   parameter AW   = 32;        
   parameter IW   = 12;        
   parameter PAW  = 64;        
   parameter MW   = PAW-AW+IW; 
   parameter MD   = 1<<IW;     
   input              clk;
   input 	      mmu_en;       
   input              mi_access;
   input              mi_write;
   input  [IW:0]      mi_addr;      
   input  [DW-1:0]    mi_data_in;   
   output [DW-1:0]    mi_data_out;
   input              emesh_access_in;
   input              emesh_write_in;
   input [1:0]        emesh_datamode_in;
   input [3:0]        emesh_ctrlmode_in;
   input [AW-1:0]     emesh_dstaddr_in;
   input [AW-1:0]     emesh_srcaddr_in;
   input [DW-1:0]     emesh_data_in;
   output 	      emesh_access_out;
   output 	      emesh_write_out;
   output [1:0]       emesh_datamode_out;
   output [3:0]       emesh_ctrlmode_out;
   output [63:0]      emesh_dstaddr_out;  
   output [AW-1:0]    emesh_srcaddr_out;
   output [DW-1:0]    emesh_data_out;
   wire [63:0] 	      emmu_mem_rd_data;
   wire [63:0] 	      emmu_mem_wr_data;
   wire [7:0] 	      emmu_mem_wr_en;
   wire 	      emmu_write;
   reg 		      emesh_access_out;
   reg 		      emesh_write_out;
   reg [1:0] 	      emesh_datamode_out;
   reg [3:0] 	      emesh_ctrlmode_out;
   reg [AW-1:0]       emesh_srcaddr_out;
   reg [DW-1:0]	      emesh_data_out;
   reg [MW-1:0]       emmu_mem_array[MD-1:0];
   reg [63:0] 	      emmu_table_data_out;
   reg [AW-1:0]       emesh_dstaddr_reg;
   assign emmu_mem_wr_data[63:0] = {mi_data_in[31:0],
			           mi_data_in[31:0]};
   assign emmu_write             = mi_access & mi_write;
   assign emmu_mem_wr_en[7:0]    = (emmu_write & mi_addr[0])  ? 8'b11110000 :
				   (emmu_write & ~mi_addr[0]) ? 8'b00001111 :
				                                8'b00000000;
   memory_dp #(.DW(PAW),.AW(IW))
   memory_dp (
	      .rd_data	(emmu_mmu_rd_data[63:0]),
	      .wr_clk	(clk),
	      .wr_en	(emmu_mem_wr_en[7:0]),     
	      .wr_addr	(mi_addr[IW:1]),           
	      .wr_data	(emmu_mem_wr_data[63:0]),
	      .rd_clk	(clk),
	      .rd_en	(emesh_access_in),
	      .rd_addr	(emesh_dstaddr_in[AW-1:20])
	      );
   always @ (posedge clk or posedge reset)
     emesh_access_out                  <= emesh_access_in;
   always @ (posedge clk)
     if(emesh_access_in)
       begin
	  emesh_write_out              <= emesh_write_in;
	  emesh_data_out[DW-1:0]       <= emesh_data_in[DW-1:0];
	  emesh_srcaddr_out[AW-1:0]    <= emesh_srcaddr_in[AW-1:0];
	  emesh_dstaddr_reg[AW-1:0]    <= emesh_dstaddr_in[AW-1:0];
	  emesh_ctrlmode_out[3:0]      <= emesh_ctrlmode_in[3:0];
	  emesh_datamode_out[1:0]      <= emesh_datamode_in[1:0];
       end
   assign emesh_dstaddr_out[63:0]      = mmu_en ? {emmu_mem_rd_data[MW-1:0],emesh_dstaddr_reg[19:0]} :
				                  {32'b0,emesh_dstaddr_reg[AW-1:0]};
endmodule