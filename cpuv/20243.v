module ded_funshf
    #(parameter BYTES = 4) 
    (
     input          mclock, 
     `ifdef BYTE16 input [6:0]    rad,  
     `elsif BYTE8  input [5:0]    rad,  
     `else         input [4:0]    rad, `endif   
     input [(BYTES<<3)-1:0]  bsd0,      
     input [(BYTES<<3)-1:0]  bsd1,      
     input          apat8_4,    
     input          apat32_4,   
     output reg [(BYTES<<3)-1:0]        bsout,  
     output     [BYTES-1:0]             cx_sel  
     );
  `ifdef BYTE16 reg [6:0]           rad_1, rad_d;       
  `elsif BYTE8  reg  [5:0]          rad_1, rad_d;       
  `else         reg  [4:0]          rad_1, rad_d; `endif
  reg [(BYTES<<4)-1:0]      bsin;               
  reg [31:0]        bpck_dat; 
  reg [4:0]         cx_rad;   
  wire [1:0]        n_a32_rad; 
  wire [1:0]        a32_rad;   
  wire [3:0]        bso_sel;   
  wire [127:0]      bs1;       
  wire [135:0]      bs2;       
  wire [151:0]      bs4;       
  wire [183:0]      bs8;       
  wire [BYTES-1:0]     cx1;
  wire [BYTES:0]       cx2;
  wire [BYTES+2:0]     cx4;
  wire [BYTES+6:0]     cx8;
  wire [BYTES+14:0]    cx16;
  always @(posedge mclock) begin
    rad_1 <= rad;
    rad_d <= rad_1;
    bsin  <= {bsd1,bsd0};
  end
  assign n_a32_rad = {2{~apat32_4}} & rad_d[4:3];
  `ifdef BYTE16
    assign bso_sel = {rad_d[6:5],n_a32_rad};
    always @*
      bsout = bs1;
    assign bs1 = bso_sel[0] ? bs2[135:8] : bs2[127:0];
    assign bs2 = bso_sel[1] ? bs4[151:16] : bs4[135:0];
    assign bs4 = bso_sel[2] ? bs8[183:32] : bs8[151:0];
    assign bs8 = bso_sel[3] ? bsin[247:64] : bsin[183:0];
  `endif
  `ifdef BYTE8
    always @*
      case ({rad_d[5],n_a32_rad})
        3'h0: bsout = bsin[63:0];
        3'h1: bsout = bsin[71:8];
        3'h2: bsout = bsin[79:16];
        3'h3: bsout = bsin[87:24];
        3'h4: bsout = bsin[95:32];
        3'h5: bsout = bsin[103:40];
        3'h6: bsout = bsin[111:48];
        3'h7: bsout = bsin[119:56];
      endcase
  `endif
  `ifdef BYTE4
    always @*
      case (n_a32_rad)
        2'h0: bsout = bsin[31:0];
        2'h1: bsout = bsin[39:8];
        2'h2: bsout = bsin[47:16];
        2'h3: bsout = bsin[55:24];
      endcase
  `endif
  assign a32_rad = {2{apat32_4}} & rad_d[4:3];
  always @(posedge mclock) begin
    bpck_dat <= (apat8_4) ? {4{bsout[7:0]}} : bsout[31:0];
    cx_rad   <= {a32_rad, rad_d[2:0]};
  end
  `ifdef BYTE16
    assign cx_sel = cx1;
    assign cx1  = cx_rad[0] ? cx2[16:1] :  cx2[15:0];
    assign cx2  = cx_rad[1] ? cx4[18:2] :  cx4[16:0];
    assign cx4  = cx_rad[2] ? cx8[22:4] :  cx8[18:0];
    assign cx8  = cx_rad[3] ? cx16[30:8] : cx16[22:0];
    assign cx16 = cx_rad[4] ? {bpck_dat[14:0],bpck_dat[31:16]} : bpck_dat[30:0];
  `endif
  `ifdef BYTE8
    assign cx_sel = cx1;
    assign cx1  = cx_rad[0] ?  cx2[8:1] :  cx2[7:0];
    assign cx2  = cx_rad[1] ?  cx4[10:2] :  cx4[8:0];
    assign cx4  = cx_rad[2] ?  cx8[14:4] :  cx8[10:0];
    assign cx8  = cx_rad[3] ? cx16[22:8] : cx16[14:0];
    assign cx16 = cx_rad[4] ? {bpck_dat[6:0],bpck_dat[31:16]} : bpck_dat[22:0];
  `endif
  `ifdef BYTE4
    assign cx_sel = cx1;
    assign cx1  = cx_rad[0] ?  cx2[4:1] :  cx2[3:0];
    assign cx2  = cx_rad[1] ?  cx4[6:2] :  cx4[4:0];
    assign cx4  = cx_rad[2] ?  cx8[10:4] :  cx8[6:0];
    assign cx8  = cx_rad[3] ? cx16[18:8] : cx16[10:0];
    assign cx16 = cx_rad[4] ? {bpck_dat[3:0],bpck_dat[31:16]} : bpck_dat[18:0];
  `endif
endmodule