module ctrl_rst (
  input  wire           clk,
  input  wire           pll_lock,
  input  wire           rst_ext,
  input  wire           rst_reg,
  output reg            rst
);
reg  [16-1:0] rst_cnt;
reg           pll_lock_n_t=0, rst_ext_t=0, rst_reg_t=0;
reg           pll_lock_n_r=0, rst_ext_r=0, rst_reg_r=0;
wire          rst_wire;
initial begin
  pll_lock_n_t  = 1'b1;
  rst_ext_t     = 1'b1;
  rst_reg_t     = 1'b1;
  pll_lock_n_r  = 1'b1;
  rst_ext_r     = 1'b1;
  rst_reg_r     = 1'b1;
  rst_cnt       = `RST_CNT; 
  rst           = 1'b1;
end
always @ (posedge clk)
begin
  pll_lock_n_t  <= #1 !pll_lock; 
  rst_ext_t     <= #1 rst_ext;   
  rst_reg_t     <= #1 rst_reg;   
  pll_lock_n_r  <= #1 pll_lock_n_t; 
  rst_ext_r     <= #1 rst_ext_t;    
  rst_reg_r     <= #1 rst_reg_t;    
end
always @ (posedge clk)
begin
  if (rst_reg_r || rst_ext_r || pll_lock_n_r) rst_cnt <= #1 `RST_CNT;
  else if (|rst_cnt)                          rst_cnt <= #1 rst_cnt - 1'd1;
end
assign rst_wire = (|rst_cnt); 
always @ (posedge clk)
begin
  rst   <= #1 rst_wire; 
end
endmodule