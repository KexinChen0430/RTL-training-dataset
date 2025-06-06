
module mem_arbiter(output wire [31:0] out_address,
                   output wire [31:0] out_din,
                   output wire out_re,
                   output wire out_we,
                   input  wire [31:0] os_address,
                   input  wire [31:0] os_din,
                   input  wire os_re,
                   input  wire os_we,
                   input  wire [31:0] mfind_address,
                   input  wire [31:0] mfind_din,
                   input  wire mfind_re,
                   input  wire mfind_we,
                   input  wire [31:0] intpr_address,
                   input  wire [31:0] intpr_din,
                   input  wire intpr_re,
                   input  wire intpr_we);

  reg  [1:0]  selection = 0;

  
  always @(os_re or os_we or mfind_re or mfind_we or intpr_re or intpr_we)
      begin
        if (os_we || os_re) 
          begin
            selection <= 2'd0;
          end
        else if (mfind_we || mfind_re) 
          begin
            selection <= 2'd1;
          end
        else if (intpr_re || intpr_we) 
          begin
            selection <= 2'd2;
          end
          
      end
  assign out_address = (selection == 0) ? os_address : 
                       (selection == 1) ? mfind_address : intpr_address;
  assign out_din = (selection == 0) ? os_din : 
                   (selection == 1) ? mfind_address : intpr_din;
  assign out_we = intpr_we || os_we || mfind_we;
  assign out_re = mfind_re || (intpr_re || os_re);
endmodule

