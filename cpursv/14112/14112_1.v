
module ID_stage(clk,rst,ID_stall,ID_flush,EX_stall,ID_reg_dst,ID_data_a,
                ID_data_b,ID_data_c,ID_aluc,ID_sign,ID_memread,ID_memwrite,
                ID_memaddr,ID_load_op,ID_store_op,ID_memtoreg,ID_regwrite,
                EX_data_a,EX_data_b,EX_data_c,EX_aluc,EX_sign,EX_memread,
                EX_memwrite,EX_memaddr,EX_load_op,EX_store_op,EX_memtoreg,
                EX_regwrite);

  input  clk;
  input  rst;
  input  ID_stall;
  input  ID_flush;
  input  EX_stall;
  input  [4:0] ID_reg_dst;
  input  [31:0] ID_data_a,ID_data_b,ID_data_c;
  input  [20:0] ID_aluc;
  input  ID_sign;
  input  ID_memread,ID_memwrite;
  input  [31:0] ID_memaddr;
  input  [8:0] ID_load_op;
  input  [5:0] ID_store_op;
  input  ID_memtoreg,ID_regwrite;
  output reg [31:0] EX_data_a,EX_data_b,EX_data_c;
  output reg [20:0] EX_aluc;
  output reg EX_sign;
  output reg EX_memread,EX_memwrite;
  output reg [31:0] EX_memaddr;
  output reg [8:0] EX_load_op;
  output reg [5:0] EX_store_op;
  output reg EX_memtoreg,EX_regwrite;

  
  always @(posedge clk)
      begin
        EX_data_a <= rst ? 32'b0 : 
                    EX_stall ? EX_data_a : ID_data_a;
        EX_data_b <= rst ? 32'b0 : 
                    EX_stall ? EX_data_b : ID_data_b;
        EX_data_c <= rst ? 32'b0 : 
                    EX_stall ? EX_data_c : ID_data_c;
        EX_aluc <= rst ? 21'b0 : 
                  EX_stall ? EX_aluc : 
                  (ID_flush | ID_stall) ? 21'b0 : ID_aluc;
        EX_sign <= rst ? 0 : 
                  EX_stall ? EX_sign : ID_sign;
        EX_memread <= rst ? 0 : 
                     EX_stall ? EX_memread : 
                     (ID_flush | ID_stall) ? 0 : ID_memread;
        EX_memwrite <= rst ? 0 : 
                      EX_stall ? EX_memwrite : 
                      (ID_flush | ID_stall) ? 0 : ID_memwrite;
        EX_memaddr <= rst ? 0 : 
                     EX_stall ? EX_memaddr : 
                     (ID_flush | ID_stall) ? 0 : ID_memaddr;
        EX_load_op <= rst ? 9'b0 : 
                     EX_stall ? EX_load_op : ID_load_op;
        EX_store_op <= rst ? 6'b0 : 
                      EX_stall ? EX_store_op : ID_store_op;
        EX_regwrite <= rst ? 0 : 
                      EX_stall ? EX_regwrite : 
                      (ID_flush | ID_stall) ? 0 : ID_regwrite;
        EX_memtoreg <= rst ? 0 : 
                      EX_stall ? EX_memtoreg : ID_memtoreg;
      end
endmodule

