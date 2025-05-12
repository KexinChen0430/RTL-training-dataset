
module ifetch(clk,resetn,en,squashn,we,op,load,load_data,pc_out,next_pc,
              boot_iaddr,boot_idata,boot_iwe,opcode,rs,rt,rd,sa,offset,
              instr_index,func,instr);

  parameter  PC_WIDTH = 30;
  parameter  I_DATAWIDTH = 32;
  parameter  I_ADDRESSWIDTH = 14;
  parameter  I_SIZE = 16384;
  input  [31:0] boot_iaddr;
  input  [31:0] boot_idata;
  input  boot_iwe;
  input  clk;
  input  resetn;
  input  en;
  input  we;
  input  squashn;
  input  op;
  input  load;
  input  [I_DATAWIDTH+(0-1):0] load_data;
  output [I_DATAWIDTH+(0-1):0] pc_out;
  output [PC_WIDTH+(0-1):0] next_pc;
  output [31:26] opcode;
  output [25:21] rs;
  output [20:16] rt;
  output [15:11] rd;
  output [10:6] sa;
  output [15:0] offset;
  output [25:0] instr_index;
  output [5:0] func;
  input  [I_DATAWIDTH+(0-1):0] instr;
  wire [PC_WIDTH+(0-1):0] pc_plus_1;
  reg  [PC_WIDTH+(0-1):0] pc;
  wire ctrl_load;
  wire out_of_sync;

  assign ctrl_load = op | load;
  
  always @(posedge clk)
      begin
        if (~resetn) 
          begin
            pc <= 0;
          end
        else 
          begin
            if (we | en) 
              begin
                if (~ctrl_load & ~out_of_sync) 
                  begin
                    pc <= pc+1'b1;
                  end
                  
                if (ctrl_load) 
                  begin
                    pc <= load_data[I_DATAWIDTH+(0-1):1+1];
                  end
                  
              end
              
          end
      end
  assign {dummy,pc_plus_1} = {1'b0,~out_of_sync}+pc;
  assign pc_out = {pc_plus_1,2'b0};
  assign next_pc = ctrl_load ? load_data[I_DATAWIDTH+(0-1):1+1] : pc_plus_1;
  assign opcode = instr[31:26];
  assign rs = instr[25:21];
  assign rt = instr[20:16];
  assign rd = instr[15:11];
  assign sa = instr[10:6];
  assign offset = instr[15:0];
  assign instr_index = instr[25:0];
  assign func = instr[5:0];
endmodule

