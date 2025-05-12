module de3d_tfog
(
input       de_clk,         
input       hb_csn,         
input       hb_tfog_en,     
input       hb_wstrb,       
input       [6:2]   hb_addr,        
input       [7:0]   hb_ben,         
input       [31:0]  hb_din,         
input       [13:0]  zvalue,         
input       pc_busy,
output      [31:0]  hb_dout,        
output      [7:0]   fog_factor      
);
reg     [8:0]   z_diff_d;   
reg     [7:0]   low_factor_d, low_factor_dd;
reg     [7:0]   fog_factor;
reg     [7:0]   zvalue_d;   
reg     [8:0]   z_add_d;    
wire    [5:0]   z_low, z_hi;    
wire    [8:0]   z_diff;     
wire    [18:0]  z_add;      
wire    [8:0]   fog_factor_s;   
wire    [7:0]   low_factor,    
                high_factor;   
wire    [7:0]   fog64;     
wire    [7:0]   high_factor_add;
always @(posedge de_clk) begin
  if (!busy3) fog_factor = fog_factor_s[7:0];
  if (!busy2) begin
    z_add_d = z_add[18:10];
    low_factor_dd = low_factor_d;
  end
  if (!pc_busy) begin
    z_diff_d = z_diff;
    low_factor_d = low_factor;
    zvalue_d = zvalue[7:0];
  end
end
assign z_low = zvalue[13:8];   
assign z_hi = z_low + 1;   
assign high_factor_add = (&z_low) ? fog64 : high_factor;
DED_FOG_TABLE  FOG_TABLE
    (
    (~hb_csn && hb_tfog_en),
    hb_wstrb,
    hb_addr,
    hb_ben,
    hb_din,
    z_low,
    z_hi,
    hb_dout,
    low_factor,
    high_factor,
    fog64
    );
assign z_diff = high_factor_add - low_factor;
MULT9SX10U  MULT9sx10u   (z_add, z_diff_d, {zvalue_d,2'b0});
assign fog_factor_s = {1'b0,low_factor_dd} + z_add_d;
endmodule