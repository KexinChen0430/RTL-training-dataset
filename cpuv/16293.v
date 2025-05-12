module aurora_64b66b_0_rst_sync_shared
   # (
       parameter       c_init_val      = 1'b1, 
       parameter [4:0] c_mtbf_stages   = 3     
     )
     (
       input                           prmry_in,     
       input                           scndry_aclk,  
       output                          scndry_out    
      );
genvar i;
(* ASYNC_REG = "TRUE" *)(* shift_extract = "{no}"*)  reg  stg1_aurora_64b66b_0_cdc_to = c_init_val;
(* ASYNC_REG = "TRUE" *)(* shift_extract = "{no}"*)  reg  stg2 = c_init_val;
(* ASYNC_REG = "TRUE" *)(* shift_extract = "{no}"*)  reg  stg3 = c_init_val;
                        (* shift_extract = "{no}"*)  reg  stg4 = c_init_val;
                        (* shift_extract = "{no}"*)  reg  stg31 = c_init_val;
generate
always @(posedge scndry_aclk) 
begin
    stg1_aurora_64b66b_0_cdc_to <= `DLY prmry_in;
    stg2 <= `DLY stg1_aurora_64b66b_0_cdc_to;
    stg31 <= `DLY stg30;
end
if(c_mtbf_stages <= 3)  assign scndry_out = stg3;
if(c_mtbf_stages == 4)  assign scndry_out = stg4;
if(c_mtbf_stages == 31)  assign scndry_out = stg31;
endgenerate
endmodule 