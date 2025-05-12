module ime_decision (
  cost_NxN_00_i ,
  cost_NxN_01_i ,
  cost_NxN_02_i ,
  cost_NxN_03_i ,
  cost_2NxN_0_i ,
  cost_2NxN_1_i ,
  cost_Nx2N_0_i ,
  cost_Nx2N_1_i ,
  cost_2Nx2N_i  ,
  partition_o   ,
  cost_best_o
  );
  input      [`COST_WIDTH-1    : 0]    cost_NxN_00_i    ;
  input      [`COST_WIDTH-1    : 0]    cost_NxN_01_i    ;
  input      [`COST_WIDTH-1    : 0]    cost_NxN_02_i    ;
  input      [`COST_WIDTH-1    : 0]    cost_NxN_03_i    ;
  input      [`COST_WIDTH-1    : 0]    cost_2NxN_0_i    ;
  input      [`COST_WIDTH-1    : 0]    cost_2NxN_1_i    ;
  input      [`COST_WIDTH-1    : 0]    cost_Nx2N_0_i    ;
  input      [`COST_WIDTH-1    : 0]    cost_Nx2N_1_i    ;
  input      [`COST_WIDTH-1    : 0]    cost_2Nx2N_i     ;
  output reg [1                : 0]    partition_o      ;    
  output reg [`COST_WIDTH-1    : 0]    cost_best_o      ;    
  wire   [`COST_WIDTH-1    : 0]    cost_NxN_w       ;
  wire   [`COST_WIDTH-1    : 0]    cost_2NxN_w      ;
  wire   [`COST_WIDTH-1    : 0]    cost_Nx2N_w      ;
  wire   [`COST_WIDTH-1    : 0]    cost_2Nx2N_w     ;
  wire                             is_NxN_bt_Nx2N   ;
  wire                             is_2NxN_bt_2Nx2N ;
  wire                             is_former_bt     ;
  assign cost_NxN_w   = cost_NxN_00_i + cost_NxN_01_i + cost_NxN_02_i + cost_NxN_03_i ;
  assign cost_Nx2N_w  = cost_Nx2N_0_i + cost_Nx2N_1_i ;
  assign cost_2NxN_w  = cost_2NxN_0_i + cost_2NxN_1_i ;
  assign cost_2Nx2N_w = cost_2Nx2N_i ;
  assign is_NxN_bt_Nx2N   = cost_NxN_w  < cost_Nx2N_w  ;
  assign is_2NxN_bt_2Nx2N = cost_2NxN_w < cost_2Nx2N_w ;
  assign is_former_bt = ( is_NxN_bt_Nx2N   ? cost_NxN_w  : cost_Nx2N_w  )
                      < ( is_2NxN_bt_2Nx2N ? cost_2NxN_w : cost_2Nx2N_w );
  always @(*) begin
    casex( {is_former_bt, is_NxN_bt_Nx2N ,is_2NxN_bt_2Nx2N} )
      3'b0x0  : begin partition_o = 2'b00 ; cost_best_o = cost_2Nx2N_w ; end
      3'b0x1  : begin partition_o = 2'b01 ; cost_best_o = cost_2NxN_w  ; end
      3'b10x  : begin partition_o = 2'b10 ; cost_best_o = cost_Nx2N_w  ; end
      3'b11x  : begin partition_o = 2'b11 ; cost_best_o = cost_NxN_w   ; end
      default : begin partition_o = 2'b00 ; cost_best_o = cost_2Nx2N_w ; end
    endcase
  end
endmodule