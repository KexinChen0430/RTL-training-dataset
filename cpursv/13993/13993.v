
module hardcopyiv_termination_logic(serialloadenable,terminationclock,parallelloadenable,
                                    terminationdata,devclrn,devpor,seriesterminationcontrol,
                                    parallelterminationcontrol);

  parameter  test_mode = "false";
  parameter  lpm_type = "hardcopyiv_termination_logic";
  input  serialloadenable;
  input  terminationclock;
  input  parallelloadenable;
  input  terminationdata;
  input  devclrn;
  input  devpor;
  output [13:0] seriesterminationcontrol;
  output [13:0] parallelterminationcontrol;
  tri1 devclrn;
  tri1 devpor;
  wire usr_clk;
  wire shift_clk;
  wire pload_clk;
  reg  [27:0] shift_reg;
  reg  [27:0] output_reg;

  assign seriesterminationcontrol = output_reg[27:14];
  assign parallelterminationcontrol = output_reg[13:0];
  assign #11 usr_clk = terminationclock;
  assign shift_clk = (serialloadenable === 1'b0) ? 1'b0 : usr_clk;
  assign pload_clk = (parallelloadenable === 1'b1) ? 1'b1 : 1'b0;
  
  initial  
  begin
    shift_reg = 'b0;
    output_reg = 'b0;
  end
  
  always @(posedge shift_clk)
      shift_reg <= {shift_reg[26:0],terminationdata};
  
  always @(posedge pload_clk)  output_reg <= shift_reg;
endmodule

