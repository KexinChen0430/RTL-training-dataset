module RCLKINT (
    input A,       
    (* clkbuf_driver *) 
    output Y       
);
    assign Y = A;
endmodule