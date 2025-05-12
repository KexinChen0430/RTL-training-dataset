
module decode_test();

  localparam  MEM_SIZE = 32;
  reg  clk;

  
  always   #10 clk = ~clk;
  reg  reset;

  reg  stall;

  reg  [31:0] insn;

  reg  [31:0] insn_address;

  reg  [7:0] sysreg_data_input;

  wire [4:0] reg_select;

  wire [4:0] rsa;

  wire [4:0] rsb;

  wire [4:0] rd;

  wire [20:0] imm;

  wire [3:0] aluop;

  wire jlnk;

  wire pc_change_relative;

  wire pc_change_absolute;

  wire mem_read;

  wire mem_write;

  wire nri_flag;

  wire [1:0] branch_funct;

  wire stall_output;

  wire memsync;

  wire syscall;

  wire permission_inc;

  wire permission_dec;

  wire [7:0] sysreg_addr;

  wire [7:0] sysreg_data;

  wire [31:0] insn_pc_output;

  wire [30:0] cp_insn;

  reg  [31:0] insn_mem[0:MEM_SIZE+(-1)];

  decode_32 decode_ut(.insn_in(insn),.reset_in(reset),.clk_in(clk),
                      .insn_pc_in(insn_address),.stall_in(stall),.reg_select_out(reg_select),
                      .rsa_out(rsa),.rsb_out(rsb),.rd_out(rd),.imm_out(imm),
                      .aluop_out(aluop),.jlnk_out(jlnk),
                      .pc_change_rel_out(pc_change_relative),.pc_change_abs_out(pc_change_absolute),
                      .mem_read_out(mem_read),.mem_write_out(mem_write),
                      .nri_flg_out(nri_flag),.branch_funct_out(branch_funct),
                      .stall_out(stall_output),.memsync_out(memsync),.syscall_out(syscall),
                      .pem_inc_req_out(permission_inc),.pem_dec_req_out(permission_dec),
                      .sysreg_addr_out(sysreg_addr),.sysreg_data_out(sysreg_data),
                      .sysreg_data_in(sysreg_data_input),.insn_pc_out(insn_pc_output),
                      .cp_insn_out(cp_insn));
  integer i;

  integer count;

  
  initial  
  begin
    $dumpfile(decode.vcd);
    $dumpvars(0,decode_test);
    $readmemh(test_insn.txt,insn_mem);
    for (i = 0; i < MEM_SIZE; i = i+1)
        begin
          $display("Data read from insn_mem: %h | address: %h",
                   insn_mem[i],i);
          #10 ;
        end
    #100 clk <= 1'b0; reset <= 1'b0;
    #10 
      stall <= 1'b0;
      insn_address <= 0;
      sysreg_data_input <= 8'b0;

    #10 reset <= 1'b1; count <= 0;
    #5 ;
    for (insn_address = 0; insn_address <= MEM_SIZE; insn_address = 1+insn_address)
        begin
          #20 ;
          insn <= insn_mem[insn_address];
          $display("Current Address: %h | Instruction: %h",
                   insn_address,insn);
        end
    $finish;
  end
endmodule

