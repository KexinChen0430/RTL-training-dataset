
module DSP_PREADD(output [26:0] AD,
                  input  ADDSUB,
                  input  [26:0] D_DATA,
                  input  INMODE2,
                  input  [26:0] PREADD_AB);

  localparam  MODULE_NAME = DSP_PREADD;
  tri0  glblGSR = glbl.GSR;

  
  initial  
  begin
    $display("Error: [Unisim %s-100] SIMPRIM primitive is not intended for direct instantiation in RTL or functional netlists. This primitive is only available in the SIMPRIM library for implemented netlists, please ensure you are pointing to the correct library. Instance %m",
             MODULE_NAME);
    #1 $finish;
  end
  wire [26:0] D_DATA_mux;

  assign D_DATA_mux = INMODE2 ? D_DATA : 27'b0;
  assign AD = ADDSUB ? (D_DATA_mux-PREADD_AB) : (PREADD_AB+D_DATA_mux);
endmodule

