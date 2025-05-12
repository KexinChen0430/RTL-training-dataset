module twi_core (
input        clk    , 
input        rst    , 
input        wr     , 
input  [7:0] data_in,
input  [7:0] wr_addr,
output [7:0] i2cr   , 
output [7:0] i2rd   , 
output twi_scl_o    , 
input  twi_sda_i    , 
output twi_sda_oen  
);
parameter TWI_F     = 3 ; 
parameter START_SDA = 600/TWI_F+1 ; 
parameter SDA_SET   = 700/TWI_F+1 ; 
parameter SDA_WAIT  = 600/TWI_F+1 ; 
parameter START_SCL = START_SDA+100/TWI_F+1 ; 
parameter TWI_DONE  = START_SCL+1300/TWI_F+1 ; 
parameter STOP_SCL  = 100/TWI_F+1 ; 
reg [7:0] rd_buf ; 
reg [11:0] cnt ; 
reg done ; 
reg [3:0] byte_cnt ; 
reg [7:0] i2wd_r ; 
reg [7:0] i2rd_r ; 
assign i2wd = i2wd_r ; 
assign i2rd = rd_buf ; 
reg en_r , init_r ; 
reg [2:0] cmd_r ; 
wire cmd_start = cmd_r == 3'b000 && en_r ; 
wire cmd_wr    = cmd_r == 3'b001 && en_r ; 
wire cmd_rd    = cmd_r == 3'b010 && en_r ; 
wire cmd_stop  = cmd_r == 3'b011 && en_r ; 
wire cmd_rd_no = cmd_r == 3'b100 && en_r ; 
assign i2cr = {1'b0,cmd_r,1'b0,done,init_r,en_r}; 
always @ ( posedge clk ) begin
	if( rst ) begin
		en_r   <= 1'b0 ; 
		init_r <= 1'b0 ; 
		cmd_r  <= 3'b0 ; 
	end
	else if( wr_addr == `I2CR && wr ) begin
		en_r   <= data_in[0] ; 
		init_r <= data_in[1] ; 
		cmd_r  <= data_in[6:4] ; 
	end
	else begin
		init_r <= 1'b0 ; 
	end
end