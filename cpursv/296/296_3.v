
module template_6x4_600x400(clk,hc,vc,matrix_x,matrix_y,lines);

  input  clk;
  input  [10:0] hc;
  input  [10:0] vc;
  output reg [1<<1:0]  matrix_x = 3'd0;
  output reg [1:0]  matrix_y = 2'd0;
  output reg lines;
  parameter  d_col = 8'b1_1001;
  parameter  d_row = 7'b1_1001;
  parameter  zeros_col = 2'd0;
  parameter  zeros_row = 2'd0;
  reg  [7:0]  col = d_col;
  reg  [6:0]  row = d_row;
  reg  [7:0] col_next;
  reg  [6:0] row_next;
  reg  [1<<1:0] matrix_x_next;
  reg  [1:0] matrix_y_next;
  wire [10:0] hc_template,vc_template;
  parameter  CUADRILLA_XI = 212;
  parameter  CUADRILLA_XF = 812;
  parameter  CUADRILLA_YI = 184;
  parameter  CUADRILLA_YF = 584;

  assign hc_template = ((hc <= CUADRILLA_XF) && (hc > CUADRILLA_XI)) ? (hc-CUADRILLA_XI) : 11'd0;
  assign vc_template = ((vc <= CUADRILLA_YF) && (vc > CUADRILLA_YI)) ? (vc+(-CUADRILLA_YI)) : 11'd0;
  
  always @(*)
      if (hc_template == 'd0) {col_next,matrix_x_next} = {d_col,3'd0};
      else if (hc_template > {col,zeros_col}) {col_next,matrix_x_next} = {col+d_col,3'd1+matrix_x};
      else {col_next,matrix_x_next} = {col,matrix_x};
  
  always @(*)
      if (vc_template == 'd0) {row_next,matrix_y_next} = {d_row,2'd0};
      else if (vc_template > {row,zeros_row}) {row_next,matrix_y_next} = {row+d_row,2'd1+matrix_y};
      else {row_next,matrix_y_next} = {row,matrix_y};
  reg  lin_v,lin_v_next;

  reg  lin_h,lin_h_next;

  
  always @(*)
      begin
        if (hc_template > {col,zeros_col}) lin_v_next = 1'b1;
        else lin_v_next = 1'b0;
        if (vc_template > {row,zeros_row}) lin_h_next = 1'b1;
        else if (hc == CUADRILLA_XF) lin_h_next = 1'b0;
        else lin_h_next = lin_h;
      end
  
  always @(posedge clk)
      {col,row,matrix_x,matrix_y} <= {col_next,row_next,matrix_x_next,matrix_y_next};
  
  always @(posedge clk)
      {lin_v,lin_h} <= {lin_v_next,lin_h_next};
  
  always @(*)
      if ((hc == (11'd1+CUADRILLA_XI)) || 
          ((vc == CUADRILLA_YF) || (vc == (CUADRILLA_YI+11'd1)) || 
(hc == CUADRILLA_XF))) lines = 1'b1;
      else if ((lin_v == 1'b1) || (lin_h == 1'b1)) lines = 1'b1;
      else lines = 1'b0;
endmodule

