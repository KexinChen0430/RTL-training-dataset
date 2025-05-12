module instr_cache
  (
   input                        clk, 
   input                        boot_done, 
   input [`ADDR_BITS-1:0]       instr_ptr, 
   output                       valid, 
   output reg [`INSTR_BITS-1:0] instr, 
   output reg                   mem_cmd_en, 
   output [2:0]                 mem_cmd_instr, 
   output [5:0]                 mem_cmd_bl, 
   output reg [29:0]            mem_cmd_byte_addr, 
   input                        mem_cmd_empty, 
   input                        mem_cmd_full, 
   output reg                   mem_rd_en, 
   input [31:0]                 mem_rd_data, 
   input                        mem_rd_full, 
   input                        mem_rd_empty, 
   input [6:0]                  mem_rd_count, 
   input                        mem_rd_overflow, 
   input                        mem_rd_error 
   );