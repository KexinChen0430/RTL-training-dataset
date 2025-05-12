
module BranchAdder(input  wire [31:0] pc_plus_four,
                   input  wire [31:0] extended_times_four,
                   output wire [31:0] branch_address);

  assign branch_address = extended_times_four+pc_plus_four;
endmodule

