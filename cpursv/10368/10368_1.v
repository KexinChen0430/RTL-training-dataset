
module uut_16_top(output wire [31:0] res_o,
                  output wire [31:0] exp_o,
                  output wire [31:0] obs_o,
                  output wire val_o,
                  input  wire [15:0] data_i,
                  input  wire sof_i,
                  input  wire eof_i,
                  input  wire pclk_i);

  localparam  LO = 1'b0;
  localparam  HI = 1'b1;
  localparam [31:0]  ZEROS = {32{LO}};
  localparam [31:0]  ONES = {32{HI}};
  reg  [15:0] data_z1;
  reg  sof_z1;
  reg  [15:0] data_z2;
  reg  sof_z2;
  reg  val_z3;
  reg  [31:0] exp_z3;
  reg  [31:0] fcs_z3;
  reg  val_z4;
  reg  [31:0] exp_z4;
  reg  [31:0] fcs_z4;
  reg  val_z5;
  reg  [31:0] exp_z5;
  reg  [31:0] fcs_z5;

  
  always @(posedge pclk_i)
      begin
        data_z1[15:0] <= data_i[15:0];
        sof_z1 <= sof_i;
        data_z2[15:0] <= data_z1[15:0];
        sof_z2 <= sof_z1;
        val_z3 <= eof_i;
        if (eof_i == HI) 
          begin
            exp_z3[31:0] <= {data_z1[15:0],data_i[15:0]};
          end
          
        if (sof_z2 == HI) 
          begin
            fcs_z3[31:0] <= fcs32_16(data_z2[15:0],ONES[31:0]);
          end
        else 
          begin
            fcs_z3[31:0] <= fcs32_16(data_z2[15:0],fcs_z3[31:0]);
          end
        val_z4 <= val_z3;
        exp_z4[31:0] <= exp_z3[31:0];
        fcs_z4[31:0] <= fcs32_brev(fcs_z3[31:0]);
        val_z5 <= val_z4;
        exp_z5[31:0] <= exp_z4[31:0];
        fcs_z5[31:0] <= fcs_z4[31:0];
      end
  
  always @(*)
      begin
        val_o = val_z5;
        res_o[31:0] = fcs_z3[31:0];
        exp_o[31:0] = exp_z5[31:0];
        obs_o[31:0] = fcs_z5[31:0];
      end
endmodule

