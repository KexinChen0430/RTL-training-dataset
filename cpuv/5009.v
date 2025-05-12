module mul_ppgen ( p_l, z, a, b, pm1_l );
    output p_l; 
    output z;   
    input a;          
    input pm1_l;      
    input [2:0] b;     
    assign p_l = ~((a ^ b[2]) & b[1]);
    assign z = b[0] ? ~pm1_l : ~p_l;
endmodule