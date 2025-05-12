module tenv_test;
  reg[5:0]    int; 
  reg         clk; 
  reg         rst= 0; 
  reg[31:0]   mem_timing= 0; 
  wire[31:0]  pmem_adr; 
  wire[31:0]  dmem_adr; 
  wire[31:0]  dmem_dat_fromcpu; 
  wire        dmem_stb; 
  wire        dmem_we; 
  reg         test_active= 0; 
  reg[31:0]   test_counter= 0; 
  reg[31:0]   prog[(2**14)-1:0]; 
  integer     i; 
  localparam  PRINTPORT= 32'h1001_0000; 
  localparam  INTPORT= 32'h1002_0000; 
  localparam  block_name= "tenv_test"; 
  `include "tenv_test/start.v" 
  initial forever
    begin
    wait(test_active); 
    $timeformat(-9, 0, " ns", 10); 
    $write("\n\n"); 
    $write("%0t [%0s]: ",$realtime,block_name); 
    $write("Test of MIPS CPU.\n\n\n"); 
    $write("%0t [%0s]: ",$realtime,block_name); 
    $write("Load test program in program memory.\n"); 
    $readmemh({`TBDIR,"tprog/hex/main.txt"},prog); 
    for(i= 0; i<(2**tenv_pmain.WADDR); i= i+1) 
      begin
      tenv_pmain.i0.mem[i]= prog[i][7:0]; 
      tenv_pmain.i1.mem[i]= prog[i][15:8]; 
      tenv_pmain.i2.mem[i]= prog[i][23:16]; 
      tenv_pmain.i3.mem[i]= prog[i][31:24]; 
      end
    $readmemh({`TBDIR,"tprog/hex/exception.txt"},prog); 
    for(i= 0; i<(2**tenv_pexc.WADDR); i= i+1) 
      begin
      tenv_pexc.i0.mem[i]= prog[i][7:0]; 
      tenv_pexc.i1.mem[i]= prog[i][15:8]; 
      tenv_pexc.i2.mem[i]= prog[i][23:16]; 
      tenv_pexc.i3.mem[i]= prog[i][31:24]; 
      end
    mem_timing= 1; 
    repeat(4) 
    begin
    $write("\n"); 
    $write("%0t [%0s]: ",$realtime,block_name); 
    $write("Set memory timing to %0d CPU",mem_timing); 
    if(mem_timing==1) $write(" cycle.\n"); 
    else $write(" cycles.\n"); 
    $write("%0t [%0s]: ",$realtime,block_name); 
    $write("Reset CPU.\n"); 
    @(posedge clk); 
    rst= 1; 
    @(posedge clk); 
    rst= 0; 
    fork: L_FORK 
      forever 
        begin: L_LOOP 
        @(posedge clk); 
        while(!(dmem_adr==PRINTPORT & dmem_stb & dmem_we)) 
          @(posedge clk); 
        if(dmem_dat_fromcpu==32'hFFFF_FFFF & test_counter==24) 
          begin
          disable L_FORK; 
          end
        else if(dmem_dat_fromcpu==32'h0000_0000 | dmem_dat_fromcpu>30) 
          begin
          $write("\n\n"); 
          $write("%0t [%0s]: ",$realtime,block_name); 
          $write("Test is fail.\n\n\n"); 
          $finish; 
          end
        else 
          begin
          test_counter= dmem_dat_fromcpu; 
          $write("%0t [%0s]: ",$realtime,block_name); 
          $write("Subtest counter = %0d.\n",dmem_dat_fromcpu); 
          while(dmem_stb) @(posedge clk); 
          disable L_LOOP; 
          end
        end
      begin 
      repeat(1000_000) @(posedge clk); 
      $write("\n\n"); 
      $write("%0t [%0s]: ",$realtime,block_name); 
      $write("Test is fail.\n\n\n"); 
      $finish; 
      end
    join 
    mem_timing= mem_timing!=3 ? mem_timing+1 : 9; 
    end
    $write("\n\n"); 
    $write("%0t [%0s]: ",$realtime,block_name); 
    $write("Test is successfull.\n\n\n"); 
    test_active= 1'b0; 
    end
  initial
    begin
    clk=0; 
    forever #10 clk= ~clk; 
    end
  initial
    begin
    int= 5'd0; 
    @(negedge rst); 
    forever 
      begin
      @(posedge clk); 
      while(!(dmem_adr==INTPORT & dmem_stb & dmem_we)) 
        @(posedge clk); 
      int= dmem_dat_fromcpu[5:0]; 
      if(int!=0) 
        begin
        $write("%0t [%0s]: ",$realtime,block_name); 
        $write("Generate interrupt= 'b%b.\n",dmem_dat_fromcpu[5:0]); 
        end
      while(dmem_stb) @(posedge clk); 
      end
    end
endmodule