module sram_interface #(  
  parameter MSZ = 6*1024,       
  parameter MAW = 13,  
  parameter MDW = 32            
)(
  input  wire           clk,  
  input  wire           rst,  
  input  wire           wrFlags,  
  input  wire     [3:0] config_data,  
  input  wire           write,  
  input  wire           lastwrite,  
  input  wire [MDW-1:0] wrdata,  
  input  wire           rd_ready,  
  output reg            rd_valid,  
  output reg      [3:0] rd_keep,  
  output wire [MDW-1:0] rd_data  
);
reg init, next_init;
reg [1:0] mode, next_mode;
reg [3:0] validmask, next_validmask;
reg [3:0] clkenb, next_clkenb;
reg [MAW-1:0] address, next_address;
reg [3:0] next_rd_keep;
wire maxaddr = &address[MAW-1-2:0] & address[MAW-1]; 
wire addrzero = ~|address;
initial
begin
  init = 1'b0;  
  mode = 2'b00;  
  validmask = 4'hF;  
  clkenb = 4'b1111;  
  address = 0;  
  rd_keep = 4'b0000;  
  rd_valid = 1'b0;  
end
always @ (posedge clk)  
begin
  init      <= next_init;  
  mode      <= next_mode;  
  validmask <= next_validmask;  
  clkenb    <= next_clkenb;  
  address   <= next_address;  
  rd_keep   <= next_rd_keep;  
  rd_valid  <=|next_rd_keep;  
end
always @*  
begin
  next_init = 1'b0;  
  next_mode = mode;  
  next_validmask = validmask;  
  next_clkenb = clkenb;  
  next_address = address;  
  next_rd_keep = clkenb & validmask;  
  if (wrFlags)  
    begin
      next_init = 1'b1;  
      next_mode = 0; 
      case (config_data)  
        4'b1100, 4'b0011, 4'b0110, 4'b1001, 4'b1010, 4'b0101 : next_mode = 2'b10; 
        4'b1110, 4'b1101, 4'b1011, 4'b0111 : next_mode = 2'b01; 
      endcase
      next_validmask = 4'hF;  
      case (config_data)  
        4'b0001, 4'b0010, 4'b0100, 4'b1000 : next_validmask = 4'h7;  
      endcase
    end
  casex ({write && !lastwrite, rd_ready})  
    2'b1x : 
      begin
        next_clkenb = 4'b1111;  
        casex (mode[1:0])  
          2'bx1 : next_clkenb = {clkenb[2:0],clkenb[3]};   
          2'b1x : next_clkenb = {clkenb[1:0],clkenb[3:2]}; 
        endcase
        if (clkenb[3]) next_address = (maxaddr) ? 0 : address+1'b1;  
      end
    2'bx1 :  
      begin
        next_clkenb = 4'b1111;  
        casex (mode[1:0])  
          2'bx1 : next_clkenb = {clkenb[0],clkenb[3:1]};   
          2'b1x : next_clkenb = {clkenb[1:0],clkenb[3:2]}; 
        endcase
        if (clkenb[0]) next_address = (addrzero) ? MSZ-1 : address-1'b1;  
      end
  endcase
  if (init)  
    begin
      next_clkenb = 4'b1111;  
      casex (mode[1:0])  
        2'bx1 : next_clkenb = 4'b0001; 
        2'b1x : next_clkenb = 4'b0011; 
      endcase
      next_address = 0;  
    end
end
reg [MDW-1:0] ram_datain;  
always @*  
begin
  ram_datain = wrdata;  
  casex (mode[1:0])  
    2'bx1 : ram_datain[31:0] = {wrdata[7:0],wrdata[7:0],wrdata[7:0],wrdata[7:0]}; 
    2'b1x : ram_datain[31:0] = {wrdata[15:0],wrdata[15:0]}; 
  endcase
end
`ifdef XC3S250E  
genvar i;  
generate
for (i=0; i<4; i=i+1) begin : mem  
  reg [8-1:0] mem1 [0:2048-1];  
  reg [8-1:0] mem0 [0:4096-1];  
  reg [8-1:0] rd_data1;  
  reg [8-1:0] rd_data0;  
  reg         adr_reg;  
  always @ (posedge clk)  if (write & clkenb[i] &  address[12]) mem1 [address[10:0]] <= ram_datain[i*8+:8];  
  always @ (posedge clk)  if (write & clkenb[i] & ~address[12]) mem0 [address[10:0]] <= ram_datain[i*8+:8];  
  always @ (posedge clk)  rd_data1 <= mem1 [address[10:0]];  
  always @ (posedge clk)  rd_data0 <= mem0 [address[11:0]];  
  always @ (posedge clk) adr_reg <= address[12];  
  assign rd_data [i*8+:8] = adr_reg ? rd_data1 : rd_data0;  
end
endgenerate
`else  
genvar i;  
generate
for (i=0; i<4; i=i+1) begin : mem  
  reg [8-1:0] mem [0:MSZ-1];  
  reg [8-1:0] mem_rdt;  
  always @ (posedge clk)
  if (write & clkenb[i]) mem [address] <= ram_datain[i*8+:8];  
  always @ (posedge clk)
  mem_rdt <= mem [address];  
  assign rd_data [i*8+:8] = mem_rdt;  
end
endgenerate
`endif
endmodule  