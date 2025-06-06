
module agnus_blitter_adrgen(input  clk,
                            input  clk7_en,
                            input  reset,
                            input  first_line_pixel,
                            input  [1:0] ptrsel,
                            input  [1:0] modsel,
                            input  enaptr,
                            input  incptr,
                            input  decptr,
                            input  addmod,
                            input  submod,
                            output sign_out,
                            input  [15:0] data_in,
                            input  [8:1] reg_address_in,
                            output [20:1] address_out);

  parameter  BLTAMOD = 9'h064;
  parameter  BLTBMOD = 9'h062;
  parameter  BLTCMOD = 9'h060;
  parameter  BLTDMOD = 9'h066;
  parameter  BLTAPTH = 9'h050;
  parameter  BLTAPTL = 9'h052;
  parameter  BLTBPTH = 9'h04c;
  parameter  BLTBPTL = 9'h04e;
  parameter  BLTCPTH = 9'h048;
  parameter  BLTCPTL = 9'h04a;
  parameter  BLTDPTH = 9'h054;
  parameter  BLTDPTL = 9'h056;
  parameter  CHA = 2'b10;
  parameter  CHB = 2'b01;
  parameter  CHC = 2'b00;
  parameter  CHD = 2'b11;
  wire [1:0] bltptr_sel;
  wire [20:1] bltptr_in;
  reg  [20:16] bltpth[3:0];
  wire [20:16] bltpth_out;
  reg  [15:1] bltptl[3:0];
  wire [15:1] bltptl_out;
  wire [20:1] bltptr_out;
  wire [1:0] bltmod_sel;
  reg  [15:1] bltmod[3:0];
  wire [15:1] bltmod_out;
  reg  [20:1] newptr;
  reg  [20:1] t_newptr;

  assign bltptr_in[20:1] = enaptr ? newptr[20:1] : {data_in[4:0],data_in[15:1]};
  assign bltptr_sel = enaptr ? ptrsel : {reg_address_in[4],reg_address_in[1<<1]};
  
  always @(posedge clk)
      if (clk7_en) 
        begin
          if ((reg_address_in[8:1] == BLTDPTH[8:1]) || 
              (reg_address_in[8:1] == BLTAPTH[8:1]) || 
              ((reg_address_in[8:1] == BLTCPTH[8:1]) || 
(reg_address_in[8:1] == BLTBPTH[8:1]) || enaptr)) bltpth[bltptr_sel] <= bltptr_in[20:16];
            
        end
        
  assign bltpth_out = bltpth[bltptr_sel];
  
  always @(posedge clk)
      if (clk7_en) 
        begin
          if ((reg_address_in[8:1] == BLTDPTL[8:1]) || 
              (reg_address_in[8:1] == BLTCPTL[8:1]) || (reg_address_in[8:1] == BLTAPTL[8:1]) || 
              (enaptr || (reg_address_in[8:1] == BLTBPTL[8:1]))) bltptl[bltptr_sel] <= bltptr_in[15:1];
            
        end
        
  assign bltptl_out = bltptl[bltptr_sel];
  assign bltptr_out = {bltpth_out,bltptl_out};
  assign address_out = (enaptr && first_line_pixel) ? {bltpth[CHD],bltptl[CHD]} : bltptr_out;
  assign bltmod_sel = enaptr ? modsel : reg_address_in[1<<1:1];
  
  always @(posedge clk)
      if (clk7_en) 
        begin
          if (reg_address_in[8:3] == BLTAMOD[8:3]) bltmod[bltmod_sel] <= data_in[15:1];
            
        end
        
  assign bltmod_out = bltmod[modsel];
  
  always @(*)
      if (incptr && !decptr) t_newptr = 20'h1+bltptr_out;
      else if (!incptr && decptr) t_newptr = (0-20'h1)+bltptr_out;
      else t_newptr = bltptr_out;
  
  always @(*)
      if (!submod && addmod) newptr = {{5{bltmod_out[15]}},bltmod_out[15:1]}+t_newptr;
      else if (submod && !addmod) 
        newptr = (0-{{5{bltmod_out[15]}},bltmod_out[15:1]})+t_newptr;
      else newptr = t_newptr;
  assign sign_out = newptr[15];
endmodule

