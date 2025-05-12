module ahb_to_ssram (
   HREADYOUT, HRDATA, HRESP, ahb_sram_addr, ahb_sram_en, ahb_sram_enb,
   ahb_sram_wb, ahb_sram_we, ahb_sram_din,
   HCLK, HRESETn, HSEL, HADDR, HTRANS, HSIZE, HWRITE, HWDATA, HREADY,
   sram_ahb_dout
);
parameter AW = 12;
`include "ahb_params.v"
localparam AHB_ADDRESS_PHASE = 1;
localparam AHB_DATA_PHASE    = 2;
localparam AHB_IDLE_PHASE    = 0;
input  wire HCLK;    
input  wire HRESETn; 
input  wire HSEL;    
input  wire [AW-1:0] HADDR;   
input  wire [1:0]    HTRANS;  
input  wire [2:0]    HSIZE;   
input  wire          HWRITE;  
input  wire [31:0]   HWDATA;  
input  wire          HREADY;  
output reg           HREADYOUT; 
output wire [31:0]   HRDATA;    
output wire          HRESP;     
output [AW-1:0]      ahb_sram_addr; 
output               ahb_sram_en;   
output [3:0]         ahb_sram_enb;  
output [3:0]         ahb_sram_wb;   
output               ahb_sram_we;   
input [31:0]         sram_ahb_dout; 
output [31:0]        ahb_sram_din;  
reg [3:0]           byte_sel_a; 
reg [3:0]           byte_sel_r; 
reg data_phase_r;               
reg write_en_r;                 
reg [AW-1:0] haddr_r;           
reg seq_cycle;      
reg nonseq_cycle;   
reg busy_cycle;     
reg idle_cycle;     
always @* begin
   seq_cycle = 0;
   nonseq_cycle = 0;
   busy_cycle   = 0;
   idle_cycle   = 0;
   case(HTRANS[1:0])
     AMBA_AHB_HTRANS_SEQ : begin
        seq_cycle = 1'b1;
     end
     AMBA_AHB_HTRANS_NON_SEQ : begin
        nonseq_cycle = 1'b1;
     end
     AMBA_AHB_HTRANS_BUSY : begin
        busy_cycle = 1'b1;
     end
     AMBA_AHB_HTRANS_IDLE : begin
        idle_cycle = 1'b1;
     end
   endcase
end
assign active_cycle = seq_cycle || nonseq_cycle;
assign read_valid  = active_cycle & HSEL & HREADY & (~HWRITE);
assign write_valid = active_cycle & HSEL & HREADY & HWRITE;
assign rw_cycle = read_valid | write_valid;
always @(HADDR or HSIZE or rw_cycle) begin
   byte_sel_a = 4'b1111;
   if (rw_cycle) begin
      case(HSIZE[2:0])
        AMBA_AHB_HSIZE_8BITS : begin
           case(HADDR[1:0])
             0 : begin
                byte_sel_a = 4'b0001;
             end
             1 : begin
                byte_sel_a = 4'b0010;
             end
             2 : begin
                byte_sel_a = 4'b0100;
             end
             3 : begin
                byte_sel_a = 4'b1000;
             end
             default: begin
             end
           endcase
        end
        AMBA_AHB_HSIZE_16BITS : begin
           byte_sel_a = HADDR[1] ? 4'b1100 : 4'b0011;
        end
        AMBA_AHB_HSIZE_32BITS : begin
           byte_sel_a = 4'b1111;
        end
        default: begin
           byte_sel_a = 4'b1111;
        end
      endcase
   end
end
always @(posedge HCLK or negedge HRESETn) begin
   if(HRESETn == 1'b0) begin
      byte_sel_r <= 4'h0;
      haddr_r <= {AW{1'b0}};
      write_en_r <= 1'h0;
   end
   else begin
      if(HREADY && HREADYOUT) begin
         byte_sel_r <= byte_sel_a;
         write_en_r <= write_valid;
         haddr_r    <= HADDR; 
      end
   end
end
always @(posedge HCLK or negedge HRESETn) begin
   if(HRESETn == 1'b0) begin
      HREADYOUT <= 1'b1;
   end
   else begin
      HREADYOUT <= !(write_en_r & read_valid);
   end
end
assign ahb_sram_addr = write_en_r ? haddr_r : HADDR; 
assign ahb_sram_en   = read_valid | write_en_r;      
assign ahb_sram_we   = write_en_r;                   
assign ahb_sram_wb  = byte_sel_r & {4{write_en_r}};  
assign ahb_sram_enb = byte_sel_r & {4{ahb_sram_en}}; 
assign ahb_sram_din = HWDATA;                        
assign HRDATA  = sram_ahb_dout; 
assign HRESP   = 1'b0;          
endmodule