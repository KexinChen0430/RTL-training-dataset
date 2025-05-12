module f3m_mux3(v1, l1, v2, l2, v3, l3, out);
    input [`WIDTH:0] v1, v2, v3;
    input l1, l2, l3;
    output [`WIDTH:0] out;
    genvar i;
    generate
        for(i=0;i<=`WIDTH;i=i+1)
          begin : label 
            assign out[i] = (v1[i] & l1) | (v2[i] & l2) | (v3[i] & l3);
          end
    endgenerate
endmodule