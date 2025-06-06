
module mux_2_to_1(input  sel_i,
                  input  [1:0] dat_i,
                  output dat_o);

  assign dat_o = 
(dat_i[1] && 
(sel_i && 
(dat_i[0] || 
(dat_i[1] || (dat_i[0] && sel_i && ~sel_i))))) || 
                 (
(dat_i[0] || 
(dat_i[1] || (dat_i[0] && sel_i && ~sel_i))) && (~sel_i && (dat_i[0] || sel_i)));
endmodule

