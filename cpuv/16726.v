module f3m_neg(a, c); 
    input [`WIDTH:0] a; 
    output [`WIDTH:0] c; 
    genvar i; 
    generate 
        for(i=0;i<=`WIDTH;i=i+2) 
          begin:label 
            assign c[i+1:i] = {a[i],a[i+1]}; 
          end 
    endgenerate 
endmodule 