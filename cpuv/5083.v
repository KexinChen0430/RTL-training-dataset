module mips_exceptionUnit (
   exception_halt, load_ex_regs, load_bva, cause, load_bva_sel,
   pc, IBE, DBE, RI, Ov, BP, AdEL_inst, AdEL_data, AdES, CpU, clk,
   rst_b
   );