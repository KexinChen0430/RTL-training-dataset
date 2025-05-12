module pipeline (clk, reset, a_bus, a_busD, b_bus, b_busD, alu_func, alu_funcD,
                 shift_func, shift_funcD, mult_func, mult_funcD, reg_dest,
                 reg_destD, rd_index, rd_indexD, rs_index, rt_index, pc_source,
                 mem_source, a_source, b_source, c_source, c_bus, pause_any,
                 pause_pipeline);
   input         clk; 
   input         reset; 
   input  [31:0] a_bus; 
   input  [31:0] b_bus; 
   input  [ 3:0] alu_func; 
   input  [ 1:0] shift_func; 
   input  [ 3:0] mult_func; 
   input  [31:0] reg_dest; 
   input  [ 5:0] rd_index; 
   input  [ 5:0] rs_index; 
   input  [ 5:0] rt_index; 
   input  [ 1:0] pc_source; 
   input  [ 3:0] mem_source; 
   input  [ 1:0] a_source; 
   input  [ 1:0] b_source; 
   input  [ 2:0] c_source; 
   input  [31:0] c_bus; 
   input         pause_any; 
   output [31:0] a_busD; 
   output [31:0] b_busD; 
   output [ 3:0] alu_funcD; 
   output [ 1:0] shift_funcD; 
   output [ 3:0] mult_funcD; 
   output [31:0] reg_destD; 
   output [ 5:0] rd_indexD; 
   output        pause_pipeline; 
   reg    [31:0] a_busD; 
   reg    [31:0] b_busD; 
   reg    [ 3:0] alu_funcD; 
   reg    [ 1:0] shift_funcD; 
   reg    [ 3:0] mult_funcD; 
   reg    [ 5:0] rd_index_reg; 
   reg    [31:0] reg_dest_reg; 
   reg    [31:0] reg_dest_delay; 
   reg    [ 2:0] c_source_reg; 
   reg           pause_mult_clock; 
   reg           pause_enable_reg; 
   wire   [31:0] reg_destD       = reg_dest_delay ; 
   wire   [ 5:0] rd_indexD       = rd_index_reg ; 
   wire          pause_pipeline  = pause_mult_clock & pause_enable_reg ; 
   wire          freeze_pipeline = ~(pause_mult_clock & pause_enable_reg) & pause_any; 
   always @(posedge clk or posedge reset) begin
      if (reset) begin 
         pause_enable_reg <= 1'b1 ;
         rd_index_reg     <= 6'b000000 ;
         a_busD           <= `ZERO;
         b_busD           <= `ZERO;
         alu_funcD        <= 4'b0000;
         shift_funcD      <= 2'b00;
         mult_funcD       <= 4'b0000;
         reg_dest_reg     <= `ZERO;
         c_source_reg     <= 3'b000;
      end else begin 
         if (~freeze_pipeline) begin
         end
      end
   end
   always @(pc_source or mem_source or mult_func or c_source_reg or c_bus or reg_dest_reg) begin
   end
endmodule