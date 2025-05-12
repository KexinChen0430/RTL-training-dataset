module sky130_fd_sc_ls__einvn (
    Z,    
    A,    
    TE_B  
);
    output Z;   
    input  A;   
    input  TE_B;
    notif0 notif00 (
        .Z(Z),     
        .A(A),     
        .TE_B(TE_B)
    );
endmodule 