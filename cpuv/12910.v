module bsg_serial_in_parallel_out #(parameter `BSG_INV_PARAM(width_p) 
                                    , parameter `BSG_INV_PARAM(els_p) 
                                    , parameter out_els_p = els_p) 
   (input                 clk_i 
    , input               reset_i 
    , input               valid_i 
    , input [width_p-1:0] data_i 
    , output              ready_o 
    , output logic [out_els_p-1:0]                valid_o 
    , output logic [out_els_p-1:0][width_p-1:0]   data_o 
    , input  [$clog2(out_els_p+1)-1:0]        yumi_cnt_i 
    );
   localparam double_els_lp = els_p * 2; 
   logic [els_p-1:0][width_p-1:0] data_r, data_nn; 
   logic [2*els_p-1:0  ][width_p-1:0] data_n; 
   logic [els_p-1:0] 		  valid_r, valid_nn; 
   logic [double_els_lp-1:0] 	  valid_n; 
   logic [$clog2(els_p+1)-1:0]    num_els_r, num_els_n; 
   always_ff @(posedge clk_i) 
     begin
        if (reset_i) 
          begin
             num_els_r <= 0; 
             valid_r   <= 0; 
          end
        else 
          begin
             num_els_r <= num_els_n; 
             valid_r   <= valid_nn; 
          end
     end
  always_ff @(posedge clk_i) begin 
     data_r <= data_nn; 
  end
  assign ready_o = ~valid_r[els_p-1]; 
  assign num_els_n = (num_els_r + (valid_i & ready_o)) - yumi_cnt_i; 
  always_comb begin 
    data_n  = data_r; 
    valid_n = (double_els_lp) ' (valid_r); 
	  data_n[els_p+:els_p] = 0; 
    data_n [num_els_r] = data_i; 
    valid_n[num_els_r] = valid_i & ready_o; 
    valid_o = valid_n[out_els_p-1:0]; 
    data_o  = data_n [out_els_p-1:0]; 
	  for (integer i = 0; i < els_p; i++) begin 
	    data_nn[i] = data_n[yumi_cnt_i+i]; 
    end
	  valid_nn = valid_n[yumi_cnt_i+:els_p]; 
  end
endmodule