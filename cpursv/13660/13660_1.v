
module uut_32_top(output wire [31:0] res_o,
                  output wire [31:0] exp_o,
                  output wire [31:0] obs_o,
                  output wire val_o,
                  input  wire [31:0] data_i,
                  input  wire sof_i,
                  input  wire eof_i,
                  input  wire pclk_i);

  localparam  LO = 1'b0;
  localparam  HI = 1'b1;
  localparam [31:0]  ZEROS = {32{LO}};
  localparam [31:0]  ONES = {32{HI}};
  reg  [31:0] data_z1;
  reg  sof_z1;
  reg  [31:0] exp_z2;
  reg  [31:0] fcs_z2;
  reg  val_z2;
  reg  val_z3;
  reg  [31:0] exp_z3;
  reg  [31:0] fcs_z3;

  
  always @(posedge pclk_i)
      begin
        data_z1[31:0] <= data_i[31:0];
        sof_z1 <= sof_i;
        val_z2 <= eof_i;
        if (eof_i == HI) 
          begin
            exp_z2[31:0] <= data_i[31:0];
          end
          
        if (sof_z1 == HI) 
          begin
            fcs_z2[31:0] <= fcs32_32(data_z1[31:0],ONES[31:0]);
          end
        else 
          begin
            fcs_z2[31:0] <= fcs32_32(data_z1[31:0],fcs_z2[31:0]);
          end
        val_z3 <= val_z2;
        exp_z3[31:0] <= exp_z2[31:0];
        fcs_z3[31:0] <= fcs32_brev(fcs_z2[31:0]);
      end
  
  always @(*)
      begin
        val_o = val_z3;
        res_o[31:0] = fcs_z2[31:0];
        exp_o[31:0] = exp_z3[31:0];
        obs_o[31:0] = fcs_z3[31:0];
      end
endmodule

