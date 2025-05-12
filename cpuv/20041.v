module saturation_arith (inp, res); 
    parameter signed [31:0]  old_width = 4; 
    parameter signed [31:0]  old_bin_pt = 2; 
    parameter signed [31:0]  old_arith = `xlSigned; 
    parameter signed [31:0]  new_width = 4; 
    parameter signed [31:0]  new_bin_pt = 1; 
    parameter signed [31:0]  new_arith = `xlSigned; 
    input [old_width - 1 : 0] inp; 
    output [new_width - 1 : 0] res; 
    parameter signed [31:0]  abs_right_of_dp = (new_bin_pt > old_bin_pt) ? (new_bin_pt-old_bin_pt) : (old_bin_pt - new_bin_pt); 
    parameter signed [31:0]  abs_width = (new_width > old_width) ? (new_width-old_width) : 1; 
    parameter signed [31:0]  abs_new_width = (old_width > new_width) ? new_width : 1; 
    reg overflow; 
    reg [old_width-1:0] vec; 
    reg [new_width-1:0] result; 
    assign res = result; 
    generate 
      if (old_width > new_width) 
        begin:sa_u0
           always @ (inp) 
             begin
                vec = inp; 
                overflow = 1; 
             end
        end
   endgenerate
   generate 
      if (new_width > old_width) 
        begin:sa_u1
         always @ (inp) 
           begin
            vec = inp; 
           end
       end
   endgenerate
   generate 
      if (new_width == old_width) 
        begin:sa_u2
         always @ (inp) 
           begin
           end
        end
   endgenerate
endmodule