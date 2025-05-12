module AND_ARRAY(O,A,B);
    parameter m=163; 
    input wire[0:m-1] A,B;
    output wire[0:m-1] O;
    AND a[0:m-1] (O,A,B);
endmodule