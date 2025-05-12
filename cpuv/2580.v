module fp_convert_altbarrel_shift_fof (
    aclr,       
    clk_en,     
    clock,      
    data,       
    distance,   
    result      
);
input   aclr;
input   clk_en;
input   clock;
input   [31:0]  data;
input   [4:0]   distance;
output  [31:0]  result;
`ifndef ALTERA_RESERVED_QIS
`endif
tri0   aclr;
tri1   clk_en;
tri0   clock;
`ifndef ALTERA_RESERVED_QIS
`endif
reg [1:0]   dir_pipe;      
reg [31:0]  sbit_piper1d;  
reg [31:0]  sbit_piper2d;  
reg sel_pipec3r1d;         
reg sel_pipec4r1d;         
wire [5:0]   dir_w;        
wire direction_w;          
wire [15:0]  pad_w;        
wire [191:0] sbit_w;       
wire [4:0]   sel_w;        
wire [159:0] smux_w;       
initial dir_pipe = 0;
always @ (posedge clock or posedge aclr)
    if (aclr == 1'b1) dir_pipe <= 2'b0;
    else if (clk_en == 1'b1) dir_pipe <= {dir_w[4], dir_w[2]};
initial sbit_piper1d = 0;
always @ (posedge clock or posedge aclr)
    if (aclr == 1'b1) sbit_piper1d <= 32'b0;
    else if (clk_en == 1'b1) sbit_piper1d <= smux_w[95:64];
initial sbit_piper2d = 0;
always @ (posedge clock or posedge aclr)
    if (aclr == 1'b1) sbit_piper2d <= 32'b0;
    else if (clk_en == 1'b1) sbit_piper2d <= smux_w[159:128];
initial sel_pipec3r1d = 0;
always @ (posedge clock or posedge aclr)
    if (aclr == 1'b1) sel_pipec3r1d <= 1'b0;
    else if (clk_en == 1'b1) sel_pipec3r1d <= distance[3];
initial sel_pipec4r1d = 0;
always @ (posedge clock or posedge aclr)
    if (aclr == 1'b1) sel_pipec4r1d <= 1'b0;
    else if (clk_en == 1'b1) sel_pipec4r1d <= distance[4];
assign
    dir_w = {dir_pipe[1], dir_w[3], dir_pipe[0], dir_w[1:0], direction_w},
    direction_w = 1'b0, 
    pad_w = {16{1'b0}}, 
    result = sbit_w[191:160], 
    sbit_w = {sbit_piper2d, smux_w[127:96], sbit_piper1d, smux_w[63:0], data},
    sel_w = {sel_pipec4r1d, sel_pipec3r1d, distance[2:0]},
    smux_w = { ... }; 
endmodule