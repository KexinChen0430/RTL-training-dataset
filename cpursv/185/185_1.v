
module test();

  reg  out_o;
  reg  inp_o;
  reg  ddr_o;
  reg  stb_o;
  wire q_i;
  reg  clk_o;
  reg  [7:0] scenario_o;

  GPIA_BIT_IN dut(.out_i(out_o),.inp_i(inp_o),.ddr_i(ddr_o),
                  .stb_i(stb_o),.q_o(q_i));
  
  always 
      begin
        #20 clk_o <= ~clk_o;
      end
  
  task waitclk;

    begin
      @(negedge clk_o)  ;
      @(posedge clk_o)  ;
    end
  endtask
  
  initial  
  begin
    scenario_o <= 8'h00;
    out_o <= 0;
    inp_o <= 0;
    ddr_o <= 0;
    stb_o <= 0;
    clk_o <= 0;
    $dumpfile(test.vcd);
    $dumpvars;
    @(posedge clk_o)  ;
    scenario_o <= 8'h10;
    waitclk;
    #2 
      if (q_i != 0) 
        begin
          $display("FAIL %x: Q not 0",scenario_o);
          $finish;
        end
        

    $display(PASS);
    $finish;
  end
endmodule

