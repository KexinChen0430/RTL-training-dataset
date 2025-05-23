module bsg_compare_and_swap #(parameter `BSG_INV_PARAM(width_p)
                             , parameter t_p = width_p-1
                             , parameter b_p = 0
                             , parameter cond_swap_on_equal_p=0)
(input    [1:0] [width_p-1:0] data_i
 , input  swap_on_equal_i
 , output logic [1:0] [width_p-1:0] data_o
 , output swapped_o
 );
   wire gt = data_i[0][t_p:b_p] > data_i[1][t_p:b_p];
   if (cond_swap_on_equal_p)
     begin
       wire eq = (data_i[0][t_p:b_p] == data_i[1][t_p:b_p]);
       assign swapped_o = gt | (eq & swap_on_equal_i);
     end
   else
     assign swapped_o = gt;
   always_comb
     begin
       if (swapped_o)
         data_o = { data_i[0], data_i[1] };
       else
         data_o = { data_i[1], data_i[0] };
     end
endmodule